import 'package:anx_reader/l10n/localization_extension.dart';
import 'package:anx_reader/page/settings_page/appearance.dart';
import 'package:anx_reader/page/settings_page/sync.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../widgets/settings/about.dart';

class MoreSettings extends StatelessWidget {
  const MoreSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.settings),
      title: Text(context.settingsMoreSettings),
      trailing: const Icon(Icons.chevron_right),
      onTap: () {
        Navigator.push(
          context,
          CupertinoPageRoute(
              fullscreenDialog: false,
              builder: (context) => const SubMoreSettings()),
        );
      },
    );
  }
}

class SubMoreSettings extends StatefulWidget {
  const SubMoreSettings({super.key});

  @override
  State<SubMoreSettings> createState() => _SubMoreSettingsState();
}

class _SubMoreSettingsState extends State<SubMoreSettings> {
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
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(context.settingsMoreSettings),
      ),
      body: LayoutBuilder(builder: (context, constraints) {
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

  void setDetail(Widget Detail, int id) {
    setState(() {
      settingsDetail = Detail;
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
        About()
      ],
    );
  }
}
