import 'package:flutter/material.dart';

class StarRating extends StatefulWidget {
  const StarRating({super.key});

  @override
  State<StarRating> createState() => _StarRatingState();
}

class _StarRatingState extends State<StarRating> {
  int _rating = 0;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          '$_rating.0',
          textAlign: TextAlign.end,
          style: const TextStyle(
            fontSize: 16,
            color: Color(0xFF4B2F34),
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(width: 5),
        Row(
          children: List.generate(5, (index) {
            return IconButton(
              iconSize: 25,
              padding: EdgeInsets.zero,
              icon: Icon(
                index < _rating ? Icons.star : Icons.star_border,
                color: Colors.amber,
              ),
              onPressed: () {
                setState(() {
                  _rating = index + 1;
                });
              },
            );
          }),
        ),
      ],
    );
  }
}
