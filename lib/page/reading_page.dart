import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:anx_reader/config/shared_preference_provider.dart';
import 'package:anx_reader/dao/reading_time.dart';
import 'package:anx_reader/dao/theme.dart';
import 'package:anx_reader/models/book.dart';
import 'package:anx_reader/models/book_style.dart';
import 'package:anx_reader/models/read_theme.dart';
import 'package:anx_reader/page/book_player/epub_player.dart';
import 'package:anx_reader/utils/ui/status_bar.dart';
import 'package:anx_reader/widgets/reading_page/book_drawer.dart';
import 'package:anx_reader/models/reading_time.dart';
import 'package:anx_reader/models/toc_item.dart';
import 'package:anx_reader/utils/generate_index_html.dart';
import 'package:anx_reader/widgets/reading_page/progress_widget.dart';
import 'package:anx_reader/widgets/reading_page/style_widget.dart';
import 'package:anx_reader/widgets/reading_page/theme_widget.dart';
import 'package:flutter/material.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

import '../generated/l10n.dart';
import '../widgets/settings/BrightnessDialog.dart';

class ReadingPage extends StatefulWidget {
  final Book book;

  const ReadingPage({super.key, required this.book});

  @override
  State<ReadingPage> createState() => ReadingPageState();
}

final GlobalKey<ReadingPageState> readingPageKey =
    GlobalKey<ReadingPageState>();

class ReadingPageState extends State<ReadingPage> with WidgetsBindingObserver {
  late Book _book;
  String? _content;
  late BookStyle _bookStyle;
  late ReadTheme _readTheme;

  double readProgress = 0.0;
  List<TocItem> _tocItems = [];
  Widget _currentPage = const SizedBox(height: 1);
  final _epubPlayerKey = GlobalKey<EpubPlayerState>();
  final Stopwatch _readTimeWatch = Stopwatch();
  Timer? _awakeTimer;
  bool _showAppAndBottomBar = false;
  int bookDrawIndex = 0;
  String? _currentText;
  bool _isScrollMode = false;


  @override
  void initState() {
    if (Prefs().hideStatusBar) {
      hideStatusBar();
    }
    WidgetsBinding.instance.addObserver(this);
    _readTimeWatch.start();
    setAwakeTimer(Prefs().awakeTime);

    _book = widget.book;
    _bookStyle = Prefs().bookStyle;
    _readTheme = Prefs().readTheme;
    _isScrollMode = Prefs().isScrollMode;
    loadContent();
    super.initState();
  }

