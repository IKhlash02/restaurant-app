import 'package:flutter/material.dart';
import 'package:project_1/data/api/api_service.dart';

class AddReviewProvider extends ChangeNotifier {
  final ApiService apiService;
  final String id;

  AddReviewProvider(this.apiService, this.id);

  Future addReview(String review) async {
    try {
      await apiService.addCustomerReview(id, "Ikhlash", review);
      debugPrint("review succes");
    } catch (e, s) {
      debugPrint(s.toString());
      debugPrint(e.toString());
      throw Exception("Add review failed");
    }
  }
}
