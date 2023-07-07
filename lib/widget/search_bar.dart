import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_1/provider/restaurant_search_provider.dart';
import 'package:provider/provider.dart';

class SearchButton extends StatefulWidget {
  const SearchButton({super.key});

  @override
  State<SearchButton> createState() => _SearchButtonState();
}

class _SearchButtonState extends State<SearchButton> {
  final TextEditingController _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: TextField(
        onSubmitted: (value) {
          Provider.of<RestaurantSearchProvider>(context, listen: false)
              .searchRestaurant(value);
        },
        controller: _searchController,
        decoration: InputDecoration(
          filled: true,

          fillColor: const Color(0xfff3ecfa),
          hintText: 'Search restaurant ...',
          hintStyle: GoogleFonts.plusJakartaSans(
              fontSize: 13,
              fontWeight: FontWeight.w400,
              letterSpacing: 0.5,
              color: Colors.black),
          // Add a clear button to the search bar
          suffixIcon: IconButton(
            icon: const Icon(Icons.clear),
            onPressed: () => _searchController.clear(),
          ),
          // Add a search icon or button to the search bar
          prefixIcon: IconButton(
            icon: const Icon(
              Icons.search,
              color: Colors.black,
            ),
            onPressed: () {
              Provider.of<RestaurantSearchProvider>(context, listen: false)
                  .searchRestaurant(_searchController.text);
            },
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      ),
    );
  }
}
