// import 'package:calculations/database.dart';
import 'package:calculations/modles/ingredient.dart';
// import 'package:calculations/modles/products.dart';
import 'package:calculations/providers/ingredientProvider.dart';
import 'package:intl/intl.dart';
import 'package:calculations/providers/loginProvider.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:calculations/screens/allrecipts.dart';
import 'package:calculations/screens/editProduct.dart';
import 'package:calculations/screens/info.dart';
import 'package:calculations/screens/tutorialScreen.dart';
import 'package:calculations/src/welcomePage.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:calculations/screens/newReceipt.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:animated_widgets/animated_widgets.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool openSearch = true;
  String expirydate;
  bool changeFuture = false;
  bool showSearchBar = false;
  String test = "";
  String search;
  final _formKey = GlobalKey<FormState>();
  var title;
  double price;
  String selectedDate;
  String note;
  double weight;
  String specialLitter;

  @override
  Widget build(BuildContext context) {
    double hieght = MediaQuery.of(context).size.height;
    final data = Provider.of<LoginRegister>(context);

    final ingredients = Provider.of<IngredientProvider>(context, listen: true);

    return Scaffold(
      // drawer: BuildDrawer() ,
      appBar: AppBar(
        elevation: 20,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: IconButton(
              icon: Icon(Icons.info),
              onPressed: () {
                ingredients.getUserIngredients();
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => InfoScreem()));
              },
            ),
          ),
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              data.logout();
              Navigator.pushAndRemoveUntil(context,
                  MaterialPageRoute(builder: (BuildContext context) {
                return WelcomePage();
              }), (route) => false);
            },
          ),
        ],
        bottom: AppBar(
            title: ingredients.selected.isNotEmpty
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                          onTap: () {
                            setState(() {
                              showSearchBar = !showSearchBar;
                            });
                            if (showSearchBar == false) {
                              search = "";
                            }
                          },
                          child: Image.asset(
                            'assets/images/search.png',
                            width: 40,
                          )),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => TranslationAnimatedWidget(
                                values: [
                                  Offset(0, -500), // disabled value value

                                  Offset(0, -500), //intermediate value

                                  Offset(0, 0) //enabled value
                                ],
                                child: NewReciept(),
                              ),
                            ),
                          );
                        },
                        child: Image.asset(
                          'assets/images/add.png',
                          width: 40,
                        ),
                      ),
                    ],
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                          onTap: () {
                            setState(() {
                              showSearchBar = !showSearchBar;
                            });
                            if (showSearchBar == false) {
                              search = "";
                            }
                          },
                          child: Image.asset(
                            'assets/images/search.png',
                            width: 40,
                          )),
                      GestureDetector(
                          onTap: () {
                            ingredients.selected.isEmpty
                                ? ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                          "You have to choose ingredients first, long press on ingredients you want to add"),
                                    ),
                                  )
                                : Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        TranslationAnimatedWidget(values: [
                                          Offset(
                                              0, -500), // disabled value value

                                          Offset(0, -500), //intermediate value

                                          Offset(0, 0) //enabled value
                                        ], child: NewReciept())));
                          },
                          child: Image.asset(
                            'assets/images/add.png',
                            width: 40,
                          )),
                      GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => AllReceipts()));
                          },
                          child: Image.asset(
                            'assets/images/clipboard.png',
                            width: 40,
                          )),
                      GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => TutorialScreen()));
                          },
                          child: Image.asset(
                            'assets/images/question-mark.png',
                            width: 40,
                          )),
                    ],
                  )),
        title: Text(
          "Hi Anastasiia",
          style: TextStyle(color: Colors.amber),
        ),
      ),
      body: Container(
        height: hieght,
        child: ListView(
          shrinkWrap: true,
          children: [
            showSearchBar
                ? Container(
                    padding: EdgeInsets.all(10.0),
                    child: Column(children: <Widget>[
                      Container(
                          padding: const EdgeInsets.all(8.0),
                          child: new Container(
                              height: 70.0,
                              child: new Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: new Card(
                                      child: new Container(
                                          child: new Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: <Widget>[
                                        new Icon(Icons.search),
                                        Expanded(
                                          child: new Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width -
                                                100.0,
                                            child: TextField(
                                                decoration: InputDecoration(
                                                  hintText:
                                                      '     Search for title, note or special Letter',
                                                ),
                                                onChanged: (String text) {
                                                  setState(() {
                                                    search = text;
                                                  });
                                                  if (showSearchBar == false) {
                                                    search = null;
                                                  }
                                                }),
                                          ),
                                        ),
                                        new IconButton(
                                          icon: Icon(Icons.close),
                                          onPressed: () {
                                            setState(() {
                                              showSearchBar = false;
                                            });
                                            search = "";
                                          },
                                        )
                                      ]))))))
                    ]))
                : Text(""),
            FutureBuilder(
              future: ingredients.getUserIngredients(search: search),
              // initialData: InitialData,
              builder:
                  (BuildContext context, AsyncSnapshot<List<Ing>> snapshot) {
                return snapshot.data == null
                    ? Center(child: CircularProgressIndicator())
                    : Container(
                        height: MediaQuery.of(context).size.height * 0.8,
                        child: ListView.builder(
                          physics: ClampingScrollPhysics(),
                          itemCount: snapshot.data.length,
                          itemBuilder: (BuildContext context, int index) {
                            Color _getColor() {
                              if (DateTime.parse(
                                          snapshot.data[index].expiryData)
                                      .difference(DateTime.now())
                                      .inDays >=
                                  90) {
                                return Colors.transparent;
                              } else if (DateTime.parse(
                                          snapshot.data[index].expiryData)
                                      .difference(DateTime.now())
                                      .inDays <=
                                  0) {
                                return Colors.red;
                              } else {
                                return Colors.orange;
                              }
                            }

                            return Card(
                              child: Stack(
                                children: [
                                  GestureDetector(
                                    onLongPress: () {
                                      ingredients.addIngredientToselected(
                                          snapshot.data[index].id);
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          color: ingredients.selected.contains(
                                                  snapshot.data[index].id)
                                              ? Colors.purple
                                              : Colors.black),
                                      child: ExpansionTileCard(
                                          baseColor: Colors.black54,
                                          expandedColor: Colors.black54,
                                          children: [
                                            Divider(
                                              thickness: 2.0,
                                              height: 1.0,
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Row(
                                                    children: <Widget>[
                                                      Text("Expiry : ",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.cyan)),
                                                      Text(DateTime.parse(snapshot
                                                                      .data[
                                                                          index]
                                                                      .expiryData)
                                                                  .difference(
                                                                      DateTime
                                                                          .now())
                                                                  .inDays <=
                                                              0
                                                          ? "Expired"
                                                          : "After " +
                                                              DateTime.parse(snapshot
                                                                      .data[
                                                                          index]
                                                                      .expiryData)
                                                                  .difference(
                                                                      DateTime
                                                                          .now())
                                                                  .inDays
                                                                  .toString() +
                                                              " days")
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Row(
                                                    children: <Widget>[
                                                      Text("Category : ",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.cyan)),
                                                      Text(snapshot
                                                          .data[index].category)
                                                    ],
                                                  ),
                                                ),
                                                Divider(
                                                  thickness: 2.0,
                                                  height: 1.0,
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text("Product Note : ",
                                                      style: TextStyle(
                                                          color: Colors.cyan)),
                                                ),
                                                Container(
                                                    width: 200,
                                                    margin: EdgeInsets.only(
                                                        left: 20,
                                                        top: 15,
                                                        bottom: 20,
                                                        right: 10),
                                                    child: snapshot.data[index]
                                                                .note !=
                                                            null
                                                        ? Text(snapshot
                                                            .data[index].note)
                                                        : Text("")),
                                              ],
                                            )
                                          ],
                                          title:
                                              Text(snapshot.data[index].title,
                                                  style: TextStyle(
                                                    color: Colors.cyan,
                                                  )),
                                          subtitle: Row(
                                            children: [
                                              Text("price : " +
                                                  snapshot.data[index].price
                                                      .toString() +
                                                  " "),
                                              Text(" || "),
                                              Container(
                                                child: Expanded(
                                                  child: Text(" Weight : " +
                                                      snapshot
                                                          .data[index].weight
                                                          .toString()),
                                                ),
                                              ),
                                            ],
                                          ),
                                          trailing: Text("")),
                                    ),
                                  ),
                                  Positioned(
                                    top: -10,
                                    right: 0,
                                    child: IconButton(
                                        icon: Icon(Icons.edit,
                                            color: Colors.lightGreenAccent),
                                        onPressed: () {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      EditProduct(
                                                        iniExpry: snapshot
                                                            .data[index]
                                                            .expiryData,
                                                        id: snapshot
                                                            .data[index].id,
                                                        intTitle: snapshot
                                                            .data[index].title,
                                                        initspecial: snapshot
                                                            .data[index]
                                                            .category,
                                                        intprice: snapshot
                                                            .data[index].price,
                                                        intweight: snapshot
                                                            .data[index].weight,
                                                        initNote: snapshot
                                                            .data[index].note,
                                                      )));
                                        }),
                                  ),
                                  Positioned(
                                    top: 30,
                                    right: 0,
                                    child: IconButton(
                                      icon: Icon(
                                        Icons.delete,
                                        color: Colors.cyan,
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
                                                ingredients.removeIngredient(
                                                    snapshot.data[index].id);
                                              },
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                  Container(
                                    height: 10,
                                    width: 10,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: _getColor()),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      );
              },
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            backgroundColor: Colors.black,
            isScrollControlled: true,
            elevation: 20,
            shape: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
            context: context,
            builder: (context) {
              return Container(
                height: hieght,
                child: ListView(
                  physics: ClampingScrollPhysics(),
                  shrinkWrap: true,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 100.0),
                      child: Container(
                        height: hieght,
                        child: Form(
                          key: _formKey,
                          child: ListView(
                            physics: ClampingScrollPhysics(),
                            shrinkWrap: true,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                child: TextFormField(
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return "please add a title";
                                    }
                                    return null;
                                  },
                                  onChanged: (value) {
                                    title = value;
                                  },
                                  decoration: InputDecoration(
                                    filled: true,
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    hintText: "Ingredient",
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                child: TextFormField(
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return "please add a price";
                                    }
                                    return null;
                                  },
                                  keyboardType: TextInputType.number,
                                  onChanged: (value) {
                                    price = double.parse(value);
                                  },
                                  decoration: InputDecoration(
                                    filled: true,
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    hintText: "Price",
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                child: TextFormField(
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return "please add a weight";
                                    }
                                    return null;
                                  },
                                  keyboardType: TextInputType.number,
                                  onChanged: (value) {
                                    weight = double.parse(value);
                                  },
                                  decoration: InputDecoration(
                                    filled: true,
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    hintText: "Weight",
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                child: TextFormField(
                                  keyboardType: TextInputType.multiline,
                                  maxLines: null,
                                  onChanged: (value) {
                                    note = value;
                                  },
                                  decoration: InputDecoration(
                                    filled: true,
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    hintText: "Note",
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                child: TextFormField(
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return "please add a Category";
                                    }
                                    return null;
                                  },
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(10),
                                  ],
                                  onChanged: (value) {
                                    specialLitter = value;
                                  },
                                  decoration: InputDecoration(
                                    filled: true,
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    hintText: "Category",
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                child: DateTimeField(
                                  onChanged: (value) {
                                    setState(() {
                                      selectedDate = value.toString();
                                    });
                                  },
                                  decoration: InputDecoration(
                                    filled: true,
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    hintText: "Expiry date",
                                  ),
                                  validator: (value) {
                                    if (value == null) {
                                      return " not right";
                                    } else {
                                      return null;
                                    }
                                  },
                                  format: DateFormat("yyyy-MM-dd"),
                                  onShowPicker: (context, currentValue) {
                                    return showDatePicker(
                                        context: context,
                                        firstDate: DateTime(1900),
                                        initialDate:
                                            currentValue ?? DateTime.now(),
                                        lastDate: DateTime(2100));
                                  },
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              GestureDetector(
                                onTap: () {
                                  if (_formKey.currentState.validate()) {
                                    setState(() {
                                      ingredients.addIngredient(
                                          title,
                                          specialLitter,
                                          price,
                                          weight,
                                          note,
                                          selectedDate);
                                    });
                                  }

                                  // SQLiteDbProvider.db.insert(Product(
                                  //     price: price,
                                  //     title: title,
                                  //     note: note,
                                  //     weight: weight,
                                  //     specialLetter: specialLitter));
                                  Navigator.of(context).pop();
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    height: 50,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.cyan,
                                    ),
                                    child: Center(child: Text("Add")),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
