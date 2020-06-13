import 'package:flutter/material.dart';
import 'package:meals/data/dummy_data.dart';
import 'package:meals/screens/categories_meals_screen.dart';
import 'package:meals/screens/meal_detail_screen.dart';
import 'package:meals/screens/settings_screen.dart';
import 'package:meals/utils/app_routes.dart';

import 'models/meal.dart';
import 'models/settings.dart';
import 'screens/bottom_tabs_screen.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  Settings settings = Settings();
  List<Meal> _avaibleMeals = DUMMY_MEALS;

  void _filterMeals(Settings settings){
    setState(() {
      this.settings = settings;
      _avaibleMeals = DUMMY_MEALS.where((meal){
        final filterGluten = settings.isGlutenFree && ! meal.isGlutenFree;
        final filterLactose = settings.isLactoseFree && ! meal.isLactoseFree;
        final filterVegan = settings.isVegan && ! meal.isVegan;
        final filterVegetarian = settings.isVegetarian && ! meal.isVegetarian;
        return !filterGluten && !filterLactose && !filterVegan && !filterVegetarian;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DeliMeals',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        accentColor: Colors.amber,
        fontFamily: 'Raleway',
        canvasColor: Color.fromRGBO(255, 254, 229, 1),
        textTheme: ThemeData.light().textTheme.copyWith(
          headline6: TextStyle(
            fontSize: 20,
            fontFamily: 'RobotoCondensed'
          )
        )
      ),
      routes: {
        // AppRoutes.HOME: (ctx) => CategoriesScreen(),
        // AppRoutes.HOME: (ctx) => TopTabsScreen(),
        AppRoutes.HOME: (ctx) => BottomTabsScreen(),
        AppRoutes.CATEGORIES_MEALS: (ctx) => CategoriesMealsScreen(_avaibleMeals),
        AppRoutes.MEAL_DETAIL: (ctx) => MealDetailScreen(),
        AppRoutes.SETTINGS: (ctx) => SettingsScreen(settings, _filterMeals)
      },
     
    );
  }
}
