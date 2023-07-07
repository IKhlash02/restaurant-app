import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../data/model/restaurant_detail.dart';
import '../widget/review_item.dart';

class DetailReview extends StatelessWidget {
  final RestaurantDetail restaurantDetail;

  const DetailReview({super.key, required this.restaurantDetail});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(8.0),
      child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 30,
              bottom: 0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 32,
                  width: 32,
                  margin: const EdgeInsets.all(0),
                  padding: const EdgeInsets.all(0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.deepPurple[100],
                  ),
                  child: IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.arrow_back),
                    color: Colors.white,
                    iconSize: 18,
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 15,
                      ),
                      Center(
                        child: Text("ULASAN PRODUK",
                            style: Theme.of(context).textTheme.titleMedium),
                      ),
                      const SizedBox(
                        height: 7,
                      ),
                      RatingBar(
                        initialRating: restaurantDetail.rating,
                        minRating: 0,
                        maxRating: 5,
                        itemSize: 25,
                        itemCount: 5,
                        allowHalfRating: true,
                        onRatingUpdate: (value) {},
                        ratingWidget: RatingWidget(
                          full: const Icon(
                            Icons.star,
                            color: Colors.yellow,
                          ),
                          half: const Icon(
                            Icons.star_half_outlined,
                            color: Colors.yellow,
                          ),
                          empty: const Icon(
                            Icons.star_outline,
                            color: Colors.yellow,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 7,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "${restaurantDetail.rating}/5",
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          Text(
                            "(${restaurantDetail.customerReviews.length} ulasan)",
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 40,
                )
              ],
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ReviewItem(
                  date: restaurantDetail.customerReviews[index].date,
                  userName: restaurantDetail.customerReviews[index].name,
                  review: restaurantDetail.customerReviews[index].review,
                ),
              );
            },
            itemCount: restaurantDetail.customerReviews.length,
          )
        ],
      ),
    );
  }
}
