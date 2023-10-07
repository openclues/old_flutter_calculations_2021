import 'package:flutter/material.dart';

class TutorialScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tutorial"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          shrinkWrap: true,
          children: [
            Text(
              "How can i add a new ingredient ?",
              textAlign: TextAlign.left,
              style: TextStyle(
                height: 1.4,
                fontSize: 18,
              ),
            ),
            SizedBox(
              height: 13,
            ),
            Text(
              "Click on add button in the Home Page and add ingredient's information.",
              textAlign: TextAlign.left,
              style: TextStyle(
                color: Colors.green[500],
                height: 1.4,
                fontSize: 14,
              ),
            ),
            SizedBox(
              height: 13,
            ),
            Text(
              "How can i add a new recipe ?",
              textAlign: TextAlign.left,
              style: TextStyle(
                height: 1.4,
                fontSize: 18,
              ),
            ),
            SizedBox(
              height: 13,
            ),
            Text(
              "Long press on ingredients you want to add to your new recipe, Then click on add recipe Icon, After that add it's details then click on add new recipe. ",
              textAlign: TextAlign.left,
              style: TextStyle(
                color: Colors.green[500],
                height: 1.4,
                fontSize: 14,
              ),
            ),
                        SizedBox(
              height: 13,
            ),
            Text(
              "Where can i find saved recipes ?",
              textAlign: TextAlign.left,
              style: TextStyle(
                height: 1.4,
                fontSize: 18,
              ),
            ),
            SizedBox(
              height: 13,
            ),
                        Text(
              "Click on the 'All recipes icon on the homePage's bar.",
              textAlign: TextAlign.left,
              style: TextStyle(
                color: Colors.green[500],
                height: 1.4,
                fontSize: 14,
              ),
            ),
            SizedBox(
              height: 13,
            ),
            Text(
              "How can i use already saved recipes?",
              textAlign: TextAlign.left,
              style: TextStyle(
                height: 1.4,
                fontSize: 18,
              ),
            ),
                        SizedBox(
              height: 13,
            ),
                        Text(
              "Go to all recipes screen then click on the recipe you want to use, Then click on use this recipe. This will take you to another page where you can add a new general weight for the recipe and you will get new weights for each ingredient and general price for the new weight.",
              textAlign: TextAlign.left,
              style: TextStyle(
                color: Colors.green[500],
                height: 1.4,
                fontSize: 14,
              ),
            ),
SizedBox(
              height: 13,
            ),
            Text(
              "If you have more questions, send us an email here : Albayan.ar7@gmail.com",
              textAlign: TextAlign.left,
              style: TextStyle(
                height: 1.4,
                fontSize: 18,
              ),
            ),
            


          ],
        ),
      ),
    );
  }
}
