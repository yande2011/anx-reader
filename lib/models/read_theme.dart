import 'dart:convert';
import 'dart:core';

import 'package:flutter/material.dart';

class ReadTheme {
  int? id;
  String backgroundColor;
  String textColor;
  String backgroundImagePath;

  static ReadTheme dark = ReadTheme(
      id: 1,
      backgroundColor: "ff040404",
      textColor: "fffeffeb",
      backgroundImagePath: '');

  static ReadTheme light = ReadTheme(
      id: 2,
      backgroundColor: 'fffbfbf3',
      textColor: 'ff343434',
      backgroundImagePath: '');

  ReadTheme(
      {this.id,
      required this.backgroundColor,
      required this.textColor,
      required this.backgroundImagePath});

  Map<String, Object?> toMap() {
    return {
      'background_color': backgroundColor,
      'text_color': textColor,
      'background_image_path': backgroundImagePath
    };
  }

  String toJson() {
    return '''
    {
      "id": $id,
      "backgroundColor": "$backgroundColor",
      "textColor": "$textColor",
      "backgroundImagePath": "$backgroundImagePath"
    }
    ''';
  }

  factory ReadTheme.fromJson(String json) {
    Map<String, dynamic> data = jsonDecode(json);
    return ReadTheme(
        id: data['id'],
        backgroundColor: data['backgroundColor'],
        textColor: data['textColor'],
        backgroundImagePath: data['backgroundImagePath']);
  }
}
