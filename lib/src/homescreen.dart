import 'package:calculations/modles/recipe.dart';
import 'package:calculations/providers/ingredientProvider.dart';
import 'package:calculations/providers/loginProvider.dart';
import 'package:calculations/providers/recipeProvider.dart';
import 'package:calculations/src/Widget/Mydrawer.dart';
import 'package:calculations/src/Widget/recipePost.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool expand = false;
  @override
  Widget build(BuildContext context) {
    final data = Provider.of<LoginRegister>(context);
    final recipe = Provider.of<RecipeProvider>(context);
    final publicRecipes =
        Provider.of<RecipeProvider>(context).getPublicRecipes();
    final ingredients = Provider.of<IngredientProvider>(context);
    return Scaffold(
      drawer: BuildDrawer(),
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              recipe.getPublicRecipes();
            },
          ),
          IconButton(
            icon: Icon(Icons.notification_important),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(5.0),
        child: ListView(
          shrinkWrap: true,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.15,
                color: Colors.white,
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 10),
                      decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(20)),
                      padding: EdgeInsets.all(10),
                      child: Text(
                        "click and new recipt or post to the public",
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Divider(
                      height: 1,
                      color: Colors.grey,
                    ),
                    Row(
                      children: [Container()],
                    )
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  height: 25,
                  color: Colors.red,
                ),
              ],
            ),
            FutureBuilder(
              future: publicRecipes,
              builder:
                  (BuildContext context, AsyncSnapshot<List<Recipe>> snapshot) {
                return snapshot.hasData
                    ? ListView.builder(
                        shrinkWrap: true,
                        physics: ClampingScrollPhysics(),
                        itemCount: snapshot.data.length,
                        itemBuilder: (BuildContext context, int index) {
                          return BuildRecipePost(
                            note: snapshot.data[index].note,
                            ingredients: snapshot.data[index].ingredients,
                            comments: snapshot.data[index].comments,
                            autherName: snapshot.data[index].user.name,
                            commentsNummber:
                                snapshot.data[index].comments.length,
                            title: snapshot.data[index].title,
                          );
                        },
                      )
                    : Center(
                        child: CircularProgressIndicator(),
                      );
              },
            ),
          ],
        ),
      ),
    );
  }
}
