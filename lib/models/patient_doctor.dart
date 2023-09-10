class PatientDoctor {
  int? id;
  String? username;
  String? firstName;
  String? lastName;
  String? middleName;
  String? dateOfBirth;
  String? address;
  String? postCode;
  String? phoneNumber;
  String? role;
  String? gender;
  String? email;
  Null? emailVerifiedAt;
  String? createdAt;
  String? updatedAt;

  PatientDoctor(
      {this.id,
      this.username,
      this.firstName,
      this.lastName,
      this.middleName,
      this.dateOfBirth,
      this.address,
      this.postCode,
      this.phoneNumber,
      this.role,
      this.gender,
      this.email,
      this.emailVerifiedAt,
      this.createdAt,
      this.updatedAt});

  PatientDoctor.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    middleName = json['middleName'];
    dateOfBirth = json['dateOfBirth'];
    address = json['address'];
    postCode = json['postCode'];
    phoneNumber = json['phoneNumber'];
    role = json['role'];
    gender = json['gender'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['middleName'] = this.middleName;
    data['dateOfBirth'] = this.dateOfBirth;
    data['address'] = this.address;
    data['postCode'] = this.postCode;
    data['phoneNumber'] = this.phoneNumber;
    data['role'] = this.role;
    data['gender'] = this.gender;
    data['email'] = this.email;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
