import 'package:phmss_patient_app/controllers/random.dart';

class Rating {
  int? id;
  String? rating;
  String? description;
  int? patientId;
  int? doctorId;
  String? createdAt;
  String? updatedAt;

  Rating(
      {this.id,
      this.rating,
      this.description,
      this.patientId,
      this.doctorId,
      this.createdAt,
      this.updatedAt});

  Rating.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    rating = json['rating'];
    description = json['description'];
    patientId = json['patientId'];
    doctorId = convertStringToIntIfPossible(json['doctorId']);
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['rating'] = this.rating;
    data['description'] = this.description;
    data['patientId'] = this.patientId;
    data['doctorId'] = this.doctorId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
