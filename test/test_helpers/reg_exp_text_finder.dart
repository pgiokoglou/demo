import "package:flutter/widgets.dart";
import "package:flutter_test/flutter_test.dart";

class RegExpTextFinder extends MatchFinder {
  final RegExp regExp;

  RegExpTextFinder(
    this.regExp, {
    super.skipOffstage,
  });

  @override
  String get description => "text containing $regExp";

  @override
  bool matches(Element candidate) {
    final Widget widget = candidate.widget;

    if (widget is Text) {
      if (widget.data != null) {
        return regExp.hasMatch(widget.data!);
      }

      assert(widget.textSpan != null, "textSpan cannot be null");
      return regExp.hasMatch(widget.textSpan!.toPlainText());
    } else if (widget is EditableText) {
      return regExp.hasMatch(widget.controller.text);
    }

    return false;
  }
}
