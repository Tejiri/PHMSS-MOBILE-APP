class PossibleIllness {
  int? id;
  String? name;
  String? description;
  Null? createdAt;
  Null? updatedAt;
  List<Symptoms>? symptoms;

  PossibleIllness(
      {this.id,
      this.name,
      this.description,
      this.createdAt,
      this.updatedAt,
      this.symptoms});

  PossibleIllness.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['symptoms'] != null) {
      symptoms = <Symptoms>[];
      json['symptoms'].forEach((v) {
        symptoms!.add(new Symptoms.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.symptoms != null) {
      data['symptoms'] = this.symptoms!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Symptoms {
  int? id;
  String? name;
  String? description;
  Null? createdAt;
  Null? updatedAt;

  Symptoms(
      {this.id, this.name, this.description, this.createdAt, this.updatedAt});

  Symptoms.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
