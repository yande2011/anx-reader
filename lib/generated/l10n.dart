// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Anx Reader`
  String get appName {
    return Intl.message(
      'Anx Reader',
      name: 'appName',
      desc: '',
      args: [],
    );
  }

  /// `About Anx Reader`
  String get app_about {
    return Intl.message(
      'About Anx Reader',
      name: 'app_about',
      desc: '',
      args: [],
    );
  }

  /// `Version`
  String get app_version {
    return Intl.message(
      'Version',
      name: 'app_version',
      desc: '',
      args: [],
    );
  }

  /// `License`
  String get app_license {
    return Intl.message(
      'License',
      name: 'app_license',
      desc: '',
      args: [],
    );
  }

  /// `Author`
  String get app_author {
    return Intl.message(
      'Author',
      name: 'app_author',
      desc: '',
      args: [],
    );
  }

  /// `Book Store`
  String get navBar_store {
    return Intl.message(
      'Book Store',
      name: 'navBar_store',
      desc: '',
      args: [],
    );
  }

  /// `Bookshelf`
  String get navBarBookshelf {
    return Intl.message(
      'Bookshelf',
      name: 'navBarBookshelf',
      desc: '',
      args: [],
    );
  }

  /// `Statistics`
  String get navBarStatistics {
    return Intl.message(
      'Statistics',
      name: 'navBarStatistics',
      desc: '',
      args: [],
    );
  }

  /// `Notes`
  String get navBarNotes {
    return Intl.message(
      'Notes',
      name: 'navBarNotes',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get navBarSettings {
    return Intl.message(
      'Settings',
      name: 'navBarSettings',
      desc: '',
      args: [],
    );
  }

  /// `Dark`
  String get settings_dark_mode {
    return Intl.message(
      'Dark',
      name: 'settings_dark_mode',
      desc: '',
      args: [],
    );
  }

  /// `Light`
  String get settings_light_mode {
    return Intl.message(
      'Light',
      name: 'settings_light_mode',
      desc: '',
      args: [],
    );
  }

  /// `System`
  String get settings_system_mode {
    return Intl.message(
      'System',
      name: 'settings_system_mode',
      desc: '',
      args: [],
    );
  }

  /// `More Settings`
  String get settings_moreSettings {
    return Intl.message(
      'More Settings',
      name: 'settings_moreSettings',
      desc: '',
      args: [],
    );
  }

  /// `Appearance`
  String get settings_appearance {
    return Intl.message(
      'Appearance',
      name: 'settings_appearance',
      desc: '',
      args: [],
    );
  }

  /// `Theme`
  String get settings_appearance_theme {
    return Intl.message(
      'Theme',
      name: 'settings_appearance_theme',
      desc: '',
      args: [],
    );
  }

  /// `Theme Color`
  String get settings_appearance_themeColor {
    return Intl.message(
      'Theme Color',
      name: 'settings_appearance_themeColor',
      desc: '',
      args: [],
    );
  }

  /// `Display`
  String get settings_appearance_display {
    return Intl.message(
      'Display',
      name: 'settings_appearance_display',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get settings_appearance_language {
    return Intl.message(
      'Language',
      name: 'settings_appearance_language',
      desc: '',
      args: [],
    );
  }

  /// `Contents`
  String get reading_contents {
    return Intl.message(
      'Contents',
      name: 'reading_contents',
      desc: '',
      args: [],
    );
  }

  /// `To Present`
  String get statistic_to_present {
    return Intl.message(
      'To Present',
      name: 'statistic_to_present',
      desc: '',
      args: [],
    );
  }

  /// `books read`
  String get statistic_books_read {
    return Intl.message(
      'books read',
      name: 'statistic_books_read',
      desc: '',
      args: [],
    );
  }

  /// `days read`
  String get statistic_days_of_reading {
    return Intl.message(
      'days read',
      name: 'statistic_days_of_reading',
      desc: '',
      args: [],
    );
  }

  /// `notes`
  String get statistic_notes {
    return Intl.message(
      'notes',
      name: 'statistic_notes',
      desc: '',
      args: [],
    );
  }

  /// `week`
  String get statistic_week {
    return Intl.message(
      'week',
      name: 'statistic_week',
      desc: '',
      args: [],
    );
  }

  /// `month`
  String get statistic_month {
    return Intl.message(
      'month',
      name: 'statistic_month',
      desc: '',
      args: [],
    );
  }

  /// `year`
  String get statistic_year {
    return Intl.message(
      'year',
      name: 'statistic_year',
      desc: '',
      args: [],
    );
  }

  /// `This Week`
  String get statistic_this_week {
    return Intl.message(
      'This Week',
      name: 'statistic_this_week',
      desc: '',
      args: [],
    );
  }

  /// `Mn`
  String get statistic_monday {
    return Intl.message(
      'Mn',
      name: 'statistic_monday',
      desc: '',
      args: [],
    );
  }

  /// `Tu`
  String get statistic_tuesday {
    return Intl.message(
      'Tu',
      name: 'statistic_tuesday',
      desc: '',
      args: [],
    );
  }

  /// `Wd`
  String get statistic_wednesday {
    return Intl.message(
      'Wd',
      name: 'statistic_wednesday',
      desc: '',
      args: [],
    );
  }

  /// `Th`
  String get statistic_thursday {
    return Intl.message(
      'Th',
      name: 'statistic_thursday',
      desc: '',
      args: [],
    );
  }

  /// `Fr`
  String get statistic_friday {
    return Intl.message(
      'Fr',
      name: 'statistic_friday',
      desc: '',
      args: [],
    );
  }

  /// `Sa`
  String get statistic_saturday {
    return Intl.message(
      'Sa',
      name: 'statistic_saturday',
      desc: '',
      args: [],
    );
  }

  /// `Su`
  String get statistic_sunday {
    return Intl.message(
      'Su',
      name: 'statistic_sunday',
      desc: '',
      args: [],
    );
  }

  /// `Notes Across`
  String get notes_notes_across {
    return Intl.message(
      'Notes Across',
      name: 'notes_notes_across',
      desc: '',
      args: [],
    );
  }

  /// `Books`
  String get notes_books {
    return Intl.message(
      'Books',
      name: 'notes_books',
      desc: '',
      args: [],
    );
  }

  /// `Notes`
  String get notes_notes {
    return Intl.message(
      'Notes',
      name: 'notes_notes',
      desc: '',
      args: [],
    );
  }

  /// `minutes`
  String get notes_minutes {
    return Intl.message(
      'minutes',
      name: 'notes_minutes',
      desc: '',
      args: [],
    );
  }

  /// `Copy`
  String get reading_page_copy {
    return Intl.message(
      'Copy',
      name: 'reading_page_copy',
      desc: '',
      args: [],
    );
  }

  /// `Excerpt`
  String get reading_page_excerpt {
    return Intl.message(
      'Excerpt',
      name: 'reading_page_excerpt',
      desc: '',
      args: [],
    );
  }

  /// `Theme`
  String get reading_page_theme {
    return Intl.message(
      'Theme',
      name: 'reading_page_theme',
      desc: '',
      args: [],
    );
  }

  /// `Style`
  String get reading_page_style {
    return Intl.message(
      'Style',
      name: 'reading_page_style',
      desc: '',
      args: [],
    );
  }

  /// `Full Screen`
  String get reading_page_full_screen {
    return Intl.message(
      'Full Screen',
      name: 'reading_page_full_screen',
      desc: '',
      args: [],
    );
  }

  /// `Screen Timeout`
  String get reading_page_screen_timeout {
    return Intl.message(
      'Screen Timeout',
      name: 'reading_page_screen_timeout',
      desc: '',
      args: [],
    );
  }

  /// `Page Turning Method`
  String get reading_page_page_turning_method {
    return Intl.message(
      'Page Turning Method',
      name: 'reading_page_page_turning_method',
      desc: '',
      args: [],
    );
  }

  /// `There are no books.`
  String get bookshelf_tips_1 {
    return Intl.message(
      'There are no books.',
      name: 'bookshelf_tips_1',
      desc: '',
      args: [],
    );
  }

  /// `Click the add button to add a book!`
  String get bookshelf_tips_2 {
    return Intl.message(
      'Click the add button to add a book!',
      name: 'bookshelf_tips_2',
      desc: '',
      args: [],
    );
  }

  /// `This week you have read`
  String get statistics_tips_1 {
    return Intl.message(
      'This week you have read',
      name: 'statistics_tips_1',
      desc: '',
      args: [],
    );
  }

  /// `A book is a dream that you hold in your hands.`
  String get statistics_tips_2 {
    return Intl.message(
      'A book is a dream that you hold in your hands.',
      name: 'statistics_tips_2',
      desc: '',
      args: [],
    );
  }

  /// `There are no notes.`
  String get notes_tips_1 {
    return Intl.message(
      'There are no notes.',
      name: 'notes_tips_1',
      desc: '',
      args: [],
    );
  }

  /// `Add a note while reading!`
  String get notes_tips_2 {
    return Intl.message(
      'Add a note while reading!',
      name: 'notes_tips_2',
      desc: '',
      args: [],
    );
  }

  /// `Chapter Pages`
  String get reading_page_chapter_pages {
    return Intl.message(
      'Chapter Pages',
      name: 'reading_page_chapter_pages',
      desc: '',
      args: [],
    );
  }

  /// `Current Page`
  String get reading_page_current_page {
    return Intl.message(
      'Current Page',
      name: 'reading_page_current_page',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get bookDetailSave {
    return Intl.message(
      'Save',
      name: 'bookDetailSave',
      desc: '',
      args: [],
    );
  }

  /// `Edit`
  String get bookDetailEdit {
    return Intl.message(
      'Edit',
      name: 'bookDetailEdit',
      desc: '',
      args: [],
    );
  }

  /// `th book read`
  String get bookDetailNthBook {
    return Intl.message(
      'th book read',
      name: 'bookDetailNthBook',
      desc: '',
      args: [],
    );
  }

  /// `Last read: `
  String get bookDetailLastReadDate {
    return Intl.message(
      'Last read: ',
      name: 'bookDetailLastReadDate',
      desc: '',
      args: [],
    );
  }

  /// `Import date: `
  String get bookDetailImportDate {
    return Intl.message(
      'Import date: ',
      name: 'bookDetailImportDate',
      desc: '',
      args: [],
    );
  }

  /// `Detail`
  String get notes_page_detail {
    return Intl.message(
      'Detail',
      name: 'notes_page_detail',
      desc: '',
      args: [],
    );
  }

  /// `Export`
  String get notes_page_export {
    return Intl.message(
      'Export',
      name: 'notes_page_export',
      desc: '',
      args: [],
    );
  }

  /// `Copied`
  String get notes_page_copied {
    return Intl.message(
      'Copied',
      name: 'notes_page_copied',
      desc: '',
      args: [],
    );
  }

  /// `Exported to`
  String get notes_page_exported_to {
    return Intl.message(
      'Exported to',
      name: 'notes_page_exported_to',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get common_delete {
    return Intl.message(
      'Delete',
      name: 'common_delete',
      desc: '',
      args: [],
    );
  }

  /// `hours`
  String get common_hours_full {
    return Intl.message(
      'hours',
      name: 'common_hours_full',
      desc: '',
      args: [],
    );
  }

  /// `h`
  String get common_hours {
    return Intl.message(
      'h',
      name: 'common_hours',
      desc: '',
      args: [],
    );
  }

  /// `minutes`
  String get common_minutes_full {
    return Intl.message(
      'minutes',
      name: 'common_minutes_full',
      desc: '',
      args: [],
    );
  }

  /// `m`
  String get common_minutes {
    return Intl.message(
      'm',
      name: 'common_minutes',
      desc: '',
      args: [],
    );
  }

  /// `seconds`
  String get common_seconds_full {
    return Intl.message(
      'seconds',
      name: 'common_seconds_full',
      desc: '',
      args: [],
    );
  }

  /// `s`
  String get common_seconds {
    return Intl.message(
      's',
      name: 'common_seconds',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get common_save {
    return Intl.message(
      'Save',
      name: 'common_save',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get common_cancel {
    return Intl.message(
      'Cancel',
      name: 'common_cancel',
      desc: '',
      args: [],
    );
  }

  /// `OK`
  String get common_ok {
    return Intl.message(
      'OK',
      name: 'common_ok',
      desc: '',
      args: [],
    );
  }

  /// `Success`
  String get common_success {
    return Intl.message(
      'Success',
      name: 'common_success',
      desc: '',
      args: [],
    );
  }

  /// `Failed`
  String get common_failed {
    return Intl.message(
      'Failed',
      name: 'common_failed',
      desc: '',
      args: [],
    );
  }

  /// `Uploading`
  String get common_uploading {
    return Intl.message(
      'Uploading',
      name: 'common_uploading',
      desc: '',
      args: [],
    );
  }

  /// `Downloading`
  String get common_downloading {
    return Intl.message(
      'Downloading',
      name: 'common_downloading',
      desc: '',
      args: [],
    );
  }

  /// `Copy`
  String get common_copy {
    return Intl.message(
      'Copy',
      name: 'common_copy',
      desc: '',
      args: [],
    );
  }

  /// `New version!`
  String get common_new_version {
    return Intl.message(
      'New version!',
      name: 'common_new_version',
      desc: '',
      args: [],
    );
  }

  /// `Update`
  String get common_update {
    return Intl.message(
      'Update',
      name: 'common_update',
      desc: '',
      args: [],
    );
  }

  /// `No new version`
  String get common_no_new_version {
    return Intl.message(
      'No new version',
      name: 'common_no_new_version',
      desc: '',
      args: [],
    );
  }

  /// `Import success`
  String get service_import_success {
    return Intl.message(
      'Import success',
      name: 'service_import_success',
      desc: '',
      args: [],
    );
  }

  /// `WebDAV is not enabled`
  String get webdav_webdav_not_enabled {
    return Intl.message(
      'WebDAV is not enabled',
      name: 'webdav_webdav_not_enabled',
      desc: '',
      args: [],
    );
  }

  /// `Syncing`
  String get webdav_syncing {
    return Intl.message(
      'Syncing',
      name: 'webdav_syncing',
      desc: '',
      args: [],
    );
  }

  /// `Syncing files`
  String get webdav_syncing_files {
    return Intl.message(
      'Syncing files',
      name: 'webdav_syncing_files',
      desc: '',
      args: [],
    );
  }

  /// `Sync complete`
  String get webdav_sync_complete {
    return Intl.message(
      'Sync complete',
      name: 'webdav_sync_complete',
      desc: '',
      args: [],
    );
  }

  /// `Connection success`
  String get webdav_connection_success {
    return Intl.message(
      'Connection success',
      name: 'webdav_connection_success',
      desc: '',
      args: [],
    );
  }

  /// `Connection failed`
  String get webdav_connection_failed {
    return Intl.message(
      'Connection failed',
      name: 'webdav_connection_failed',
      desc: '',
      args: [],
    );
  }

  /// `Please set WebDAV information first`
  String get webdav_set_info_first {
    return Intl.message(
      'Please set WebDAV information first',
      name: 'webdav_set_info_first',
      desc: '',
      args: [],
    );
  }

  /// `Choose Sources`
  String get webdav_choose_Sources {
    return Intl.message(
      'Choose Sources',
      name: 'webdav_choose_Sources',
      desc: '',
      args: [],
    );
  }

  /// `Download from WebDAV`
  String get webdav_download {
    return Intl.message(
      'Download from WebDAV',
      name: 'webdav_download',
      desc: '',
      args: [],
    );
  }

  /// `Upload to WebDAV`
  String get webdav_upload {
    return Intl.message(
      'Upload to WebDAV',
      name: 'webdav_upload',
      desc: '',
      args: [],
    );
  }

  /// `Sync`
  String get settings_sync {
    return Intl.message(
      'Sync',
      name: 'settings_sync',
      desc: '',
      args: [],
    );
  }

  /// `WebDAV`
  String get settings_sync_webdav {
    return Intl.message(
      'WebDAV',
      name: 'settings_sync_webdav',
      desc: '',
      args: [],
    );
  }

  /// `Enable WebDAV`
  String get settings_sync_enable_webdav {
    return Intl.message(
      'Enable WebDAV',
      name: 'settings_sync_enable_webdav',
      desc: '',
      args: [],
    );
  }

  /// `WebDAV URL`
  String get settings_sync_webdav_url {
    return Intl.message(
      'WebDAV URL',
      name: 'settings_sync_webdav_url',
      desc: '',
      args: [],
    );
  }

  /// `Username`
  String get settings_sync_webdav_username {
    return Intl.message(
      'Username',
      name: 'settings_sync_webdav_username',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get settings_sync_webdav_password {
    return Intl.message(
      'Password',
      name: 'settings_sync_webdav_password',
      desc: '',
      args: [],
    );
  }

  /// `Test Connection`
  String get settings_sync_webdav_test_connection {
    return Intl.message(
      'Test Connection',
      name: 'settings_sync_webdav_test_connection',
      desc: '',
      args: [],
    );
  }

  /// `Sync Now`
  String get settings_sync_webdav_sync_now {
    return Intl.message(
      'Sync Now',
      name: 'settings_sync_webdav_sync_now',
      desc: '',
      args: [],
    );
  }

  /// `Advanced`
  String get settings_advanced {
    return Intl.message(
      'Advanced',
      name: 'settings_advanced',
      desc: '',
      args: [],
    );
  }

  /// `Log`
  String get settings_advanced_log {
    return Intl.message(
      'Log',
      name: 'settings_advanced_log',
      desc: '',
      args: [],
    );
  }

  /// `Clear Log`
  String get settings_advanced_log_clear_log {
    return Intl.message(
      'Clear Log',
      name: 'settings_advanced_log_clear_log',
      desc: '',
      args: [],
    );
  }

  /// `Export Log`
  String get settings_advanced_log_export_log {
    return Intl.message(
      'Export Log',
      name: 'settings_advanced_log_export_log',
      desc: '',
      args: [],
    );
  }

  /// `Clear log when start`
  String get settings_advanced_clear_log_when_start {
    return Intl.message(
      'Clear log when start',
      name: 'settings_advanced_clear_log_when_start',
      desc: '',
      args: [],
    );
  }

  /// `Check for updates`
  String get about_check_for_updates {
    return Intl.message(
      'Check for updates',
      name: 'about_check_for_updates',
      desc: '',
      args: [],
    );
  }

  /// `New version: `
  String get update_new_version {
    return Intl.message(
      'New version: ',
      name: 'update_new_version',
      desc: '',
      args: [],
    );
  }

  /// `Current version: `
  String get update_current_version {
    return Intl.message(
      'Current version: ',
      name: 'update_current_version',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'zh'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
