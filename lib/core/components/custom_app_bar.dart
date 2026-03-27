import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final IconButton? leadingIconButton;
  final IconButton? actionIconButton;

  const CustomAppBar({
    this.title,
    this.leadingIconButton,
    this.actionIconButton,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      scrolledUnderElevation: 0,
      elevation: 0,
      leading: leadingIconButton,
      title: Text(title ?? ''),
      centerTitle: true,
      actions: [?actionIconButton],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
