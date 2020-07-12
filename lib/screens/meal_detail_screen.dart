import 'package:flutter/material.dart';
import '../dummy_data.dart';

class MealDetailScreen extends StatelessWidget {
  static const routeName = '/meal_detail';
  final Function toggleFavorite;
  final Function isFavoritMeal;
  MealDetailScreen(this.isFavoritMeal, this.toggleFavorite);
  Widget buildSectionTitle(BuildContext context, String text) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Text(
        text,
        style: Theme.of(context).textTheme.title,
      ),
    );
  }

  Widget buildContiner(Widget child) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey,
          ),
          borderRadius: BorderRadius.circular(10)),
      padding: EdgeInsets.all(5),
      margin: EdgeInsets.all(10),
      height: 150,
      width: 300,
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final mealId = ModalRoute.of(context).settings.arguments as String;
    final selectedMeal = DUMMY_MEALS.firstWhere((meal) => meal.id == mealId);
    return Scaffold(
      appBar: AppBar(
        title: Text(selectedMeal.title),
      ),
      body: SingleChildScrollView(
          child: Column(
        children: <Widget>[
          Container(
            height: 300,
            width: double.infinity,
            child: Image.network(
              selectedMeal.imageUrl,
              fit: BoxFit.cover,
            ),
          ),
          buildSectionTitle(context, 'Ingrediants'),
          buildContiner(
            ListView.builder(
                itemCount: selectedMeal.ingredients.length,
                itemBuilder: (ctx, index) {
                  return Card(
                      color: Theme.of(context).accentColor,
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                        child: Text(
                          selectedMeal.ingredients[index],
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                      ));
                }),
          ),
          buildSectionTitle(context, 'Steps'),
          buildContiner(
            ListView.builder(
                itemCount: selectedMeal.steps.length,
                itemBuilder: (ctx, index) {
                  return Column(
                    children: <Widget>[
                      ListTile(
                        leading: CircleAvatar(
                          child: Text('# ${(index + 1)}'),
                        ),
                        title: Text(selectedMeal.steps[index]),
                      ),
                      Divider()
                    ],
                  );
                }),
          ),
        ],
      )),
      floatingActionButton: FloatingActionButton(
          child: Icon(
          isFavoritMeal(mealId)?Icons.star:Icons.star_border
          ),
          onPressed:()=> toggleFavorite(mealId)),
    );
  }
}
