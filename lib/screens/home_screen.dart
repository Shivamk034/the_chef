import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';
import 'package:gap/gap.dart';
import 'package:the_chef/screens/recipe_page.dart';
import 'package:the_chef/widgets/categories.dart';
import 'package:the_chef/widgets/dish_card.dart';
import 'package:http/http.dart' as http;
import '../keys/keys.dart';
import 'dart:convert';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _controller = TextEditingController();
  int currentIndex = 0;
  List<Map<String, dynamic>> recipes = [];

  Future<void> getRecipes(String query) async {
    String url = 'https://api.edamam.com/search?q=$query&app_id=$appId&app_key=$apiKey';
    http.Response response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      setState(() {
        recipes = parseRecipes(response.body);
      });

      // Fetch detailed information for each recipe
      for (var i = 0; i < recipes.length; i++) {
        await getRecipeDetails(recipes[i]['label'], i);
      }
    } else {
      log('Failed to fetch recipes. Status code: ${response.statusCode}');
    }
  }

  Future<void> getRecipeDetails(String label, int index) async {
    String recipeUrl = 'https://api.edamam.com/search?q=$label&app_id=$appId&app_key=$apiKey'; // Use the correct API endpoint
    http.Response recipeResponse = await http.get(Uri.parse(recipeUrl));

    if (recipeResponse.statusCode == 200) {
      Map<String, dynamic> detailedRecipe = parseDetailedRecipe(recipeResponse.body);
      // log(detailedRecipe['instructions'].toString());
      setState(() {
        recipes[index]['ingredients'] = detailedRecipe['ingredients'];
        recipes[index]['instructions'] = detailedRecipe['instructions'];
      });
    } else {
      log('Failed to fetch recipe details. Status code: ${recipeResponse.statusCode}');
    }
  }

  Map<String, dynamic> parseDetailedRecipe(String responseBody) {
    final parsed = json.decode(responseBody);
    final List<dynamic> hits = parsed['hits'];

    // Extract detailed information for the first hit
    final detailedRecipeData = hits[0]['recipe'];

    return {
      'ingredients': detailedRecipeData['ingredientLines']?.cast<String>() ?? [],
      'instructions': detailedRecipeData['instructionLines']?.cast<String>() ?? [],
    };
  }

  List<Map<String, dynamic>> parseRecipes(String responseBody) {
    final parsed = json.decode(responseBody);
    final List<dynamic> hits = parsed['hits'];

    return hits.map<Map<String, dynamic>>((hit) {
      final recipeData = hit['recipe'];
      return {
        'image': recipeData['image'],
        'label': recipeData['label'],
        'serving': recipeData['yield']?.toInt().toString() ?? '',
      };
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    bool hasRecipes = recipes.isNotEmpty;
    return Scaffold(
        body: SingleChildScrollView(
          child: SafeArea(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              width: 380,
              // color: Colors.red,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 20),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Hi, Shivam',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                            )),
                        Icon(
                          Icons.notifications,
                          size: 30,
                        )
                      ],
                    ),
                  ),
                  const Gap(20),
                  Container(
                    margin: const EdgeInsets.only(top: 10),
                    child: TextField(
                      controller: _controller,
                      decoration: InputDecoration(
                          hintText: 'Search for Recipes',
                          suffixIcon: GestureDetector(onTap:() => getRecipes(_controller.text), child: const Icon(Icons.search)),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0))),
                    ),
                  ),
                  Container(
                      margin: const EdgeInsets.only(top: 20),
                      child: const Text(
                        'Featured',
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.w700),
                      )),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Container(
                      margin: const EdgeInsets.only(top: 10),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          DishCard(
                            image: 'assets/images/pizza.jpg',
                            dishName: 'Pizza',
                          ),
                          Gap(20),
                          DishCard(
                              image: 'assets/images/burger.jpg',
                              dishName: 'Burger'),
                          Gap(20),
                          DishCard(
                            image: 'assets/images/chicken_masala.jpeg',
                            dishName: 'Indian Chicken Masala',
                          ),
                          Gap(20),
                          DishCard(
                              image: 'assets/images/dal.jpg',
                              dishName: 'Dal Tadka'),
                        ],
                      ),
                    ),
                  ),
                  const Gap(20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Categories',
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.w700),
                      ),
                      TextButton(onPressed: (){}, child: const Text('See all', style: TextStyle(
                        fontSize: 17,
                        color: Colors.black
                      ),))
                    ],
                  ),
                  const Gap(10),
                  const SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        Category(categoryName: 'Breakfast'),
                        Gap(30),
                        Category(categoryName: 'lunch'),
                        Gap(30),
                        Category(categoryName: 'Dinner'),
                        Gap(20),
                        Category(categoryName: 'Snacks')
                      ],
                    ),
                  ),
                  const Gap(15),
                  InkWell(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () {
                      if (recipes.isNotEmpty) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              // Check if currentIndex is within the valid range
                              if (currentIndex >= 0 && currentIndex < recipes.length) {
                                return RecipeScreen(recipe: recipes[currentIndex], currentIndex: currentIndex);
                              } else {
                                // Handle the case where currentIndex is out of range
                                return const Scaffold(
                                  body: Center(
                                    child: Text('Recipe not available'),
                                  ),
                                );
                              }
                            },
                          ),
                        );
                      }
                    },
                    child: Center(
                      child: Hero(
                        tag: ValueKey<String>(recipes.isNotEmpty ? recipes[currentIndex]['label'] : ''),
                        child: hasRecipes ?
                        Swiper(
                          onIndexChanged: (index) {
                            setState(() {
                              currentIndex = index;
                            });
                          },
                          itemCount: recipes.length,
                          layout: SwiperLayout.CUSTOM,
                          customLayoutOption: CustomLayoutOption(startIndex: -1, stateCount: 3)
                            ..addRotate([-35.0 / 180, 0.0, 35.0 / 180])
                            ..addTranslate([
                              const Offset(-285.0, -30.0),
                              const Offset(0.0, 0.0),
                              const Offset(285.0, -30.0)
                            ]),
                          axisDirection: AxisDirection.right,
                          loop: true,
                          duration: 900,
                          itemBuilder: (context, index) {
                            final recipe = recipes[index];
                            return ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Container(
                                color: Colors.grey.shade50,
                                child: Column(
                                  children: [
                                    Image.network(recipe['image'], fit: BoxFit.cover, height: 220, width: 250,),
                                    const Gap(5),
                                    Text(recipe['label'], textAlign: TextAlign.center, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 18,),),
                                    const Gap(3),
                                    Text('Serving: ${recipe['serving']}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),),
                                  ],
                                ),
                              ),
                            );
                          },
                          itemHeight: 320,
                          itemWidth: 250,
                        ) : Swiper(
                          itemCount: 3,
                          layout: SwiperLayout.CUSTOM,
                          customLayoutOption: CustomLayoutOption(startIndex: -1, stateCount: 3)
                            ..addRotate([-35.0 / 180, 0.0, 35.0 / 180])
                            ..addTranslate([
                              const Offset(-285.0, -30.0),
                              const Offset(0.0, 0.0),
                              const Offset(285.0, -30.0)
                            ]),
                          axisDirection: AxisDirection.right,
                          loop: true,
                          duration: 900,
                          itemBuilder: (context, index) {
                            return ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Container(
                                padding: const EdgeInsets.all(10),
                                color: Colors.grey.shade50,
                                child: const Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('Your searched Recipes will appear here....', textAlign: TextAlign.center, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),),
                                  ],
                                ),
                              ),
                            );
                          },
                          itemHeight: 320,
                          itemWidth: 250,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
