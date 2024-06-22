import "package:demo/dal/http_repository.dart";
import "package:demo/view_models/users_view_model.dart";
import "package:demo/views/users_page.dart";
import "package:flutter/material.dart";

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        home: UsersPage.obtainPage(viewModel: UsersViewModel(repository: HttpRepository())),
      );
}
