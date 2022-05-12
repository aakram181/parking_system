import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:parking_system/utils/constants.dart';

class DrawerItem extends StatelessWidget {
  final String title;
  final MaterialPageRoute onPressed;
  final IconData icon;
  DrawerItem(
      {required this.title, required this.onPressed, required this.icon});
  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading: Icon(icon),
        title: Text(
          title,
          style: kListItemStyle,
        ),
        trailing: const Icon(Icons.arrow_forward),
        onTap: () {
          Navigator.of(context).pop();
          Navigator.of(context).push(onPressed);
        });
  }
}
