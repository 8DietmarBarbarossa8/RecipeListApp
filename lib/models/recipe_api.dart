import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:recipe_list_app/models/recipe.dart';

class RecipeApi {
  static Future<List<Recipe>> getRecipe() async {
    var uri = Uri.https('yummly2.p.rapidapi.com', '/feeds/list',
        {"limit": "18", "start": "0", "tag": "list.recipe.popular"});

    // const String apiKey = 'a5b803e08amsh3abe18ed5b25b2cp17090ajsn8c5c85b5b088';
    const String apiKey = '6f07218856msh01accedb70c8e16p17b360jsn0921f7de203f';

    final response = await http.get(uri, headers: {
      "x-rapidapi-key": apiKey,
      "x-rapidapi-host": "yummly2.p.rapidapi.com",
      "useQueryString": "true"
    });

    Map data = jsonDecode(response.body);
    List _temp = [];

    for (var i in data['feed']) {
      _temp.add(i['content']['details']);
    }

    return Recipe.recipesFromSnapshot(_temp);
  }
}
