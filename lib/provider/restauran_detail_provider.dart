import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:project_1/data/api/api_service.dart';
import 'package:project_1/data/model/restaurant_detail.dart';

import '../common/result_state.dart';

class RestaurantDetailProvider extends ChangeNotifier {
  final ApiService apiService;

  RestaurantDetailProvider({required this.apiService});

  String _message = "";
  late RestaurantDetail _detailRestaurant;
  late ResultState _state;

  void fecthRestauran(String id) {
    _fechtDetailrestaurant(id);
  }

  String get message => _message;

  RestaurantDetail get result => _detailRestaurant;

  ResultState get state => _state;

  Future<dynamic> _fechtDetailrestaurant(String id) async {
    try {
      _state = ResultState.loading;
      notifyListeners();

      final restaurant = await apiService.detailRestaurant(id);

      _state = ResultState.hasData;
      notifyListeners();
      return _detailRestaurant = restaurant;
    } catch (e) {
      String errorMessage = "An error occurred";

      // Menyesuaikan pesan error berdasarkan jenis kesalahan yang terjadi
      if (e is SocketException) {
        errorMessage = "No internet connection";
      } else if (e is TimeoutException) {
        errorMessage = "Request timed out";
      } else if (e is FormatException) {
        errorMessage = "Invalid data format";
      }

      _state = ResultState.error;
      notifyListeners();
      return _message = errorMessage;
    }
  }
}
