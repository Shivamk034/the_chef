import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import '../keys/keys.dart';

class apiServices {
  static Future<List<Map<String, dynamic>>> getRecipes(String query) async {
    String url = 'https://api.spoonacular.com/recipes/searchComplex?apiKey=$apiKey&query=$query&number=8&addRecipeInformation=true';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
          return parseRecipe(response.body);
      } else {
        // Handle the case where the API request failed
        log('Failed to fetch recipes. Status code: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      // Handle other potential errors during the API request
      log('Error during API request: $e');
      return [];
    }
  }

  static List<Map<String, dynamic>> parseRecipe(String responseBody) {
    final parsed = jsonDecode(responseBody);
    return parsed['results'].map<Map<String, dynamic>>((recipe) {
      return {
        'image': recipe['image'],
        'label': recipe['title'],
        'serving': recipe['servings']?.toString() ?? '',
        'instruction': recipe['analyzedInstructions'],
      };
    }).toList();
  }
}