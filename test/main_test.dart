import "package:test/scaffolding.dart";

import "integration_testing/integration_testing.dart" as integration;
import "unit_testing/unit_test.dart" as unit;
import "widget_testing/widget_test.dart" as widget;

void main() {
  group("Unit testing", unit.main);

  group("Widget testing", widget.main);

  group("Integration testing", integration.main);
}
