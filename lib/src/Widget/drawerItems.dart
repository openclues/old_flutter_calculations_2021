import 'package:flutter/material.dart';

class BuildDrawerItem extends StatelessWidget {
  final itemTitile;
  final IconData icon;
  final widget;

  const BuildDrawerItem({
    Key key,
    this.itemTitile,
    this.icon,
    this.widget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.pushAndRemoveUntil(context,
            MaterialPageRoute(builder: (context) => widget), (route) => false);
      },
      title: Row(
        children: [
          Icon(icon),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(itemTitile),
          ),
        ],
      ),
    );
  }
}
