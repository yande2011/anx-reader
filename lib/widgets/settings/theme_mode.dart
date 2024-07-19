import 'package:anx_reader/utils/theme_mode_to_string.dart';
import 'package:flutter/material.dart';

import 'package:anx_reader/config/shared_preference_provider.dart';

import '../../generated/l10n.dart';

class ChangeThemeMode extends StatefulWidget {
  const ChangeThemeMode({Key? key}) : super(key: key);

  @override
  _ChangeThemeModeState createState() => _ChangeThemeModeState();
}

class _ChangeThemeModeState extends State<ChangeThemeMode> {
  late String _themeMode;

  @override
  void initState() {
    super.initState();
    _themeMode = themeModeToString(Prefs().themeMode);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _buildThemeModeButton('auto',  S.of(context).settings_system_mode),
        const SizedBox(width: 10),
        _buildThemeModeButton('dark',  S.of(context).settings_dark_mode),
        const SizedBox(width: 10),
        _buildThemeModeButton('light',  S.of(context).settings_light_mode),
      ],
    );
  }

  Widget _buildThemeModeButton(String mode, String text) {
    return Expanded(
      child: ElevatedButton(
        onPressed: () {
          Prefs().saveThemeModeToPrefs(mode);
          setState(() {
            _themeMode = mode;
          });
        },
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.pressed) ||
                  _themeMode == mode) {
                return Theme.of(context).colorScheme.primary;
              }
              return Theme.of(context).colorScheme.surface;
            },
          ),
          foregroundColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.pressed) ||
                  _themeMode == mode) {
                return Theme.of(context).colorScheme.onPrimary;
              }
              return Theme.of(context).colorScheme.onSurface;
            },
          ),
        ),
        child: Text(text),
      ),
    );
  }
}
