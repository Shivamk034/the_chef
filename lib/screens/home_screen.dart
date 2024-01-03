import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';
import 'package:gap/gap.dart';
import 'package:the_chef/screens/recipe_page.dart';
import 'package:the_chef/utils/api_service.dart';
import 'package:the_chef/widgets/categories.dart';
import 'package:the_chef/widgets/dish_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _controller = TextEditingController();
  int currentIndex = 0;
  List<Map<String, dynamic>> recipes = [];
  // SwiperController swiperController = SwiperController();

  Future<void> getRecipes(String query) async{
    final List<Map<String, dynamic>> results = await apiServices.getRecipes(query);
    setState(() {
      recipes = results;
    });
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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Hi, Shivam',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                            )),
                        Row(
                          children: [
                            const Icon(
                              Icons.notifications,
                              size: 30,
                            ),
                            const Gap(20),
                            GestureDetector(
                              onTap: () async {
                                FirebaseAuth.instance.signOut();
                              },
                              child: const Icon(
                                Icons.logout,
                                size: 30,
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  const Gap(20),
                  Container(
                    margin: const EdgeInsets.only(top: 10),
                    child: TextField(
                      controller: _controller,
                      onSubmitted: (query) {
                        getRecipes(query);
                      },
                      decoration: InputDecoration(
                          hintText: 'Search for Recipes',
                          isDense: true,
                          suffixIcon: GestureDetector(onTap:() => getRecipes(_controller.text), child: const Icon(Icons.search)),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0)
                          )),
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
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          DishCard(
                            image: 'assets/images/pizza.jpg',
                            dishName: 'Pizza',
                          ),
                          const Gap(20),
                          DishCard(
                              image: 'assets/images/burger.jpg',
                              dishName: 'Burger'),
                          const Gap(20),
                          DishCard(
                            image: 'assets/images/chicken_masala.jpeg',
                            dishName: 'Chicken Masala',
                          ),
                          const Gap(20),
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
                          // controller: swiperController,
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
                          duration: 800,
                          itemBuilder: (context, index) {
                            final recipe = recipes[index];
                            return ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Container(
                                color: Colors.grey.shade100,
                                child: Column(
                                  children: [
                                    Image.network(recipe['image'], fit: BoxFit.cover, height: 220, width: 250,),
                                    const Gap(5),
                                    Text(recipe['label'],overflow: TextOverflow.ellipsis, textAlign: TextAlign.center, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 18,),),
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
                          // controller: swiperController,
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
                          duration: 800,
                          itemBuilder: (context, index) {
                            return ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Container(
                                padding: const EdgeInsets.all(10),
                                color: Colors.grey.shade100,
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