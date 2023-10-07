import 'package:calculations/database.dart';
import 'package:calculations/modles/products.dart';
import 'package:calculations/providers/ingredientProvider.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class EditProduct extends StatefulWidget {
  final id;
  final intTitle;
  final intweight;
  final intprice;
  final initspecial;
  final initNote;
  final iniExpry;

  EditProduct(
      {@required this.iniExpry,
      this.initNote,
      this.id,
      this.intTitle,
      this.initspecial,
      this.intprice,
      this.intweight});

  @override
  _EditProductState createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
  bool openSearch = true;
  String expirydate;
  bool changeFuture = false;
  bool showSearchBar = false;
  String test = "";
  String search;
  final _formKey = GlobalKey<FormState>();
  var title;
  double price;
  DateTime selectedDate;
  String note;
  double weight;
  String specialLitter;
  @override
  Widget build(BuildContext context) {
    var data = Provider.of<IngredientProvider>(context);
    double hieght = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(title: Text("Edit  ")),
      body: ListView(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Container(
              height: hieght,
              child: Form(
                key: _formKey,
                child: ListView(
                  physics: ClampingScrollPhysics(),
                  shrinkWrap: true,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: TextFormField(
                        initialValue: widget.intTitle,
                        validator: (value) {
                          if (value.isEmpty) {
                            return "please add a title";
                          }
                          return null;
                        },
                        onSaved: (value) {
                          setState(() {
                            title = value;
                          });
                        },
                        decoration: InputDecoration(
                          filled: true,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20)),
                          hintText: "Ingredient",
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: TextFormField(
                        initialValue: widget.intprice,
                        validator: (value) {
                          if (value.isEmpty) {
                            return "please add a price";
                          }
                          return null;
                        },
                        keyboardType: TextInputType.number,
                        onSaved: (value) {
                          setState(() {
                            price = double.parse(value);
                          });
                        },
                        decoration: InputDecoration(
                          filled: true,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20)),
                          hintText: "Price",
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: TextFormField(
                        initialValue: widget.intweight,
                        validator: (value) {
                          if (value.isEmpty) {
                            return "please add a weight";
                          }
                          return null;
                        },
                        keyboardType: TextInputType.number,
                        onSaved: (value) {
                          setState(() {
                            weight = double.parse(value);
                          });
                        },
                        decoration: InputDecoration(
                          filled: true,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20)),
                          hintText: "Weight",
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: TextFormField(
                        initialValue: widget.initNote,
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        onSaved: (value) {
                          setState(() {
                            note = value;
                          });
                        },
                        decoration: InputDecoration(
                          filled: true,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20)),
                          hintText: "Note",
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: TextFormField(
                        initialValue: widget.initspecial,
                        validator: (value) {
                          if (value.isEmpty) {
                            return "please add a Category";
                          }
                          return null;
                        },
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(10),
                        ],
                        onSaved: (value) {
                          setState(() {
                            specialLitter = value;
                          });
                        },
                        decoration: InputDecoration(
                          filled: true,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20)),
                          hintText: "Category",
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: DateTimeField(
                        initialValue: DateTime.parse(widget.iniExpry),
                        onSaved: (value) {
                          setState(() {
                            selectedDate = value;
                          });
                        },
                        decoration: InputDecoration(
                          filled: true,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20)),
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
                              initialDate: currentValue ?? DateTime.now(),
                              lastDate: DateTime(2100));
                        },
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        _formKey.currentState.save();
                        setState(() {
                          data.editIngredient(
                              category: specialLitter,
                              expiry: selectedDate,
                              id: widget.id,
                              name: title,
                              price: price,
                              note: note,
                              weight: weight);
                        });

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
  }
}
