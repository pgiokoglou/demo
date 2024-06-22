import "package:demo/models/user/data.dart";
import "package:flutter/material.dart";

class UserTile extends StatelessWidget {
  final Data? data;

  const UserTile({
    required this.data,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    if (data == null) {
      return const SizedBox.shrink();
    }

    final Data tempData = data!;
    String title = "${tempData.firstName ?? ''} ${tempData.lastName ?? ''}".trim();

    if (title.isEmpty) {
      title = "No name provided";
    }

    return ListTile(
      dense: false,
      title: Text(title),
      subtitle: Text(tempData.email ?? "No email provided"),
      leading: Text(tempData.id?.toString() ?? ""),
      trailing: tempData.avatar != null ? Image.network(tempData.avatar!) : null,
    );
  }
}
