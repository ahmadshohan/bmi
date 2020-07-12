import 'package:flutter/material.dart';
import '../widgets/main_drawer.dart';

class FiltersScreen extends StatefulWidget {
  static const routeName = '/filters';
  final Function saveFilters;
  final Map<String, bool> currentFilters;
  FiltersScreen(this.currentFilters, this.saveFilters);

  @override
  _FiltersScreenState createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  var _isGlutenFree = false;
  var _isVegan = false;
  var _isVegetarian = false;
  var _isLactoseFree = false;
  @override
  initState() {
    _isGlutenFree = widget.currentFilters['gluten'];
    _isLactoseFree = widget.currentFilters['lactoseFree'];
    _isVegan = widget.currentFilters['vegan'];
    _isVegetarian = widget.currentFilters['vegetarian'];
    super.initState();
  }

  Widget _builderSwitchTileList(String title, String descreption,
      bool curentValue, Function updateValue) {
    return SwitchListTile(
        title: Text(title),
        subtitle: Text(descreption),
        value: curentValue,
        onChanged: updateValue);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Your Filters',
          ),
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.save),
                onPressed: () {
                  final selctedFilters = {
                    'gluten': _isGlutenFree,
                    'vegan': _isVegan,
                    'vegetarian': _isVegetarian,
                    'lactoseFree': _isLactoseFree,
                  };
                  widget.saveFilters(selctedFilters);
                })
          ],
        ),
        drawer: MainDrawer(),
        body: Column(
          children: <Widget>[
            Container(
              height: 100,
              padding: EdgeInsets.all(20),
              child: Text(
                'Adjust your Meal Selection',
                style: Theme.of(context).textTheme.title,
              ),
            ),
            Expanded(
                child: ListView(children: <Widget>[
              _builderSwitchTileList(
                  'Gluten Free', 'Only include Gluten Free', _isGlutenFree,
                  (newValue) {
                setState(() {
                  _isGlutenFree = newValue;
                });
              }),
              _builderSwitchTileList(
                  'Lactose', 'Only include Lactose Free', _isLactoseFree,
                  (newValue) {
                setState(() {
                  _isLactoseFree = newValue;
                });
              }),
              _builderSwitchTileList(
                  'Vegetarian', 'Only include Vegetarian Free', _isVegetarian,
                  (newValue) {
                setState(() {
                  _isVegetarian = newValue;
                });
              }),
              _builderSwitchTileList(
                  'Vegan', 'Only include Vegan Free', _isVegan, (newValue) {
                setState(() {
                  _isVegan = newValue;
                });
              }),
            ]))
          ],
        ));
  }
}
