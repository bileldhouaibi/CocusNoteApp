import 'package:flutter/material.dart';

class Header extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text('Notes App'),
      actions: [
        IconButton(
          icon: Icon(Icons.search),
          onPressed: () {},
        ),
        IconButton(
          icon: Icon(Icons.history),
          onPressed: () {
            Navigator.of(context).pushNamed('/deleted-notes');
          },
        ),
        IconButton(
          icon: Icon(Icons.update),
          onPressed: () {
            Navigator.of(context).pushNamed('/updated-notes');
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
