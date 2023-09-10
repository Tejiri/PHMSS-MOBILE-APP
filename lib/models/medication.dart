class Medication {
  int? id;
  String? name;
  String? description;
  String? dosage;
  String? frequency;
  Null? imageUrl;
  Null? createdAt;
  Null? updatedAt;

  Medication(
      {this.id,
      this.name,
      this.description,
      this.dosage,
      this.frequency,
      this.imageUrl,
      this.createdAt,
      this.updatedAt});

  Medication.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    dosage = json['dosage'];
    frequency = json['frequency'];
    imageUrl = json['imageUrl'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['dosage'] = this.dosage;
    data['frequency'] = this.frequency;
    data['imageUrl'] = this.imageUrl;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
