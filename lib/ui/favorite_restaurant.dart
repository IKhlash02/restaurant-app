import 'package:flutter/material.dart';
import 'package:project_1/provider/database_provider.dart';

import 'package:provider/provider.dart';

import '../common/result_state.dart';

import '../widget/card_list_restaurant.dart';

class FavoriteRestaurantPage extends StatelessWidget {
  const FavoriteRestaurantPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const SizedBox(
            height: 5,
          ),
          Text(
            "Favorites",
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(
            height: 10,
          ),
          Consumer<DatabaseProvider>(
            builder: (context, state, _) {
              if (state.state == ResultState.loading) {
                return const Expanded(
                    child: Center(child: CircularProgressIndicator()));
              } else if (state.state == ResultState.hasData) {
                final restaurantData = state.bookmarks;
                debugPrint(restaurantData.length.toString());
                return Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: restaurantData.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: CardListRestaurant(
                          restaurantData: restaurantData[index],
                        ),
                      );
                    },
                  ),
                );
              } else if (state.state == ResultState.noData) {
                return Expanded(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.bookmark_outline,
                          size: 70,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(state.message)
                      ],
                    ),
                  ),
                );
              } else if (state.state == ResultState.error) {
                return Center(
                  child: Material(
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height / 4),
                      child: Text(state.message),
                    ),
                  ),
                );
              } else {
                return const Center(
                  child: Material(
                    child: Text(""),
                  ),
                );
              }
            },
          )
        ]),
      ),
    );
  }
}
