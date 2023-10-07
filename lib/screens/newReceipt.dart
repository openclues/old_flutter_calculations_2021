import 'package:calculations/database.dart';
import 'package:calculations/modles/ingredient.dart';
import 'package:calculations/modles/reciept.dart';
import 'package:calculations/providers/ingredientProvider.dart';
import 'package:calculations/providers/recipeProvider.dart';
import 'package:calculations/screens/allrecipts.dart';
import 'package:calculations/screens/homepage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:convert';

class NewReciept extends StatefulWidget {
  @override
  _NewRecieptState createState() => _NewRecieptState();
}

class _NewRecieptState extends State<NewReciept> {
  @override
  void initState() {
    super.initState();
    resss();
  }

  ScrollController _controller = new ScrollController();
  GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  List<Recipt> allRes;

  Future<List<Recipt>> resss() async {
    allRes = await SQLiteDbProvider.db.getAllRes();
    return allRes;
  }

  String title;
  String status = 'Private';
  bool preventGoback = false;
  double weights;
  String note;
  List<double> v = [];
  @override
  Widget build(BuildContext context) {
    var recipeProvider = Provider.of<RecipeProvider>(context);
    // var productsData = Provider.of<ProductProvider>(context);
    var ingredients = Provider.of<IngredientProvider>(context);
    var selectedIngredients = ingredients.selected;
    var allIngredients = ingredients.getUserIngredients();

    return WillPopScope(
      onWillPop: () async => preventGoback ? false : true,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(" New recipt"),
        ),
        body: ingredients.selected.isEmpty || ingredients.selected == null
            ? Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  "There is no data, Go back and Long press on ingredients you need to add to your new recipe.",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    height: 1.4,
                    fontSize: 18,
                  ),
                ),
              )
            : ListView(
                physics: AlwaysScrollableScrollPhysics(),
                controller: _controller,
                children: [
                  FutureBuilder<List<Ing>>(
                      future: allIngredients,
                      builder: (BuildContext context,
                          AsyncSnapshot<List<Ing>> snapshot) {
                        List<Ing> product;
                        try {
                          product = snapshot.data
                              .where((element) =>
                                  selectedIngredients.contains(element.id))
                              .toList();
                        } catch (e) {
                          print(e.toString());
                        }
                        return product == null
                            ? Center(
                                child: CircularProgressIndicator(),
                              )
                            : Form(
                                key: _globalKey,
                                child: ListView(
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 8.0, left: 15, right: 15),
                                      child: TextFormField(
                                        autofocus: true,
                                        validator: (value) {
                                          if (value.isEmpty) {
                                            return "Add the recipt Title";
                                          } else if (allRes.any((element) =>
                                              element.title == value)) {
                                            return "please another a title, this already used";
                                          }
                                          return null;
                                        },
                                        onSaved: (value) {
                                          title = value;
                                        },
                                        decoration: InputDecoration(
                                            prefix: Text(" "),
                                            alignLabelWithHint: true,
                                            hintText: "The name of the recipe ",
                                            hintStyle: TextStyle(),
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20))),
                                      ),
                                    ),
                                    // DropdownButton(
                                    //   value: status,
                                    //   autofocus: true,
                                    //   onChanged: (value) {
                                    //     setState(() {
                                    //       status = value;
                                    //     });
                                    //   },
                                    //   items: <String>['Private', 'Public']
                                    //       .map<DropdownMenuItem<String>>(
                                    //           (String value) {
                                    //     return DropdownMenuItem<String>(
                                    //       value: value,
                                    //       child: Text(value),
                                    //     );
                                    //   }).toList(),
                                    // ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 8.0, left: 15, right: 15),
                                      child: TextFormField(
                                        keyboardType: TextInputType.multiline,
                                        maxLines: null,
                                        onSaved: (value) {
                                          note = value;
                                        },
                                        decoration: InputDecoration(
                                            prefix: Text(" "),
                                            alignLabelWithHint: true,
                                            hintText: "Note",
                                            hintStyle: TextStyle(),
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20))),
                                      ),
                                    ),
                                    ListView.builder(
                                      physics: NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: selectedIngredients.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return Padding(
                                          padding: const EdgeInsets.only(
                                              top: 8.0, left: 15, right: 15),
                                          child: TextFormField(
                                            keyboardType: TextInputType.number,
                                            validator: (value) {
                                              if (value.isEmpty) {
                                                return "please add weight ";
                                              }
                                              return null;
                                            },
                                            onSaved: (value) {
                                              v.add(double.parse(value));
                                              weights = double.parse(value);
                                              print("weights =" +
                                                  weights.toString());
                                              ingredients.updatevalues(
                                                  productsUpdate: snapshot.data
                                                      .where((element) =>
                                                          selectedIngredients
                                                              .contains(
                                                                  element.id))
                                                      .toList()[index],
                                                  value: weights);
                                            },
                                            decoration: InputDecoration(
                                                filled: true,
                                                border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20)),
                                                hintText: "Weight of  " +
                                                    product[index].title),
                                          ),
                                        );
                                      },
                                    ),
                                    Container(
                                      width: double.infinity,
                                      child: Builder(
                                        builder: (context) => Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 16.0),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            child: FlatButton(
                                              color: Colors.pink,
                                              onPressed: () {
                                                if (_globalKey.currentState
                                                    .validate()) {
                                                  setState(() {
                                                    preventGoback =
                                                        !preventGoback;
                                                  });
                                                  _globalKey.currentState
                                                      .save();
                                                  if (ingredients.totalWeight !=
                                                          0.0 &&
                                                      ingredients.total !=
                                                          0.0) {
                                                    recipeProvider.addrecipe(
                                                        weights: v.toString(),
                                                        status: 1,
                                                        title: title,
                                                        note: note,
                                                        weight: ingredients
                                                            .totalWeight,
                                                        price:
                                                            ingredients.total,
                                                        ids: ingredients
                                                            .selected);
                                                  }
                                                  selectedIngredients.clear();
                                                  showBottomSheet(
                                                    backgroundColor:
                                                        Colors.white,
                                                    context: context,
                                                    builder: (context) =>
                                                        Column(
                                                      children: [
                                                        SizedBox(
                                                          height: 20,
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceAround,
                                                          children: [
                                                            Center(
                                                              child: Text(
                                                                " General price :",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        20,
                                                                    color: Colors
                                                                        .green,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                            ),
                                                            Text(
                                                              ingredients.total
                                                                      .toStringAsFixed(
                                                                          2) +
                                                                  " грн ",
                                                              style: TextStyle(
                                                                  fontSize: 20,
                                                                  color: Colors
                                                                      .black),
                                                            ),
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          height: 10,
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceAround,
                                                          children: [
                                                            Center(
                                                              child: Text(
                                                                " General weight :",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        20,
                                                                    color: Colors
                                                                        .green,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                            ),
                                                            Text(
                                                              ingredients
                                                                      .totalWeight
                                                                      .toStringAsFixed(
                                                                          2) +
                                                                  " гр ",
                                                              style: TextStyle(
                                                                fontSize: 20,
                                                                color: Colors
                                                                    .black,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          height: 40,
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceAround,
                                                          children: [
                                                            GestureDetector(
                                                              onTap: () {
                                                                ingredients
                                                                    .selected
                                                                    .clear();
                                                                ingredients
                                                                        .total =
                                                                    0.0;
                                                                ingredients
                                                                        .totalWeight =
                                                                    0.0;

                                                                Navigator.pushAndRemoveUntil(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                        builder:
                                                                            (context) =>
                                                                                AllReceipts()),
                                                                    (Route<dynamic>
                                                                            route) =>
                                                                        false);
                                                              },
                                                              child: Card(
                                                                elevation: 20,
                                                                child:
                                                                    Container(
                                                                  padding:
                                                                      EdgeInsets
                                                                          .all(
                                                                              20),
                                                                  child: Column(
                                                                    children: [
                                                                      Icon(
                                                                        Icons
                                                                            .library_books,
                                                                        size:
                                                                            60,
                                                                        color: Colors
                                                                            .cyan,
                                                                      ),
                                                                      Text(
                                                                          "All receipts")
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            GestureDetector(
                                                              onTap: () {
                                                                ingredients
                                                                    .selected
                                                                    .clear();
                                                                ingredients
                                                                        .total =
                                                                    0.0;
                                                                ingredients
                                                                        .totalWeight =
                                                                    0.0;
                                                                Navigator.pushAndRemoveUntil(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                        builder:
                                                                            (context) =>
                                                                                MyHomePage()),
                                                                    (Route<dynamic>
                                                                            route) =>
                                                                        false);
                                                              },
                                                              child: Card(
                                                                elevation: 20,
                                                                child:
                                                                    Container(
                                                                  padding:
                                                                      EdgeInsets
                                                                          .all(
                                                                              20),
                                                                  child: Column(
                                                                    children: [
                                                                      Icon(
                                                                        Icons
                                                                            .book,
                                                                        size:
                                                                            60,
                                                                        color: Colors
                                                                            .cyan,
                                                                      ),
                                                                      Text(
                                                                          "New recipt")
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                  );
                                                }
                                              },
                                              child: Text(
                                                "Make a new recipe",
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Text("")
                                  ],
                                ),
                              );
                      }),
                ],
              ),
      ),
    );
  }
}
