import 'package:flutter/material.dart';
import '../models/meal.dart';
import '../widgets/meal_item.dart';

class FavoriteScreen extends StatelessWidget {
  final List<Meal> favoritsMeal;
  FavoriteScreen(this.favoritsMeal);
  @override
  Widget build(BuildContext context) {
    if (favoritsMeal.isEmpty) {
      return Center(
        child: Text(
          'you have no favorite yet start adding some !',
          style: TextStyle(color: Colors.black),
        ),
      );
    } else {
      return ListView.builder(
        itemBuilder: (ctx, index) {
          return MealItem(
            id: favoritsMeal[index].id,
            title: favoritsMeal[index].title,
            imageUrl: favoritsMeal[index].imageUrl,
            duration: favoritsMeal[index].duration,
            affordability: favoritsMeal[index].affordability,
            complexity: favoritsMeal[index].complexity,
          );
        },
        itemCount: favoritsMeal.length,
      );
    }
  }
}
