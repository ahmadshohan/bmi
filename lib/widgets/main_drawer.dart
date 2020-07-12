import 'package:flutter/material.dart';
import '../screens/filters_screen.dart';

class MainDrawer extends StatelessWidget {
  Widget builderListTile(String title, IconData icon, Function handler) {
    return ListTile(
      leading: Icon(
        icon,
        size: 26,
      ),
      title: Text(
        title,
        style: TextStyle(
            fontSize: 24,
            fontFamily: 'RobotoCondensed',
            fontWeight: FontWeight.w700),
      ),
      onTap: handler,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          Container(
            color: Theme.of(context).accentColor,
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.all(10),
            width: double.infinity,
            height: 120,
            child: Text(
              'Cocking now !',
              style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.w900,
                  fontSize: 30),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          builderListTile('Meals', Icons.restaurant,(){
            Navigator.of(context).pushReplacementNamed('/');
          }),
          builderListTile('Filters', Icons.settings,(){
            Navigator.of(context).pushReplacementNamed(FiltersScreen.routeName);
          }),
        ],
      ),
    );
  }
}
