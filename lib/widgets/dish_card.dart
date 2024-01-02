import 'package:flutter/material.dart';
import 'package:the_chef/screens/recipes_info_page.dart';
import 'package:the_chef/utils/featured_recipes_info.dart';

class DishCard extends StatelessWidget {
  final String image;
  final String dishName;
  DishCard({Key? key, required this.image, required this.dishName}): super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> ingredients = [];
    List<String> instructions = [];

    if(dishName == 'Chicken Masala'){
      ingredients = chickenMasalaIngredients;
      instructions = chickenMasalaInstructions;
    } else if(dishName == 'Pizza') {
      ingredients = pizzaIngredients;
      instructions = pizzaInstructions;
    } else if(dishName == 'Burger') {
      ingredients = burgerIngredients;
      instructions = burgerInstructions;
    } else if(dishName == 'Dal Tadka') {
      ingredients = dalIngredients;
      instructions = dalInstructions;
    }

    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(
            builder: (context) => FeaturedRecipe(
                recipeName: dishName,
                recipeImage: image,
                recipeIngredients: ingredients,
                recipeInstruction: instructions,
            )
          )
        );
      },
      child: Stack(
        children: [
          Container(
            height: 130,
            width: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              image: DecorationImage(
                  image: AssetImage(
                      image,
                  ),
                fit: BoxFit.fill,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  offset: const Offset(1, 0.0),
                  blurRadius: 5
                )
              ]
            ),
          ),
          Container(
            height: 24,
            width: 200,
            margin: const EdgeInsets.only(top: 118),
            decoration: const BoxDecoration(
              color: Colors.black,
              // color: Color(0xff103c4a),
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(16.0), bottomRight: Radius.circular(16.0))
            ),
            child: Text(dishName,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                color: Colors.white,
              ),),
          ),
        ],
      ),
    );
  }
}
