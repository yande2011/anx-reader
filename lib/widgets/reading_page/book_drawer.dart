import 'package:anx_reader/models/book.dart';
import 'package:anx_reader/widgets/reading_page/notes_widget.dart';
import 'package:anx_reader/widgets/reading_page/toc_widget.dart';
import 'package:flutter/material.dart';

import '../../models/toc_item.dart';
import '../../page/book_player/epub_player.dart';

class BookDrawer extends StatefulWidget {
  List<TocItem> _tocItems;
  final epubPlayerKey;
  final Book book;
  final void Function(bool show) showOrHideAppBarAndBottomBar;
  final int currentPage;
  BookDrawer({
    required List<TocItem> tocItems,
    required GlobalKey<EpubPlayerState> epubPlayerKey,
    required Book book,
    required void Function(bool show) showOrHideAppBarAndBottomBar,
    required int currentPage,
  })  : _tocItems = tocItems,
        epubPlayerKey = epubPlayerKey,
        book = book,
        currentPage = currentPage,
        showOrHideAppBarAndBottomBar = showOrHideAppBarAndBottomBar;

  @override
  _BookDrawerState createState() => _BookDrawerState();
}

class _BookDrawerState extends State<BookDrawer> {
  bool _isReversed = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      child: DefaultTabController(
        length: 2,
        initialIndex: widget.currentPage,
        child: Scaffold(
          appBar: AppBar(
            title: TabBar(
                    tabs: [
                      Tab(text: '目录'),
                      Tab(text: '书签'),
                    ],
                  ),
                ),
                // IconButton(
                //   icon: Icon(Icons.swap_vert),
                //   onPressed: () {
                //     setState(() {
                //       _isReversed = !_isReversed;
                //     });
                //   },
                // ),
          body: TabBarView(
            children: [
              _buildContentList(),
              _buildBookmarkList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContentList() {
    return TocWidget(tocItems: widget._tocItems, epubPlayerKey: widget.epubPlayerKey, showOrHideAppBarAndBottomBar: widget.showOrHideAppBarAndBottomBar);
    List<String> contents = ['第一章', '第二章', '第三章', '第四章', '第五章'];
    if (_isReversed) {
      contents = contents.reversed.toList();
    }
    return ListView.builder(
      itemCount: contents.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(contents[index]),
          onTap: () {
            // 处理目录项点击
          },
        );
      },
    );
  }

  Widget _buildBookmarkList() {
    return ReadingNotes(book: widget.book);
    return ListView.builder(
      itemCount: 3,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text('书签 ${index + 1}'),
          onTap: () {
            // 处理书签点击
          },
        );
      },
    );
  }
}