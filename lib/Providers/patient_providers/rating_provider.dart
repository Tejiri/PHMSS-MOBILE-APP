import 'package:flutter/material.dart';
import 'package:phmss_patient_app/models/rating.dart';

class RatingProvider extends ChangeNotifier {
  Rating? rating;

  void setRating(Rating? ratingToSet) {
    rating = ratingToSet;
    notifyListeners();
  }

  // Method to update user from JSON object
  void updateRatingFromJson(Map<String, dynamic> json) {
    rating = Rating.fromJson(json);
    notifyListeners();
  }
}