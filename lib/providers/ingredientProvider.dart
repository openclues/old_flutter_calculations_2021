import 'dart:convert';
import 'dart:io';
import 'package:calculations/modles/ingredient.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class IngredientProvider with ChangeNotifier {
  double total = 0.0;
  double totalWeight = 0.0;

  Future<String> _getToken() async {
    final storage = await FlutterSecureStorage().read(key: 'token');
    return storage;
  }

  urlhelperPost(String url) async {
    String token = await _getToken();
    http.Response response = await http.post(url, headers: {
      HttpHeaders.authorizationHeader: "Bearer $token",
    });
    print(response.body);
    return jsonDecode(response.body);
  }

  urlhelperGet(String url) async {
    String token = await _getToken();
    http.Response response = await http.get(url, headers: {
      HttpHeaders.authorizationHeader: "Bearer $token",
    });
    print(response.body);
    return jsonDecode(response.body);
  }

  List<int> selected = [];

  void addIngredientToselected(int id) {
    if (selected.contains(id)) {
      selected.remove(id);
    } else {
      selected.add(id);
    }
    notifyListeners();
  }

  void addIngredient(String name, String category, double price, double weight,
      String note, String expiry) async {
    await urlhelperPost(
        'https://share.softkeyzone.com/api/ing?title=$name&price=$price&weight=$weight&note=$note&category=$category&expiry_data=$expiry');

    notifyListeners();
  }

  editIngredient(
      {int id,
      String name,
      String category,
      double price,
      double weight,
      String note,
      DateTime expiry}) async {
    await urlhelperPost(
        'https://share.softkeyzone.com/api/ing/$id?title=$name&price=$price&weight=$weight&note=$note&category=$category&expiry_data=$expiry');

    notifyListeners();
  }

  Future<List<Ing>> getUserIngredients({String search}) async {
    String token = await _getToken();
    http.Response response =
        await http.get('https://share.softkeyzone.com/api/ing', headers: {
      HttpHeaders.authorizationHeader: "Bearer $token",
    });

    List<Ing> ingredients = (json.decode(response.body) as List)
        .map((i) => Ing.fromJson(i))
        .toList();

    print(ingredients.length);

    if (search == null) {
      return ingredients.toList();
    } else {
      return ingredients
          .where((element) =>
              element.note.contains(search) ||
              element.title.contains(search) ||
              element.price.contains(search))
          .toList();
    }
  }

  Map updatevalues({
    Ing productsUpdate,
    double value,
  }) {
    var totalamount = (value * double.parse(productsUpdate.price)) /
        double.parse(productsUpdate.weight);

    total += totalamount;
    totalWeight += value;

    notifyListeners();
    // print(value);
    return {total: totalWeight};
  }

  // Future<String> getPriceForAllingredients() async {
  //   var sum = 0.0;
  //   var products = await getUserIngredients();
  //   products.forEach((e) {
  //     sum += e.price;
  //   });
  //   return sum.toStringAsFixed(1);
  // }

  removeIngredient(int id) async {
    String token = await _getToken();
    http.Response response = await http
        .delete('https://share.softkeyzone.com/api/ing/$id', headers: {
      HttpHeaders.authorizationHeader: "Bearer $token",
    });

    notifyListeners();
  }

  // Future<String> getWeightForAllIngredients() async {
  //   var sum = 0.0;
  //   var products = await getUserIngredients();
  //   products.forEach((e) {
  //     sum +=  double.parse(e.weight);
  //   });
  //   notifyListeners();
  //   return sum.toStringAsFixed(1);
  // }

  getPublicRecipes() {}

  deleteRecipe() {}

  showOneRecipe() {}
}
