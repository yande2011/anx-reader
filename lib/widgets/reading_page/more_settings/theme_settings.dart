import 'package:anx_reader/config/shared_preference_provider.dart';
import 'package:anx_reader/utils/ui/status_bar.dart';
import 'package:anx_reader/widgets/reading_page/more_settings/page_turning/diagram.dart';
import 'package:anx_reader/widgets/reading_page/more_settings/page_turning/types_and_icons.dart';
import 'package:flutter/material.dart';

import '../../../generated/l10n.dart';

Widget themeSettings = StatefulBuilder(
  builder: (context, setState) => SingleChildScrollView(
    child: Container(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          fullScreen(context, setState),
          pageTurningControl(),
        ],
      ),
    ),
  ),
);

ListTile fullScreen(BuildContext context, StateSetter setState) {
  return ListTile(
    leading: Checkbox(
        value: Prefs().hideStatusBar,
        onChanged: (bool? value) => setState(() {
              Prefs().saveHideStatusBar(value!);
              if (value) {
                hideStatusBar();
              } else {
                showStatusBar();
              }
            })),
    title: Text( S.of(context).reading_page_full_screen),
  );
}

Widget pageTurningControl() {
  int currentType = Prefs().pageTurningType;

  return StatefulBuilder(builder: (
    BuildContext context,
    void Function(void Function()) setState,
  ) {
    void onTap(int index) {
      setState(() {
        Prefs().pageTurningType = index;
        currentType = index;
      });
    }

    return ListTile(
      title: Text( S.of(context).reading_page_page_turning_method),
      subtitle: SizedBox(
        height: 120,
        child: ListView.builder(
          itemCount: pageTurningTypes.length,
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: getPageTurningDiagram(context, pageTurningTypes[index],
                  pageTurningIcons[index], currentType == index, () {
                onTap(index);
              }),
            );
          },
        ),
      ),
    );
  });
}
