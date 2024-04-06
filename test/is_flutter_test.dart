// @license
// Copyright (c) 2019 - 2024 Dr. Gabriel Gatzsche. All Rights Reserved.
//
// Use of this source code is governed by terms that can be
// found in the LICENSE file in the root of this package.

import 'dart:io';

import 'package:gg_is_flutter/src/is_flutter.dart';
import 'package:path/path.dart';
import 'package:test/test.dart';

void main() {
  final currentDir = Directory.current;

  setUp(testResetIsFlutter);

  tearDown(() {
    Directory.current = currentDir;
  });

  group('IsFlutter', () {
    test('should work fine', () {
      // const IsFlutter();
      expect(isFlutter, isFalse);
    });

    group('should throw', () {
      test('if pubspec.yaml not found', () {
        final tmp = Directory.systemTemp.createTempSync();
        Directory.current = tmp;
        expect(
          () => isFlutter,
          throwsA(
            isA<Exception>().having(
              (e) => e.toString(),
              'toString',
              'Exception: pubspec.yaml not found',
            ),
          ),
        );
      });
    });

    group('isFlutterDir(dir)', () {
      group('should return true', () {
        test('if directory is a flutter project', () {
          final tmp = Directory.systemTemp.createTempSync();
          Directory.current = tmp;
          final pubspec = File(join(tmp.path, 'pubspec.yaml'));
          pubspec.writeAsStringSync('''
name: test
description: A new Flutter project.
version: 1.0.0+1
   flutter:
environment:
  sdk: flutter
''');
          expect(isFlutterDir(tmp), isTrue);
        });
      });

      group('should return false', () {
        test('if directory is not a flutter project', () {
          final tmp = Directory.systemTemp.createTempSync();
          Directory.current = tmp;
          final pubspec = File(join(tmp.path, 'pubspec.yaml'));
          pubspec.writeAsStringSync('''
name: test
description: A new Flutter project.
version: 1.0.0+1
''');
          expect(isFlutterDir(tmp), isFalse);
        });
      });
    });
  });
}
