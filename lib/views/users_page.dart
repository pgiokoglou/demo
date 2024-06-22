import "package:demo/view_models/users_view_model.dart";
import "package:demo/views/widgets/user_tile.dart";
import "package:flutter/material.dart";
import "package:property_change_notifier/property_change_notifier.dart";

class UsersPage extends StatelessWidget {
  UsersPage({Key? key}) : super(key: key ?? Key((UsersPage).toString()));

  @override
  Widget build(BuildContext context) => StringPropertyChangeConsumer<UsersViewModel>(
        properties: <String>[UsersViewModelKeys.fetchUsers],
        builder: (
          BuildContext _,
          UsersViewModel? viewModel,
          Set<String>? ___,
        ) {
          if (viewModel == null) {
            return const SizedBox.shrink();
          }

          return Scaffold(
            appBar: AppBar(
              title: const Text(
                "Your Users",
                key: Key("pageTitleKey"),
              ),
              actions: <Widget>[
                TextButton(
                  key: const Key("fetchButton"),
                  onPressed: viewModel.fetchUsers,
                  child: const Text("Fetch"),
                ),
              ],
            ),
            body: SafeArea(
              child: ListView.builder(
                key: const Key("listView"),
                itemCount: viewModel.users.length,
                itemBuilder: (
                  BuildContext _,
                  int index,
                ) =>
                    UserTile(
                  data: viewModel.users[index].data,
                  key: Key("userTile$index"),
                ),
              ),
            ),
          );
        },
      );

  static Widget obtainPage({required UsersViewModel viewModel}) => StringPropertyChangeProvider<UsersViewModel>(
        value: viewModel,
        child: UsersPage(),
      );
}
