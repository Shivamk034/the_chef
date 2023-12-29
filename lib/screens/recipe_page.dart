import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class RecipeScreen extends StatelessWidget {
  final Map<String, dynamic> recipe;
  final int currentIndex;

  const RecipeScreen({required this.recipe, required this.currentIndex, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Recipe',
          style: TextStyle(
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Hero(
                  tag: 'recipeImage_${recipe['label']}',
                  child: Text(
                    recipe['label'],
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                ),
                const Gap(10),
                Center(
                  child: Hero(
                    tag: 'recipeImage_${recipe['label']}_$currentIndex',
                    child: Container(
                      height: 200, // Set the height as needed
                      decoration:  BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(recipe['image'] ?? ''), // Provide the image asset path
                          fit: BoxFit.cover, // Adjust the BoxFit as needed
                        ),
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                  ),
                ),
                const Gap(10),
                const Text(
                  'Ingredients',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600
                  ),
                ),
                const Gap(10),
                for (var ingredient in recipe['ingredients'] ?? [])
                  ListTile(
                    leading: const Text('•', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 30)),
                    title: Text(ingredient),
                  ),
                const Gap(10),
                const Text(
                  'Instructions',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600
                  ),
                ),
                const Gap(10),
                if (recipe['instructions']?.isNotEmpty == true)
                  for (var instruction in recipe['instructions']!)
                    ListTile(
                      leading: const Text('•', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 30)),
                      title: Text(instruction),
                    )
                else
                  const Text('No instructions available.', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18)),
              ],
            ),
          ),
        ),
      ),
      );
  }
}
