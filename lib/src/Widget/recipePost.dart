import 'package:calculations/modles/ingredient.dart';
import 'package:calculations/modles/recipe.dart';
import 'package:calculations/src/Widget/recipePage.dart';
import 'package:flutter/material.dart';

class BuildRecipePost extends StatelessWidget {
  final String title;
  final String autherName;
  final int commentsNummber;
  final List<Comment> comments;
  final List<Ing> ingredients;
  final String note;

  const BuildRecipePost({
    Key key,
    @required this.note,
    this.title,
    this.autherName,
    this.commentsNummber,
    @required this.comments,
    @required this.ingredients,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 230,
      child: Column(
        children: [
          Container(
            height: 180,
            child: Card(
              elevation: 20,
              color: Colors.white,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Text(
                              "@$autherName",
                              style: TextStyle(color: Colors.black),
                            ),
                            Text("2 mins ago",
                                style: TextStyle(color: Colors.black))
                          ],
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.bar_chart,
                          color: Colors.black,
                        ),
                        onPressed: () {},
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Row(
                      children: [
                        Card(
                          color: Colors.grey,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Title : " + " "),
                          ),
                        ),
                        Expanded(
                          child: Card(
                            color: Colors.blue[700],
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(title),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Spacer(),
                  Divider(
                    color: Colors.grey,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => RecipePage(
                                        note: note,
                                        title: title,
                                        comments: comments,
                                        ingredients: ingredients,
                                      )));
                            },
                            child: Text('See more',
                                style: TextStyle(
                                    color: Colors.blue[800],
                                    fontWeight: FontWeight.bold)),
                          ),
                          Icon(
                            Icons.open_in_new,
                            color: Colors.black,
                          )
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text('Comment',
                              style: TextStyle(
                                  color: Colors.blue[800],
                                  fontWeight: FontWeight.bold)),
                          Icon(
                            Icons.comment,
                            size: 20,
                            color: Colors.black,
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Text('Save',
                              style: TextStyle(
                                  color: Colors.blue[800],
                                  fontWeight: FontWeight.bold)),
                          Icon(
                            Icons.open_in_new,
                            color: Colors.black,
                          )
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  )
                ],
                crossAxisAlignment: CrossAxisAlignment.start,
              ),
            ),
          ),
          Container(
            width: double.infinity,
            child: Card(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                    onTap: () {
                      Scaffold.of(context).showBottomSheet((context) =>
                          Container(
                              height:
                                  MediaQuery.of(context).size.height * 0.9));
                    },
                    child: Text(commentsNummber.toString() + ' comments',
                        style: TextStyle(color: Colors.black))),
              ),
            ),
          )
        ],
      ),
    );
  }
}
