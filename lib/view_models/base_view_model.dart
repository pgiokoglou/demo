import "package:demo/utils/box.dart";
import "package:flutter/foundation.dart";
import "package:property_change_notifier/property_change_notifier.dart";

class BaseViewModel extends PropertyChangeNotifier<String> {
  @protected
  void setField<T>(
    Box<T> box,
    T value,
    String propertyName,
  ) {
    if (box.value == value) {
      return;
    }

    box.callback(box.value = value);
    notifyListeners(propertyName);
  }
}
