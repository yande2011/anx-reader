import 'package:anx_reader/widgets/reading_page/widget_title.dart';
import 'package:anx_reader/models/toc_item.dart';
import 'package:anx_reader/page/book_player/epub_player.dart';
import 'package:flutter/material.dart';

import '../../generated/l10n.dart';


class TocWidget extends StatelessWidget {
  const TocWidget({
    super.key,
    required this.tocItems,
    required this.epubPlayerKey,
    required this.showOrHideAppBarAndBottomBar,
  });

  final List<TocItem> tocItems;
  final epubPlayerKey;
  final showOrHideAppBarAndBottomBar;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 700,
      child: Column(
        children: [
          // widgetTitle( S.of(context).reading_contents, null),
          Expanded(
            child: ListView.builder(
              itemCount: tocItems.length,
              itemBuilder: (context, index) {
                return TocItemWidget(
                    tocItem: tocItems[index],
                    epubPlayerKey: epubPlayerKey,
                showOrHideAppBarAndBottomBar: showOrHideAppBarAndBottomBar,);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class TocItemWidget extends StatefulWidget {
  final TocItem tocItem;
  final GlobalKey<EpubPlayerState> epubPlayerKey;
  final showOrHideAppBarAndBottomBar;

  const TocItemWidget(
      {super.key,
      required this.tocItem,
      required this.epubPlayerKey,
      required this.showOrHideAppBarAndBottomBar
      });

  @override
  _TocItemWidgetState createState() => _TocItemWidgetState();
}

class _TocItemWidgetState extends State<TocItemWidget> {
  bool _isExpanded = false;

  TextStyle tocStyle(content) => TextStyle(
        fontSize: 16,
        color: Theme.of(context).colorScheme.onSurface,
      );

  TextStyle tocStyleSelected(context) => TextStyle(
        fontSize: 20,
        color: Theme.of(context).colorScheme.primary,
        fontWeight: FontWeight.bold,
      );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // SizedBox(width: 1),
              TextButton(
                onPressed: () {
                  widget.epubPlayerKey.currentState!.goTo(widget.tocItem.href);
                  widget.showOrHideAppBarAndBottomBar(false);
                  Navigator.of(context).pop();
                },
                style: ButtonStyle(
                  padding: WidgetStateProperty.all(EdgeInsets.zero),
                  alignment: Alignment.centerLeft,
                ),
                child: Text(
                  '     ${widget.tocItem.label.trim()}',
                  style: _isSelected(widget.tocItem)
                      ? tocStyleSelected(context)
                      : tocStyle(context),
                ),
              ),
              if (widget.tocItem.subitems.isNotEmpty)
                IconButton(
                  icon:
                      Icon(_isExpanded ? Icons.expand_less : Icons.expand_more),
                  onPressed: () {
                    setState(() {
                      _isExpanded = !_isExpanded;
                    });
                  },
                ),
            ],
          ),
        ),
        if (_isExpanded)
          for (var subItem in widget.tocItem.subitems)
            Padding(
              padding: const EdgeInsets.only(left: 26.0),
              child: TocItemWidget(
                  tocItem: subItem,
                  epubPlayerKey: widget.epubPlayerKey,
              showOrHideAppBarAndBottomBar: widget.showOrHideAppBarAndBottomBar,),
            ),
        Divider(
            indent: 20,
            endIndent: 20,
            thickness: 1,
            color: Colors.grey.shade400),
      ],
    );
  }

  bool _isSelected(TocItem tocItem) {
    if (tocItem.href == widget.epubPlayerKey.currentState!.chapterHref) {
      return true;
    }
    for (var subItem in tocItem.subitems) {
      if (_isSelected(subItem)) {
        return true;
      }
    }
    return false;
  }
}
