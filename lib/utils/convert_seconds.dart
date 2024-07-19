import 'package:anx_reader/main.dart';
import 'package:flutter/cupertino.dart';

import '../generated/l10n.dart';

BuildContext context = navigatorKey.currentContext!;

String convertSeconds(int seconds) {
  final int hours = seconds ~/ 3600;
  final int minutes = (seconds % 3600) ~/ 60;
  final int second = seconds % 60;
  if (hours > 0) {
    return '${hours.toString()} ${ S.of(context).common_hours} ${minutes.toString()} ${ S.of(context).common_minutes}';
  } else if (minutes > 0) {
    return '${minutes.toString()} ${ S.of(context).common_minutes_full}';
  } else {
    return '${second.toString()} ${ S.of(context).common_seconds_full}';
  }
}
