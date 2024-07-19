import 'package:anx_reader/widgets/reading_page/widget_title.dart';
import 'package:flutter/material.dart';

import 'package:anx_reader/models/book.dart';
import 'package:anx_reader/page/book_notes_page.dart';

import '../../generated/l10n.dart';

class ReadingNotes extends StatelessWidget {
  const ReadingNotes({super.key, required this.book});

  final Book book;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 550,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //widgetTitle( S.of(context).navBarNotes, null),
          Expanded(
            child: ListView(children: [bookNotesList(book.id)]),
          ),
        ],
      ),
    );
  }
}
