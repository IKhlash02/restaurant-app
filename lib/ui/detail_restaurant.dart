import 'package:flutter/material.dart';

import 'package:project_1/data/api/api_service.dart';
import 'package:project_1/provider/add_review_provider.dart';
import 'package:project_1/provider/database_provider.dart';

import 'package:project_1/provider/restauran_detail_provider.dart';
import 'package:project_1/ui/add_review_page.dart';
import 'package:project_1/widget/submit_button.dart';
import 'package:provider/provider.dart';

import '../common/result_state.dart';
import '../data/model/restaurant_elemen.dart';
import '../widget/box_list.dart';
import '../widget/review_item.dart';
import 'detail_review.dart';

class RestaurantDetailPage extends StatelessWidget {
  static const routeName = '/restaurant_detail';

  final RestaurantElement restaurantElement;

  const RestaurantDetailPage({Key? key, required this.restaurantElement})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(restaurantElement.name),
      ),
      body: SingleChildScrollView(
        child: Consumer<RestaurantDetailProvider>(builder: (context, state, _) {
          if (state.state == ResultState.loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state.state == ResultState.hasData) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Hero(
                      tag: restaurantElement.name,
                      child: Image.network(
                        "${ApiService.imageLarge}${state.result.pictureId}",
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      bottom: -25,
                      right: MediaQuery.of(context).size.width / 10,
                      child: Consumer<DatabaseProvider>(
                          builder: (context, state, _) {
                        return FutureBuilder<bool>(
                            future: state.isBookmarked(restaurantElement.id),
                            builder: (context, snapshot) {
                              var isBookmarked = snapshot.data ?? false;
                              return InkWell(
                                borderRadius: BorderRadius.circular(25),
                                onTap: () {
                                  if (isBookmarked) {
                                    Provider.of<DatabaseProvider>(context,
                                            listen: false)
                                        .removeBookmark(restaurantElement.id);
                                  } else {
                                    Provider.of<DatabaseProvider>(context,
                                            listen: false)
                                        .addBookmark(restaurantElement);
                                  }
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(0),
                                  width: 50,
                                  height: 50,
                                  decoration: const BoxDecoration(
                                      shape: BoxShape.circle),
                                  child: Card(
                                    elevation: 4,
                                    shape: const CircleBorder(),
                                    child: (isBookmarked)
                                        ? Icon(
                                            Icons.favorite,
                                            size: 25,
                                            color: Colors.red[400],
                                          )
                                        : Icon(Icons.favorite_border,
                                            color: Colors.red[400], size: 25),
                                  ),
                                ),
                              );
                            });
                      }),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        state.result.name,
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),
                      const SizedBox(
                        height: 7,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          const Icon(Icons.location_on_outlined),
                          Text("${state.result.city}, ${state.result.address}")
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          const Icon(Icons.star_border_outlined),
                          Text(state.result.rating.toString())
                        ],
                      ),
                      const Divider(color: Colors.grey),
                      Container(
                          padding: const EdgeInsets.only(top: 10, bottom: 5),
                          child: Text(
                            'Description',
                            style: Theme.of(context).textTheme.titleMedium,
                          )),
                      Text(
                        state.result.description,
                        maxLines: 8,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const Divider(color: Colors.grey),
                      Container(
                          padding: const EdgeInsets.only(top: 10, bottom: 5),
                          child: Text(
                            'Menus',
                            style: Theme.of(context).textTheme.titleMedium,
                          )),
                      const Text('Foods: '),
                      SizedBox(
                        height: 40,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemCount: state.result.menus.foods.length,
                          itemBuilder: (context, index) {
                            return BoxList(
                              title: state.result.menus.foods[index].name,
                            );
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text('drinks : '),
                      SizedBox(
                        height: 40,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemCount: state.result.menus.drinks.length,
                          itemBuilder: (context, index) {
                            return BoxList(
                              title: state.result.menus.drinks[index].name,
                            );
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Divider(color: Colors.grey),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Ulasan",
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          TextButton(
                            onPressed: () {
                              showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
                                  builder: (BuildContext ctx) {
                                    return DetailReview(
                                      restaurantDetail: state.result,
                                    );
                                  });
                            },
                            child: Text("Lihat Semua",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall!
                                    .copyWith(color: Colors.deepPurple)),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      ReviewItem(
                        date: state.result.customerReviews[0].date,
                        review: state.result.customerReviews[0].review,
                        userName: state.result.customerReviews[0].name,
                      ),
                      const Divider(color: Colors.grey),
                      const SizedBox(
                        height: 10,
                      ),
                      SubmitButton(
                          text: "Add Review",
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(
                              builder: (_) {
                                return ChangeNotifierProvider(
                                  create: (_) => AddReviewProvider(
                                      ApiService(), state.result.id),
                                  child: AddReviewPage(
                                      pictureId: state.result.pictureId,
                                      name: state.result.name),
                                );
                              },
                            ));
                          })
                    ],
                  ),
                ),
              ],
            );
          } else if (state.state == ResultState.error) {
            return Center(
              child: Material(
                child: Text(state.message),
              ),
            );
          } else {
            return const SizedBox();
          }
        }),
      ),
    );
  }
}
