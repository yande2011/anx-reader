import 'package:anx_reader/widgets/settings/theme_mode.dart';
import 'package:flutter/material.dart';

import '../../generated/l10n.dart';
import '../settings_page/advanced.dart';
import '../settings_page/appearance.dart';
import '../settings_page/sync.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  int selectedIndex = 0;
  late Widget settingsDetail;

  @override
  void initState() {
    super.initState();
    settingsDetail = const SubAppearanceSettings(isMobile: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).settings),
      ),
      body:  LayoutBuilder(builder: (context, constraints) {
        if (constraints.maxWidth > 600) {
          return Row(
            children: [
              Expanded(
                flex: 1,
                child: settingsList(false),
              ),
              const VerticalDivider(thickness: 1, width: 1),
              Expanded(
                flex: 2,
                child: settingsDetail,
              ),
            ],
          );
        } else {
          return settingsList(true);
        }
      }),
    );
  }

  void setDetail(Widget detail, int id) {
    setState(() {
      settingsDetail = detail;
      selectedIndex = id;
    });
  }

  Widget settingsList(bool isMobile) {
    return ListView(
      children: [
        AppearanceSetting(
          isMobile: isMobile,
          id: 0,
          selectedIndex: selectedIndex,
          setDetail: setDetail,
        ),
        SyncSetting(
          isMobile: isMobile,
          id: 1,
          selectedIndex: selectedIndex,
          setDetail: setDetail,
        ),
        AdvancedSetting(
            isMobile: isMobile,
            id: 2,
            selectedIndex: selectedIndex,
            setDetail: setDetail),
      ],
    );
  }
}
