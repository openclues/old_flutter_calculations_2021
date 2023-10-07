import 'dart:convert';
import 'dart:io';

import 'package:calculations/modles/recipe.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class RecipeProvider with ChangeNotifier {
  String resNote = "";

  changeNote(String note) {
    resNote = note;
    notifyListeners();
  }

  Future<String> _getToken() async {
    final storage = await FlutterSecureStorage().read(key: 'token');
    return storage;
  }

  urlhelperGet(String url) async {
    String token = await _getToken();
    http.Response response = await http.get(url, headers: {
      HttpHeaders.authorizationHeader: "Bearer $token",
    });
    String message = jsonDecode(response.body)['message'];
    print(message);

    return message;
  }

  urlhelperPost(String url) async {
    String token = await _getToken();
    http.Response response = await http.post(url, headers: {
      HttpHeaders.authorizationHeader: "Bearer $token",
    });
    String message = jsonDecode(response.body)['message'];
    print(message);

    return message;
  }

  addrecipe(
      {String title,
      String note,
      double weight,
      double price,
      String weights,
      List<int> ids,
      int status}) async {
    await urlhelperPost(
        'https://share.softkeyzone.com/api/res?title=$title&price=$price&weight=$weight&note=$note&i=$ids&status=$status&weights=$weights');

    notifyListeners();
  }

  Future<List<Recipe>> getRecipeIngredients() async {
    String token = await _getToken();
    http.Response response =
        await http.get('https://share.softkeyzone.com/api/res', headers: {
      HttpHeaders.authorizationHeader: "Bearer $token",
    });

    Map<String, dynamic> data = jsonDecode(response.body);
    List<Recipe> recipe =
        (data['data'] as List).map((e) => Recipe.fromJson(e)).toList();
    notifyListeners();
    return recipe;
  }

  Future<List<Recipe>> getPublicRecipes() async {
    String token = await _getToken();
    http.Response response =
        await http.get('https://share.softkeyzone.com/api/res/all', headers: {
      HttpHeaders.authorizationHeader: "Bearer $token",
    });
    var data = jsonDecode(response.body);
    List<Recipe> recipe =
        (data as List).map((e) => Recipe.fromJson(e)).toList();

    print(recipe.toString());
    return recipe;
  }

  Future<Recipe> getRecipeByid(int id) async {
    List<Recipe> recipe = await getPublicRecipes();
    Recipe recip = recipe.where((element) => element.id == id).first;
    notifyListeners();
    return recip;
  }

  removeRecipe(int id) async {
    String token = await _getToken();
    http.Response response = await http
        .delete('https://share.softkeyzone.com/api/res/$id', headers: {
      HttpHeaders.authorizationHeader: "Bearer $token",
    });

    notifyListeners();
  }

  showOneRecipe() {}

  editRecipe(String note, int id) async {
    String token = await _getToken();
    http.Response response = await http
        .post('https://share.softkeyzone.com/api/res/$id?note=$note', headers: {
      HttpHeaders.authorizationHeader: "Bearer $token",
    });
    notifyListeners();
  }
}
