import 'package:calculations/providers/ingredientProvider.dart';
import 'package:calculations/providers/loginProvider.dart';
import 'package:calculations/providers/recipeProvider.dart';
import 'package:calculations/src/looding.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: IngredientProvider()),
        ChangeNotifierProvider.value(value: RecipeProvider()),
        // ChangeNotifierProvider.value(
        //   value: ProductProvider(),
        // ),
        ChangeNotifierProvider.value(value: LoginRegister())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData.dark(),
        home: Looding(),
      ),
    );
  }
}
