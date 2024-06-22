import "package:flutter/foundation.dart";
import "package:flutter_test/flutter_test.dart";

extension KeyFinder on CommonFinders {
  Finder byKeyString(
    String key, {
    bool skipOffstage = true,
  }) =>
      byKey(
        Key(key),
        skipOffstage: skipOffstage,
      );
}
