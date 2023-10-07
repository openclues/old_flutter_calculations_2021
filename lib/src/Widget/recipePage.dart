import 'package:calculations/modles/ingredient.dart';
import 'package:calculations/modles/recipe.dart';
import 'package:flutter/material.dart';

class RecipePage extends StatefulWidget {
  final String title;
  final String note;
  final List<Ing> ingredients;
  final List<Comment> comments;

  const RecipePage(
      {Key key,
      @required this.note,
      @required this.title,
      @required this.ingredients,
      @required this.comments})
      : super(key: key);

  @override
  _RecipePageState createState() => _RecipePageState();
}

class _RecipePageState extends State<RecipePage> {
  bool openreplies = false;

  @override
  Widget build(BuildContext context) {
    List<Comment> comm =
        widget.comments.where((element) => element.parentId == "0").toList();

    return Scaffold(
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8.0, left: 8),
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
                      child: Text(widget.title),
                    ),
                  ),
                )
              ],
            ),
          ),
          Divider(
            color: Colors.white,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Row(
              children: [
                Card(
                  color: Colors.grey,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Ingredients : " + " "),
                  ),
                ),
              ],
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: ClampingScrollPhysics(),
            itemCount: widget.ingredients.length,
            itemBuilder: (BuildContext context, int index) {
              return IngredientInRecipePage(
                title: widget.ingredients[index].title,
                weight: widget.ingredients[index].weight,
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.ideographic,
                children: [
                  Card(
                    color: Colors.grey,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Note : " + " "),
                    ),
                  ),
                  Expanded(
                    child: Card(
                      color: Colors.blue[700],
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(widget.note),
                      ),
                    ),
                  )
                ]),
          ),
          Divider(
            color: Colors.white,
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: ClampingScrollPhysics(),
            itemCount: comm.length,
            itemBuilder: (BuildContext context, int indexa) {
              return ListView(
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                children: [
                  Card(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Auther Name",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(comm[indexa].body)
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Row(
                              children: [
                                IconButton(
                                  icon: Icon(Icons.mode_comment),
                                  onPressed: () {
                                    setState(() {
                                      openreplies = !openreplies;
                                    });
                                  },
                                ),
                                Text("Reply"),
                              ],
                            ),
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Scaffold.of(context)
                                        .showBottomSheet((context) => Padding(
                                              padding:
                                                  const EdgeInsets.all(20.0),
                                              child: ListView(
                                                shrinkWrap: true,
                                                physics:
                                                    ClampingScrollPhysics(),
                                                children: [
                                                  Text(
                                                    comm[indexa].body,
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                  ListView.builder(
                                                    shrinkWrap: true,
                                                    physics:
                                                        ClampingScrollPhysics(),
                                                    itemCount: comm[indexa]
                                                        .replies
                                                        .length,
                                                    itemBuilder:
                                                        (BuildContext context,
                                                            int index) {
                                                      return Text("replies");
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ));
                                  },
                                  child: Text(
                                      comm[indexa].replies.length.toString() +
                                          " Replies"),
                                )
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    itemCount: comm[indexa].replies.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: openreplies
                            ? Text(comm[indexa].replies[index].body)
                            : Text(''),
                      );
                    },
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

class IngredientInRecipePage extends StatelessWidget {
  final String title;
  final String weight;
  const IngredientInRecipePage({
    Key key,
    this.title,
    this.weight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        children: [
          Expanded(
            child: Card(
              elevation: 20,
              color: Colors.blue[700],
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(title),
                ),
              ),
            ),
          ),
          Card(
            color: Colors.indigo,
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 16.0, bottom: 16, left: 8, right: 8),
              child: Text("$weight gm"),
            ),
          ),
        ],
      ),
    );
  }
}

// Divider(
//               color: Colors.white,
//             ),
//             Padding(
// padding: const EdgeInsets.only(left: 8),
//               child: Row(
//                 crossAxisAlignment: CrossAxisAlignment.baseline,
//                 textBaseline: TextBaseline.ideographic,
//                 children: [
//                   Card(
//                     color: Colors.grey,
//                     child: Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Text("Note : " + " "),
//                     ),
//                   ),
//                   Expanded(
//                     child: Card(
//                       color: Colors.blue[700],
//                       child: Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Text(
//                             "Recipe for cream for facedosjfopsdjofofjsdf;osdjfopjsdfjsdfjsdfjopsdfjopsdjfjsdofjopsdjfojdsofjsdofjsdjfosdjfposdjfopsdjfjsdpfjsdfj"),
//                       ),
//                     ),
// //                   )
//                 ],
//               ),
//             ),
