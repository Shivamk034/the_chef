import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class FeaturedRecipe extends StatelessWidget {
  final String recipeName;
  final String recipeImage;
  final List recipeInstruction;
  final List recipeIngredients;

  const FeaturedRecipe({required this.recipeName, required this.recipeImage, required this.recipeIngredients, required this.recipeInstruction, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recipe', style: TextStyle(fontWeight: FontWeight.w500),),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(recipeName, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),),
                const Gap(10),
                Center(
                  child: Container(
                    height: 200,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(recipeImage),
                        fit: BoxFit.cover
                      ),
                      borderRadius: BorderRadius.circular(20.0),
                      color: Colors.red
                    ),
                  ),
                ),
                const Gap(10),
                const Text('Ingredients', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),),
                for(var i in recipeIngredients)
                  ListTile(
                    leading: const Text('•', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 30)),
                    title: Text(i),
                  ),
                const Gap(10),
                const Text('Instructions', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),),
                for(var i in recipeInstruction)
                  ListTile(
                    leading: const Text('•', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 30)),
                    title: Text(i),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
