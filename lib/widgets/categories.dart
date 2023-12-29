import 'package:flutter/material.dart';

class Category extends StatefulWidget {
  final String categoryName;
  const Category({super.key, required this.categoryName});

  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  bool selected = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        setState(() {
          selected = !selected;
        });
      },
      child: Container(
        width: 100,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: selected ? const Color(0xff6fb7bc) : const Color(0xfff0f4f4),
            borderRadius: BorderRadius.circular(50),
        ),
        child: Text(
          widget.categoryName,
          style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: selected ? Colors.white : Colors.black,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
