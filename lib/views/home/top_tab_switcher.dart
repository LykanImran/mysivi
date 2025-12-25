import 'package:flutter/material.dart';
import '../../core/constants/app_strings.dart';

class TopTabSwitcher extends StatelessWidget implements PreferredSizeWidget {
  final TabController? controller;

  const TopTabSwitcher({Key? key, this.controller}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return TabBar(
      controller: controller,
      tabs: const [
        Tab(text: AppStrings.usersTab),
        Tab(text: AppStrings.chatsTab),
      ],
    );
  }
}
