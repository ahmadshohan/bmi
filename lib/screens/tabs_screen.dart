import 'package:flutter/material.dart';
import '../models/meal.dart';
import './favorite_screen.dart';
import './categories_screen.dart';
import '../widgets/main_drawer.dart';

class TabsScreen extends StatefulWidget {
  final List<Meal> _favoritsMeal;
  TabsScreen(this._favoritsMeal);
  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectPageIndex = 0;
  List<Map<String, Object>> _pages;
  @override
  void initState() {
    _pages = [
      {
        'page': CategoriesScreen(),
        'title': 'Categories',
      },
      {'page': FavoriteScreen(widget._favoritsMeal), 'title': 'Your Favorite'},
    ];
    super.initState();
  }

  void _selectPage(int index) {
    setState(() {
      _selectPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_pages[_selectPageIndex]['title']),
      ),
      drawer: MainDrawer(),
      body: _pages[_selectPageIndex]['page'],
      bottomNavigationBar: BottomNavigationBar(
          unselectedItemColor: Colors.white,
          selectedItemColor: Theme.of(context).accentColor,
          currentIndex: _selectPageIndex,
          type: BottomNavigationBarType.shifting,
          selectedFontSize: 15,
          onTap: _selectPage,
          items: [
            BottomNavigationBarItem(
              backgroundColor: Theme.of(context).primaryColor,
              icon: Icon(Icons.category),
              title: Text('Categouris'),
            ),
            BottomNavigationBarItem(
                backgroundColor: Theme.of(context).primaryColor,
                icon: Icon(Icons.favorite),
                title: Text('Favorite'))
          ]),
    );
  }
}
