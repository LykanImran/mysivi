import 'package:flutter/material.dart';
import '../../core/constants/app_strings.dart';

class TopTabSwitcher extends StatelessWidget implements PreferredSizeWidget {
  final TabController? controller;

  const TopTabSwitcher({super.key, this.controller});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(32),
        ),
        child: SizedBox(
          width: 260,
          child: TabBar(
            controller: controller,
            indicator: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(28),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            indicatorPadding: const EdgeInsets.all(4),
            indicatorSize: TabBarIndicatorSize.tab,
            labelColor: Colors.black,
            unselectedLabelColor: Colors.grey[700],
            labelStyle: const TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 14,
            ),
            unselectedLabelStyle: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
            tabs: const [
              Tab(text: AppStrings.usersTab),
              Tab(text: AppStrings.chatsTab),
            ],
          ),
        ),
      ),
    );
  }
}
