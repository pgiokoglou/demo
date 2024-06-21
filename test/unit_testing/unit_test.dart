import "package:test/test.dart";

import "dal/http_repository_test.dart" as http_repository_test;
import "view_models/users_view_model_test.dart" as users_view_model_test;

void main() {
  group("http_repository_test", http_repository_test.main);
  group("users_view_model_test", users_view_model_test.main);
}
