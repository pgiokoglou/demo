import "package:demo/dal/http_repository.dart";
import "package:demo/models/user/user.dart";
import "package:demo/view_models/base_view_model.dart";

class UsersViewModel extends BaseViewModel {
  final HttpRepository repository;
  final List<User> users = List<User>.empty(growable: true);

  UsersViewModel({required this.repository});

  Future<void> fetchUsers() async {
    users
      ..clear()
      ..addAll(await repository.getUsers());

    notifyListeners(UsersViewModelKeys.fetchUsers);
  }
}

class UsersViewModelKeys {
  static String fetchUsers = "fetchUsers";

  UsersViewModelKeys._();
}
