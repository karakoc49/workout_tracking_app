import 'package:flutter/material.dart';

class AppBarWidget extends StatefulWidget implements PreferredSizeWidget {
  final Color backgroundColor;
  final Widget? leading;
  const AppBarWidget({super.key, required this.backgroundColor, this.leading});

  @override
  State<AppBarWidget> createState() => _AppBarWidgetState();

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class _AppBarWidgetState extends State<AppBarWidget> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: widget.leading,
      shadowColor: Colors.lightBlue,
      elevation: 0.0,
      backgroundColor: widget.backgroundColor,
      actions: <Widget>[
        Padding(
          padding: const EdgeInsets.only(right: 16.0, top: 10),
          child: InkWell(
            onTap: () {},
            child: CircleAvatar(
              backgroundImage: ExactAssetImage('assets/images/profile.jpg'),
              radius: 20,
            ),
          ),
        )
      ],
    );
  }
}
