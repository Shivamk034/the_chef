import 'package:flutter/material.dart';

class DishCard extends StatefulWidget {
  final String image;
  final String dishName;
  const DishCard({Key? key, required this.image, required this.dishName}): super(key: key);

  @override
  State<DishCard> createState() => _DishCardState();
}

class _DishCardState extends State<DishCard> {

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 130,
          width: 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            image: DecorationImage(
                image: AssetImage(
                    widget.image,
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
          child: Text(widget.dishName,
            textAlign: TextAlign.center,
            style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 20,
              color: Colors.white,
            ),),
        ),
      ],
    );
  }
}
