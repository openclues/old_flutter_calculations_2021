import 'dart:convert';
import 'package:calculations/modles/recipe.dart';
import 'package:calculations/providers/recipeProvider.dart';
import 'package:calculations/screens/homepage.dart';
import 'package:clipboard/clipboard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AllReceipts extends StatefulWidget {
  @override
  _AllReceiptsState createState() => _AllReceiptsState();
}

class _AllReceiptsState extends State<AllReceipts> {
  TextEditingController textEditingController = TextEditingController();
  bool changet0Value = false;
  bool loading = false;

  String note = "";
  Map<String, String> titles = {};

  bool editNote = false;
  GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  GlobalKey<FormState> _globalKey2 = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var recipeProvider = Provider.of<RecipeProvider>(context, listen: true);

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    double newNew;

    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text("All recipes"),
          actions: [
            IconButton(
              icon: Icon(Icons.home),
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => MyHomePage()),
                    (Route<dynamic> route) => false);
              },
            ),
            SizedBox(
              width: 20,
            ),
          ],
        ),
        body: Container(
          height: height,
          child: FutureBuilder<List<Recipe>>(
            future: recipeProvider.getRecipeIngredients(),
            builder:
                (BuildContext context, AsyncSnapshot<List<Recipe>> snapshot) {
              return snapshot.data == null
                  ? Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int indexa) {
                        List weights =
                            jsonDecode(snapshot.data[indexa].weights);
                        return Column(
                          children: [
                            Container(
                              margin:
                                  EdgeInsets.only(top: 10, left: 14, right: 14),
                              height: 60,
                              decoration: BoxDecoration(
                                  color: Colors.black45,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Container(
                                height: 50,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Expanded(
                                        child: Padding(
                                      padding:
                                          const EdgeInsets.only(left: 16.0),
                                      child: Text(snapshot.data[indexa].title,
                                          style: TextStyle(color: Colors.cyan)),
                                    )),
                                    loading
                                        ? CircularProgressIndicator()
                                        : IconButton(
                                            onPressed: () {
                                              Scaffold.of(context)
                                                  .showBottomSheet(
                                                (context) => StatefulBuilder(
                                                    builder:
                                                        (BuildContext context,
                                                            setState) {
                                                  return Container(
                                                    height: height,
                                                    color: Colors.white,
                                                    child: ListView(
                                                      physics:
                                                          AlwaysScrollableScrollPhysics(),
                                                      shrinkWrap: true,
                                                      children: [
                                                        Container(
                                                          width:
                                                              double.infinity,
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          25),
                                                              color: Colors
                                                                  .grey[200]),
                                                          child: ListView(
                                                            shrinkWrap: true,
                                                            physics:
                                                                NeverScrollableScrollPhysics(),
                                                            children: [
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .only(
                                                                  top: 20.0,
                                                                  left: 15,
                                                                ),
                                                                child: Row(
                                                                  children: [
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                              .only(
                                                                          left:
                                                                              16.0),
                                                                      child:
                                                                          Container(
                                                                        width:
                                                                            230,
                                                                        child: SelectableText(
                                                                            "    #" +
                                                                                snapshot.data[indexa].title +
                                                                                "    ",
                                                                            style: TextStyle(backgroundColor: Colors.black.withOpacity(0.9), color: Colors.cyan, fontSize: 20, fontWeight: FontWeight.bold)),
                                                                      ),
                                                                    ),
                                                                    Spacer(),
                                                                    IconButton(
                                                                        icon: Icon(
                                                                            Icons
                                                                                .close,
                                                                            color: Colors
                                                                                .red),
                                                                        onPressed:
                                                                            () {
                                                                          titles
                                                                              .clear();

                                                                          Navigator.pop(
                                                                              context);
                                                                        }),
                                                                  ],
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        8.0),
                                                                child: Text(
                                                                    "Ingredients : ",
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            15,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        color: Colors
                                                                            .green[900])),
                                                              ),
                                                              Container(
                                                                  child: ListView
                                                                      .builder(
                                                                physics:
                                                                    NeverScrollableScrollPhysics(),
                                                                shrinkWrap:
                                                                    true,
                                                                itemCount: snapshot
                                                                    .data[
                                                                        indexa]
                                                                    .ingredients
                                                                    .length,
                                                                itemBuilder:
                                                                    (BuildContext
                                                                            context,
                                                                        int index) {
                                                                  titles
                                                                      .addAll({
                                                                    'Title': snapshot
                                                                            .data[indexa]
                                                                            .title +
                                                                        "\n",
                                                                    'Note': snapshot
                                                                            .data[indexa]
                                                                            .note +
                                                                        "\n",
                                                                    "Ingredients":
                                                                        "",
                                                                    snapshot
                                                                        .data[
                                                                            indexa]
                                                                        .ingredients[
                                                                            index]
                                                                        .title: weights[
                                                                            index]
                                                                        .toString(),
                                                                  });
                                                                  // snapshot
                                                                  //     .data[indexa]
                                                                  //     .ingredients
                                                                  //     .forEach(
                                                                  //         (element) {
                                                                  //   titles.entries();
                                                                  //   print(titles
                                                                  //       .toString());
                                                                  // });

                                                                  print(titles);
                                                                  return Card(
                                                                      elevation:
                                                                          20,
                                                                      child:
                                                                          Padding(
                                                                        padding:
                                                                            const EdgeInsets.all(15.0),
                                                                        child:
                                                                            Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.spaceBetween,
                                                                          children: [
                                                                            Container(
                                                                              width: 200,
                                                                              child: SelectableText(
                                                                                snapshot.data[indexa].ingredients[index].title + " : ",
                                                                                style: TextStyle(color: Colors.cyan, fontSize: 15, fontWeight: FontWeight.bold),
                                                                              ),
                                                                            ),
                                                                            SelectableText(weights[index].toString()
                                                                                // ((double.parse(snapshot.data[indexa].ingredients[index].weight) / double.parse(snapshot.data[indexa].weight) * 100).toStringAsFixed(2) +
                                                                                //     "%"),
                                                                                )
                                                                          ],
                                                                        ),
                                                                      ));
                                                                },
                                                              )),
                                                              Row(
                                                                children: [
                                                                  Padding(
                                                                    padding: const EdgeInsets
                                                                            .only(
                                                                        left:
                                                                            16.0),
                                                                    child: Text(
                                                                      "Price of the recipe :  ",
                                                                      style: TextStyle(
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          fontSize:
                                                                              15,
                                                                          color:
                                                                              Colors.green[900]),
                                                                    ),
                                                                  ),
                                                                  SelectableText(
                                                                      double.parse(snapshot
                                                                              .data[
                                                                                  indexa]
                                                                              .price)
                                                                          .toStringAsFixed(
                                                                              2),
                                                                      style: TextStyle(
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          color:
                                                                              Colors.black))
                                                                ],
                                                              ),
                                                              SizedBox(
                                                                height: 10,
                                                              ),
                                                              Row(
                                                                children: [
                                                                  Padding(
                                                                    padding: const EdgeInsets
                                                                            .only(
                                                                        left:
                                                                            16.0),
                                                                    child: Text(
                                                                      "Weight of the recipe  : ",
                                                                      style: TextStyle(
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          fontSize:
                                                                              15,
                                                                          color:
                                                                              Colors.green[900]),
                                                                    ),
                                                                  ),
                                                                  SelectableText(
                                                                      double.parse(snapshot
                                                                              .data[
                                                                                  indexa]
                                                                              .weight)
                                                                          .toStringAsFixed(
                                                                              2),
                                                                      style: TextStyle(
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          color:
                                                                              Colors.black)),
                                                                ],
                                                              ),
                                                              SizedBox(
                                                                height: 15,
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        left:
                                                                            16.0),
                                                                child:
                                                                    SelectableText(
                                                                  "Note : ",
                                                                  style: TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      fontSize:
                                                                          15,
                                                                      color: Colors
                                                                              .green[
                                                                          900]),
                                                                ),
                                                              ),
                                                              Stack(
                                                                children: [
                                                                  Padding(
                                                                    padding: const EdgeInsets
                                                                            .only(
                                                                        bottom:
                                                                            15.0,
                                                                        top:
                                                                            15),
                                                                    child:
                                                                        Center(
                                                                      child:
                                                                          Container(
                                                                        height: height *
                                                                            0.3,
                                                                        width:
                                                                            width,
                                                                        decoration:
                                                                            BoxDecoration(borderRadius: BorderRadius.circular(30)),
                                                                        child:
                                                                            Card(
                                                                          elevation:
                                                                              20,
                                                                          child:
                                                                              Padding(
                                                                            padding:
                                                                                const EdgeInsets.all(20.0),
                                                                            child:
                                                                                SingleChildScrollView(
                                                                              child: editNote
                                                                                  ? Form(
                                                                                      key: _globalKey2,
                                                                                      child: TextFormField(
                                                                                        onSaved: (value) {
                                                                                          setState(() {
                                                                                            note = value;
                                                                                          });
                                                                                        },
                                                                                        autofocus: true,
                                                                                        initialValue: note == "" ? snapshot.data[indexa].note : note,
                                                                                        keyboardType: TextInputType.multiline,
                                                                                        maxLines: null,
                                                                                        decoration: InputDecoration(prefix: Text(" "), alignLabelWithHint: true, hintText: "Note", hintStyle: TextStyle(), border: OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.circular(20))),
                                                                                      ),
                                                                                    )
                                                                                  : Text(note == "" ? snapshot.data[indexa].note : note),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Positioned(
                                                                      right: 20,
                                                                      top: 10,
                                                                      child: editNote ==
                                                                              true
                                                                          ? TextButton(
                                                                              child: Text(
                                                                                "save",
                                                                                style: TextStyle(color: Colors.cyan),
                                                                              ),
                                                                              onPressed: () async {
                                                                                _globalKey2.currentState.save();
                                                                                await recipeProvider.editRecipe(note, snapshot.data[indexa].id);
                                                                                setState(() {});
                                                                                setState(() {
                                                                                  editNote = false;
                                                                                });
                                                                              },
                                                                            )
                                                                          : IconButton(
                                                                              icon: Icon(
                                                                                Icons.edit,
                                                                                color: Colors.cyan,
                                                                              ),
                                                                              onPressed: () {
                                                                                setState(() {
                                                                                  editNote = true;
                                                                                });
                                                                              },
                                                                            )),
                                                                ],
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                        Row(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceAround,
                                                          children: [
                                                            TextButton(
                                                                onPressed: () {
                                                                  Scaffold.of(
                                                                          context)
                                                                      .showBottomSheet(
                                                                          (context) =>
                                                                              StatefulBuilder(builder: (BuildContext context, setState) {
                                                                                return Container(
                                                                                  height: height,
                                                                                  margin: EdgeInsets.only(top: 20),
                                                                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
                                                                                  child: ListView(
                                                                                    shrinkWrap: true,
                                                                                    physics: AlwaysScrollableScrollPhysics(),
                                                                                    children: [
                                                                                      Row(
                                                                                        children: [
                                                                                          Expanded(child: SelectableText("  #" + snapshot.data[indexa].title + "  ", style: TextStyle(color: Colors.cyan, fontSize: 25, fontWeight: FontWeight.bold))),
                                                                                          IconButton(
                                                                                            icon: Icon(
                                                                                              Icons.close,
                                                                                              color: Colors.red,
                                                                                            ),
                                                                                            onPressed: () {
                                                                                              titles.clear();
                                                                                              _globalKey.currentState.reset();

                                                                                              Navigator.of(context).pop();
                                                                                              changet0Value = false;
                                                                                            },
                                                                                          )
                                                                                        ],
                                                                                      ),
                                                                                      Form(
                                                                                        key: _globalKey,
                                                                                        child: TextFormField(
                                                                                            validator: (value) {
                                                                                              if (value.isEmpty) {
                                                                                                return " Enter the general weight ";
                                                                                              }
                                                                                              return null;
                                                                                            },
                                                                                            onSaved: (value) {
                                                                                              newNew = double.parse(value);
                                                                                            },
                                                                                            keyboardType: TextInputType.number,
                                                                                            controller: textEditingController,
                                                                                            decoration: InputDecoration(
                                                                                              filled: true,
                                                                                              fillColor: Colors.black87,
                                                                                              helperText: "The weight of the recipe",
                                                                                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                                                                                              hintText: "General weight",
                                                                                            )),
                                                                                      ),
                                                                                      FlatButton(
                                                                                        onPressed: () {
                                                                                          if (_globalKey.currentState.validate()) {
                                                                                            _globalKey.currentState.save();
                                                                                            setState(() {
                                                                                              changet0Value = !changet0Value;
                                                                                            });
                                                                                          }
                                                                                        },
                                                                                        child: changet0Value ? Text("Calculate percentage") : Text("Calculate weight"),
                                                                                        color: Colors.cyan,
                                                                                      ),
                                                                                      newNew == null
                                                                                          ? Text("")
                                                                                          : Card(
                                                                                              elevation: 20,
                                                                                              child: Padding(
                                                                                                padding: const EdgeInsets.all(15.0),
                                                                                                child: Row(
                                                                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                                  children: [
                                                                                                    Container(
                                                                                                        width: 200,
                                                                                                        child: Text(
                                                                                                          "General price : " + ((newNew * double.parse(snapshot.data[indexa].price)) / double.parse(snapshot.data[indexa].weight)).toStringAsFixed(2),
                                                                                                          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green[100]),
                                                                                                        )),
                                                                                                  ],
                                                                                                ),
                                                                                                // child: Center(
                                                                                                //     child: Text(
                                                                                                //   "General price : " + ((newNew * double.parse(snapshot.data[indexa].price) ) / double.parse( snapshot.data[indexa].weight) ).toStringAsFixed(2),
                                                                                                //   style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green[100]),
                                                                                                // )),
                                                                                              )),
                                                                                      Container(
                                                                                        // height: height,
                                                                                        child: ListView.builder(
                                                                                          shrinkWrap: true,
                                                                                          physics: NeverScrollableScrollPhysics(),
                                                                                          itemCount: snapshot.data[indexa].ingredients.length,
                                                                                          itemBuilder: (BuildContext context, int index) {
                                                                                            return Card(
                                                                                                elevation: 20,
                                                                                                child: Padding(
                                                                                                  padding: const EdgeInsets.all(15.0),
                                                                                                  child: Row(
                                                                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                                    children: [
                                                                                                      Container(
                                                                                                        width: 200,
                                                                                                        child: Text(
                                                                                                          snapshot.data[indexa].ingredients[index].title + " : ",
                                                                                                          style: TextStyle(color: Colors.cyan, fontSize: 15, fontWeight: FontWeight.bold),
                                                                                                        ),
                                                                                                      ),
                                                                                                      changet0Value ? Text((((weights[index] / double.parse(snapshot.data[indexa].weight))) * newNew).toStringAsFixed(2) + " гр") : Text(((weights[index] / double.parse(snapshot.data[indexa].weight)) * 100).toStringAsFixed(2) + "%"),
                                                                                                    ],
                                                                                                  ),
                                                                                                ));
                                                                                          },
                                                                                        ),
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                );
                                                                              }),
                                                                          elevation:
                                                                              20,
                                                                          backgroundColor:
                                                                              Colors.black);
                                                                },
                                                                style: ButtonStyle(
                                                                    backgroundColor: MaterialStateProperty.all<
                                                                            Color>(
                                                                        Colors
                                                                            .cyan)),
                                                                child: Text(
                                                                  "Use this Recipe",
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white),
                                                                )),
                                                            TextButton(
                                                                onPressed: () {
                                                                  String copy = titles
                                                                      .toString()
                                                                      .toString()
                                                                      .replaceAll(
                                                                          "{",
                                                                          "");
                                                                  String
                                                                      newString =
                                                                      copy.replaceAll(
                                                                          "}",
                                                                          "");
                                                                  String
                                                                      newNrw =
                                                                      newString.replaceAll(
                                                                          ",",
                                                                          "\n");
                                                                  FlutterClipboard
                                                                      .copy(
                                                                          newNrw);
                                                                },
                                                                style: ButtonStyle(
                                                                    backgroundColor: MaterialStateProperty.all<
                                                                            Color>(
                                                                        Colors
                                                                            .cyan)),
                                                                child: Text(
                                                                  "Copy this Recipe",
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white),
                                                                ))
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                  );
                                                }),
                                                elevation: 20,
                                              );
                                            },
                                            icon: Icon(
                                                Icons.arrow_drop_down_circle)),
                                    IconButton(
                                        icon: Icon(
                                          Icons.delete,
                                        ),
                                        onPressed: () {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content:
                                                  Text("Do you want to remove"),
                                              action: SnackBarAction(
                                                label: "remove",
                                                onPressed: () {
                                                  recipeProvider.removeRecipe(
                                                      snapshot.data[indexa].id);
                                                },
                                              ),
                                            ),
                                          );
                                        })
                                  ],
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    );
            },
          ),
        )

        // body: ListView.builder(
        //   itemCount: receipts.length,
        //   itemBuilder: (BuildContext context, int index) {
        //     return Card(
        //       elevation: 20,
        //       child: Column(
        //         children: [
        //           ListTile(
        //             title: Text("Цена : " +
        //                 receipts[index].totalprice.toStringAsFixed(2)),
        //             leading: Text(receipts[index].title),
        //             trailing: Text("Весь : " +
        //                 receipts[index].totalWeight.toStringAsFixed(2)),
        //           ),
        //           opendown == true
        //               ? Text("")
        //               : Container(
        //                 width: double.infinity,
        //                   color: Colors.blue,
        //                   height: 100,
        //                   child: Text(receipts[index].text),
        //       ),

        //         ],
        //       ),
        //     );
        //   },
        // ),
        );
  }
}
