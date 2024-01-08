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
                const Gap(10),
                const Text(
                  'Ingredients',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600
                  ),
                ),

                for(var prep in recipe['instruction'])
                  for(var step in prep['steps'])
                    for (var ingredient in step['ingredients'])
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: Row(
                          children: [
                            const Text('\u2022',  style: TextStyle(fontSize: 30)),
                            const Gap(27),
                            Text(ingredient['name'], style: const TextStyle(fontSize: 16),),
                          ],
                        ),
                      ),
                const Gap(10),
                const Text(
                  'Instructions',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600
                  ),
                ),
                for(var prep in recipe['instruction'])
                  for(var step in prep['steps'])
                      ListTile(
                        dense: true,
                        leading: const Text('\u2022',  style: TextStyle(fontSize: 30)),
                        title: Text(step['step'], style: const TextStyle(fontSize: 16),),
                      )
              ],
            ),
          ),
        ),
      ),
      );
  }
}
