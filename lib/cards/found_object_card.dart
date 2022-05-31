import 'package:flutter/material.dart';

class FoundObject extends StatelessWidget {
  final String name;
  final String percent;
  const FoundObject({Key? key, required this.name, required this.percent})
      : super(key: key);

  String setInitials() {
    var tab = name.split(" ");
    if (tab.length == 1) {
      return tab[0].substring(0, 1);
    } else {
      return tab[0].substring(0, 1) + "" + tab[1].substring(0, 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: CircleAvatar(
              child: Text(setInitials().toUpperCase()),
            ),
            title: Text("Object found: $name"),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text("This object is $percent similar to $name"),
              ],
            ),
            onTap: () {},
            trailing: const Icon(Icons.arrow_circle_right_outlined),
          ),
        ],
      ),
    );
  }
}
