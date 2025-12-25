import 'package:flutter/material.dart';
import '../core/constants/app_strings.dart';
import 'avatar_widget.dart';

class UserTile extends StatelessWidget {
  final String name;
  final String id;
  final VoidCallback? onTap;

  const UserTile({Key? key, required this.name, required this.id, this.onTap})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: AvatarWidget(initials: name.isNotEmpty ? name[0] : '?'),
      title: Text(name),
      subtitle: const Text(AppStrings.typeMessageHint),
      onTap: onTap,
    );
  }
}
