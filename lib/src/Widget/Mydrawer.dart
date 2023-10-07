import 'package:calculations/screens/homepage.dart';
import 'package:calculations/src/Widget/drawerItems.dart';
import 'package:calculations/src/homescreen.dart';
import 'package:flutter/material.dart';

class BuildDrawer extends StatelessWidget {
  const BuildDrawer({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * .5,
      child: Container(
        color: Colors.black,
        child: ListView(
          children: [
            DrawerHeader(
              child: Text('drawer'),
              decoration: BoxDecoration(color: Colors.blue),
            ),
                        Divider(
              height: 1,
            ),

            BuildDrawerItem(
              itemTitile: "My Laporatory",
              icon: Icons.workspaces_filled,
              widget: MyHomePage(),
            ),
            Divider(
              height: 1,
            ),
            BuildDrawerItem(
              itemTitile: "Community",
              icon: Icons.post_add_sharp,
              widget: HomeScreen(),
            ),
            Divider(
              height: 1,
            ),
            BuildDrawerItem(
              itemTitile: "My profile",
              icon: Icons.person,
              widget: MyHomePage(),
            ),
            Divider(),
          ],
        ),
      ),
    );
  }
}
