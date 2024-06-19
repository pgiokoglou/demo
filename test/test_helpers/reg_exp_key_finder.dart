import "package:flutter/widgets.dart";
import "package:flutter_test/flutter_test.dart";

class RegExpKeyFinder extends MatchFinder {
  final RegExp regExp;

  RegExpKeyFinder(
    this.regExp, {
    super.skipOffstage,
  });

  @override
  String get description => "key containing $regExp";

  @override
  bool matches(Element candidate) {
    final Widget widget = candidate.widget;

    if (widget.key == null || widget.key is! ValueKey<String>) {
      return false;
    }

    return regExp.hasMatch((widget.key! as ValueKey<String>).value);
  }
}
