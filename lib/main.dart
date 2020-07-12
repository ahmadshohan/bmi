import 'package:flutter/material.dart';
import './dummy_data.dart';
import './models/meal.dart';
import './screens/filters_screen.dart';
import './screens/tabs_screen.dart';
import './screens/category_meal_screen.dart';
import './screens/meal_detail_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    'gluten': false,
    'vegan': false,
    'vegetarian': false,
    'lactoseFree': false
  };

  List<Meal> _availableMeal = DUMMY_MEALS;
  List<Meal> _favoritsMeal = [];

  void _setFilters(Map<String, bool> filterData) {
    setState(() {
      _filters = filterData;
      _availableMeal = DUMMY_MEALS.where((meal) {
        if (_filters['gluten'] && !meal.isGlutenFree) {
          return false;
        }
        if (_filters['vegan'] && !meal.isVegan) {
          return false;
        }
        if (_filters['vegetarian'] && !meal.isVegetarian) {
          return false;
        }
        if (_filters['lactoseFree'] && !meal.isLactoseFree) {
          return false;
        }
        return true;
      }).toList();
    });
  }

  void _toggleFavorite(String mealId) {
    final existingIndex = _favoritsMeal.indexWhere((meal) => meal.id == mealId);
    if (existingIndex >= 0) {
      setState(() {
        _favoritsMeal.removeAt(existingIndex);
      });
    } else {
      setState(() {
        _favoritsMeal.add(DUMMY_MEALS.firstWhere((meal) => meal.id == mealId));
      });
    }
  }

  bool _isFavoritMeal(String id) {
    return _favoritsMeal.any((meal) => meal.id == id);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DeliMeals',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.pink,
          accentColor: Colors.amber,
          canvasColor: Color.fromARGB(255, 255, 255, 255),
          fontFamily: 'Raleway',
          textTheme: ThemeData.light().textTheme.copyWith(
              body1: TextStyle(color: Color.fromARGB(20, 51, 51, 1)),
              body2: TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
              title: TextStyle(
                fontFamily: 'RobotoCondensed',
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ))),
      // home: CategoriesScreen(),
      // initialRoute: '/',
      routes: {
        '/': (context) => TabsScreen(_favoritsMeal),
        CategoryMealsScreen.routeName: (ctx) =>
            CategoryMealsScreen(_availableMeal),
        MealDetailScreen.routeName: (ctx) =>
            MealDetailScreen(_isFavoritMeal, _toggleFavorite),
        FiltersScreen.routeName: (ctx) => FiltersScreen(_filters, _setFilters)
      },
      // onGenerateRoute: (settings) {
      //   // print(setting.arguments);
      //   // if (setting.name == '/meal_detail') {
      //    return MaterialPageRoute(builder: (ctx) => TabsScreen());}
      //   // } else
      //   //   return MaterialPageRoute(builder: (ctx) => CategoryMealsScreen());

      //   return MaterialPageRoute(builder: (ctx) => CategoriesScreen());
      // },
      // onUnknownRoute: (settings) {
      //   return MaterialPageRoute(builder: (ctx) => CategoriesScreen());
      // },
    );
  }
}