  @override
  void dispose() {
    _readTimeWatch.stop();
    _awakeTimer?.cancel();
    WakelockPlus.disable();
    showStatusBar();
    WidgetsBinding.instance.removeObserver(this);
    insertReadingTime(ReadingTime(
        bookId: _book.id, readingTime: _readTimeWatch.elapsed.inSeconds));
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.paused) {
      _readTimeWatch.stop();
    } else if (state == AppLifecycleState.resumed) {
      _readTimeWatch.start();
    }
  }

  Future<void> setAwakeTimer(int minutes) async {
    _awakeTimer?.cancel();
    _awakeTimer = null;
    WakelockPlus.enable();
    _awakeTimer = Timer.periodic(Duration(minutes: minutes), (timer) {
      WakelockPlus.disable();
      _awakeTimer?.cancel();
      _awakeTimer = null;
    });
  }

  void loadContent() {
    var content = generateIndexHtml(
        widget.book, _bookStyle, _readTheme, _isScrollMode, widget.book.lastReadPosition);
    setState(() {
      _content = content;
    });
  }

  void setCurrentText(String text) {
    setState(() {
      _currentText = text;
    });
  }

  void showOrHideAppBarAndBottomBar(bool show) {

      // showBottomBar(context);
      setState(() {
        readProgress = _epubPlayerKey.currentState!.progress;
        _showAppAndBottomBar = !_showAppAndBottomBar;
      });

  }

  void _showDrawer(BuildContext context, int index) {
    Navigator.of(context).push(
      PageRouteBuilder(
        opaque: false,
        pageBuilder: (BuildContext context, _, __) {
          return BookDrawer(tocItems: _tocItems, epubPlayerKey: _epubPlayerKey, showOrHideAppBarAndBottomBar: showOrHideAppBarAndBottomBar,currentPage: index, book: _book,);
        },
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          var begin = Offset(-1.0, 0.0);
          var end = Offset.zero;
          var curve = Curves.ease;
          var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
      ),
    );
  }

  void _showSwitchDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('切换视图模式'),
          content: Text(_isScrollMode ? '已切换到翻页模式' : '已切换到滚动模式'),
          actions: <Widget>[
            TextButton(
              child: Text('确定'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> tocHandler() async {
    String toc = await _epubPlayerKey.currentState!.getToc();
    setState(() {
      _tocItems =
          (json.decode(toc) as List).map((i) => TocItem.fromJson(i)).toList();
      _showDrawer(context, 0);
    });
  }

  void noteHandler() {
    // setState(() {
    //   _currentPage = ReadingNotes(book: _book);
    // });
    _showDrawer(context, 1);
  }

  void progressHandler() {
    readProgress = _epubPlayerKey.currentState!.progress;
    setState(() {
      _currentPage = ProgressWidget(
        epubPlayerKey: _epubPlayerKey,
        showOrHideAppBarAndBottomBar: showOrHideAppBarAndBottomBar,
        readProgress: readProgress,
      );
    });
  }

  Future<void> changeTheme(BuildContext context) async {
    List<ReadTheme> themes = await selectThemes();
    ThemeMode current = Theme.of(context).brightness == Brightness.dark
        ? ThemeMode.dark
        : ThemeMode.light;
    if (current == ThemeMode.dark) {
      await Prefs().saveThemeModeToPrefs("light");
    } else {
      await Prefs().saveThemeModeToPrefs("dark");
    }
    setState(() {
      if (current == ThemeMode.dark) {
        _readTheme = themes[0];
      } else {
        _readTheme = themes[1];
      }
      Prefs().saveReadThemeToPrefs(_readTheme);
      _epubPlayerKey.currentState!.changeTheme(_readTheme);
    });

  }

  Future<void> themeHandler(StateSetter modalSetState) async {
    List<ReadTheme> themes = await selectThemes();
    modalSetState(() {
      _currentPage = ThemeWidget(
        themes: themes,
        epubPlayerKey: _epubPlayerKey,
        setCurrentPage: (Widget page) {
          modalSetState(() {
            _currentPage = page;
          });
        },
      );
    });
  }

  void showStyleDialog(BuildContext context, GlobalKey<EpubPlayerState> epubPlayerKey) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(S.of(context).reading_page_style),
          content: SingleChildScrollView(
            child: StyleWidget(epubPlayerKey: epubPlayerKey),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(S.of(context).common_ok),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
  Future<void> styleHandler() async {
    // setState(() {
    //   _currentPage = StyleWidget(
    //     epubPlayerKey: _epubPlayerKey,
    //   );
    // });
    showStyleDialog(context, _epubPlayerKey);
  }

  void showBrightnessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return BrightnessDialog();
      },
    );
  }

  void showBottomBar(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return IntrinsicHeight(
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  Expanded(child: _currentPage),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.toc),
                        onPressed: () {
                          tocHandler();
                          setState(() {});
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.edit_note),
                        onPressed: () {
                          noteHandler();
                          setState(() {});
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.data_usage),
                        onPressed: () {
                          progressHandler();
                          setState(() {});
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.color_lens),
                        onPressed: () {
                          themeHandler(setState);
                          setState(() {});
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.text_fields),
                        onPressed: () {
                          styleHandler();
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    ).then((value) {
      setState(() {
        _currentPage = const SizedBox(height: 1);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_content == null) {
      return const Center(child: CircularProgressIndicator());
    } else {
      return PopScope(
        canPop: false,
        onPopInvoked: (bool didPop) async {
          if (didPop) return;
          String cfi = await _epubPlayerKey.currentState!.onReadingLocation();
          double readProgress = _epubPlayerKey.currentState!.progress;
          Map<String, dynamic> result = {
            'cfi': cfi,
            'readProgress': readProgress,
          };
          Navigator.pop(context, result);
        },
        child: Scaffold(
          body: Stack(
            children: [
              EpubPlayer(
                key: _epubPlayerKey,
                content: _content!,
                bookId: _book.id,
                showOrHideAppBarAndBottomBar: showOrHideAppBarAndBottomBar,
                onTextChanged: setCurrentText,
              ),
              if (_showAppAndBottomBar)
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: 60,
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.grey[800] : Colors.blueAccent,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        IconButton(onPressed: () {
                          Navigator.pop(context);
                        }, icon: const Icon(Icons.arrow_back_outlined, color: Colors.white,)),
                        Text(_book.title, style: const TextStyle(color: Colors.white),),
                        IconButton(onPressed: (){}, icon: const Icon(Icons.more_vert, color: Colors.white,))
                      ]
                    )
                  )
                )
              ,

              if (_showAppAndBottomBar)
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: 120,
                    color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.grey[800] : Colors.grey[100],
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ProgressWidget(epubPlayerKey: _epubPlayerKey, showOrHideAppBarAndBottomBar: showOrHideAppBarAndBottomBar, readProgress: readProgress),
                        // Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                        //   IconButton(
                        //     icon: const Icon(Icons.keyboard_arrow_left),
                        //     onPressed: () {
                        //       progressHandler();
                        //     },
                        //   ),
                        //   Slider(
                        //     value: 20,
                        //     min: 0.0,
                        //     max: 100.0,
                        //     divisions: 100,
                        //     label: '20%',
                        //     onChanged: (double value) {
                        //       setState(() {
                        //       });
                        //     },
                        //   ),
                        //   IconButton(
                        //     icon: const Icon(Icons.keyboard_arrow_right),
                        //     onPressed: () {
                        //       progressHandler();
                        //     },
                        //   ),
                        // ],),
                        Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            IconButton(
                              icon: Icon(
                                Theme.of(context).brightness == Brightness.light
                                    ? Icons.light_mode : Icons.dark_mode
                              ),
                              onPressed: ()  {
                                // 切换主题的逻辑
                                changeTheme(context);
                              },
                            ),
                            // IconButton(
                            //   icon: Icon(Icons.keyboard_voice),
                            //   onPressed: () async {
                            //     //
                            //     await speakHandler();
                            //   },
                            // ),
                            IconButton(
                              icon: Icon(_isScrollMode ?  Icons.view_agenda_sharp : Icons.view_carousel),
                              onPressed: () async {
                                await _epubPlayerKey.currentState!.switchMode(!_isScrollMode);
                                await Prefs().saveScrollMode(!_isScrollMode);
                                setState(() {
                                  _isScrollMode = !_isScrollMode;
                                });
                                //_showSwitchDialog();
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.menu_book),
                              onPressed: () {
                                tocHandler();
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.bookmark),
                              onPressed: () {
                                noteHandler();
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.brightness_high),
                              onPressed: () {
                                showBrightnessDialog(context);
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.format_size),
                              onPressed: () {
                                styleHandler();
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.power_settings_new_sharp),
                              onPressed: () {
                                exit(0);
                              }
                            )
                          ]
                        )
                      ]
                    )
                  )
                )
            ],
          ),
        ),
      );
    }
  }

  // Future<void> speakHandler() async {
  //     if (flutterTts == null) {
  //       flutterTts = FlutterTts();
  //       if (Platform.isIOS) {
  //         await flutterTts?.setSharedInstance(true);
  //         await flutterTts?.setIosAudioCategory(IosTextToSpeechAudioCategory.ambient,
  //             [
  //               IosTextToSpeechAudioCategoryOptions.allowBluetooth,
  //               IosTextToSpeechAudioCategoryOptions.allowBluetoothA2DP,
  //               IosTextToSpeechAudioCategoryOptions.mixWithOthers
  //             ],
  //             IosTextToSpeechAudioMode.voicePrompt
  //         );
  //       }
  //       flutterTts?.speak(_currentText!);
  //     }
  // }
}
