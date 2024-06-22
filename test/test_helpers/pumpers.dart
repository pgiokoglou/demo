import "package:flutter/material.dart";
import "package:flutter_test/flutter_test.dart";

extension Pumpers on WidgetTester {
  Future<void> pumpPage({
    required Widget page,
    Locale? locale,
  }) async =>
      pumpWidget(
        MaterialApp(
          home: page,
          locale: locale,
        ),
      );
}
