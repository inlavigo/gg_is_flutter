// @license
// Copyright (c) 2019 - 2024 Dr. Gabriel Gatzsche. All Rights Reserved.
//
// Use of this source code is governed by terms that can be
// found in the LICENSE file in the root of this package.

// .............................................................................
import 'dart:io';

import 'package:path/path.dart';

/// Returns true if the current project is a flutter project
bool get isFlutter =>
    testIsFlutter ?? (_isFlutter ??= _estimateFlutterOrDart(null));

// .............................................................................
/// Returns true if the project in dir is a flutter project
bool isFlutterDir(Directory dir) {
  return _estimateFlutterOrDart(dir);
}

// .............................................................................
bool? _isFlutter;

// .............................................................................
/// Reset the value of [isFlutter] to null for test purposes
void testResetIsFlutter() {
  _isFlutter = null;
  testIsFlutter = null;
}

// .............................................................................
/// Use this variable to enforce a specific value for [isFlutter] in tests
bool? testIsFlutter;

// .............................................................................
bool _estimateFlutterOrDart(Directory? dir) {
  final filePath = dir?.path ?? Directory.current.path;

  final File pubspec = File(join(filePath, 'pubspec.yaml'));
  if (!pubspec.existsSync()) {
    throw Exception('pubspec.yaml not found');
  }

  final String content = pubspec.readAsStringSync();
  return content.contains('  sdk: flutter') && content.contains('  flutter:');
}
