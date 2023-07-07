import 'package:flutter/material.dart';

class ReviewItem extends StatelessWidget {
  final String userName;

  final String date;
  final String review;
  const ReviewItem(
      {super.key,
      required this.userName,
      required this.date,
      required this.review});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
          color: const Color(0xfff3ecfa),
          borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(userName, style: Theme.of(context).textTheme.titleMedium),
              Text(date, style: Theme.of(context).textTheme.bodySmall),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Text(review,
              textAlign: TextAlign.justify,
              style: Theme.of(context).textTheme.bodyLarge),
        ],
      ),
    );
  }
}
