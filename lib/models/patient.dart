// class Patient {
//   User? user;
//   String? token;
//   String? message;

//   Patient({this.user, this.token, this.message});

//   Patient.fromJson(Map<String, dynamic> json) {
//     user = json['user'] != null ? new User.fromJson(json['user']) : null;
//     token = json['token'];
//     message = json['message'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     if (this.user != null) {
//       data['user'] = this.user!.toJson();
//     }
//     data['token'] = this.token;
//     data['message'] = this.message;
//     return data;
//   }
// }

// class User {
//   int? id;
//   String? username;
//   String? firstName;
//   String? lastName;
//   String? middleName;
//   String? dateOfBirth;
//   String? address;
//   String? postCode;
//   String? phoneNumber;
//   String? role;
//   String? gender;
//   Null? emergencyName;
//   Null? emergencyPhoneNumber;
//   Null? emergencyEmail;
//   Null? emergencyRelationship;
//   String? email;
//   Null? emailVerifiedAt;
//   int? doctorId;
//   String? createdAt;
//   String? updatedAt;
//   Doctor? doctor;

//   User(
//       {this.id,
//       this.username,
//       this.firstName,
//       this.lastName,
//       this.middleName,
//       this.dateOfBirth,
//       this.address,
//       this.postCode,
//       this.phoneNumber,
//       this.role,
//       this.gender,
//       this.emergencyName,
//       this.emergencyPhoneNumber,
//       this.emergencyEmail,
//       this.emergencyRelationship,
//       this.email,
//       this.emailVerifiedAt,
//       this.doctorId,
//       this.createdAt,
//       this.updatedAt,
//       this.doctor});

//   User.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     username = json['username'];
//     firstName = json['firstName'];
//     lastName = json['lastName'];
//     middleName = json['middleName'];
//     dateOfBirth = json['dateOfBirth'];
//     address = json['address'];
//     postCode = json['postCode'];
//     phoneNumber = json['phoneNumber'];
//     role = json['role'];
//     gender = json['gender'];
//     emergencyName = json['emergencyName'];
//     emergencyPhoneNumber = json['emergencyPhoneNumber'];
//     emergencyEmail = json['emergencyEmail'];
//     emergencyRelationship = json['emergencyRelationship'];
//     email = json['email'];
//     emailVerifiedAt = json['email_verified_at'];
//     doctorId = json['doctorId'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//     doctor =
//         json['doctor'] != null ? new Doctor.fromJson(json['doctor']) : null;
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['username'] = this.username;
//     data['firstName'] = this.firstName;
//     data['lastName'] = this.lastName;
//     data['middleName'] = this.middleName;
//     data['dateOfBirth'] = this.dateOfBirth;
//     data['address'] = this.address;
//     data['postCode'] = this.postCode;
//     data['phoneNumber'] = this.phoneNumber;
//     data['role'] = this.role;
//     data['gender'] = this.gender;
//     data['emergencyName'] = this.emergencyName;
//     data['emergencyPhoneNumber'] = this.emergencyPhoneNumber;
//     data['emergencyEmail'] = this.emergencyEmail;
//     data['emergencyRelationship'] = this.emergencyRelationship;
//     data['email'] = this.email;
//     data['email_verified_at'] = this.emailVerifiedAt;
//     data['doctorId'] = this.doctorId;
//     data['created_at'] = this.createdAt;
//     data['updated_at'] = this.updatedAt;
//     if (this.doctor != null) {
//       data['doctor'] = this.doctor!.toJson();
//     }
//     return data;
//   }
// }

// class Doctor {
//   int? id;
//   String? username;
//   String? firstName;
//   String? lastName;
//   String? middleName;
//   String? dateOfBirth;
//   String? address;
//   String? postCode;
//   String? phoneNumber;
//   String? role;
//   String? gender;
//   String? email;
//   Null? emailVerifiedAt;
//   String? createdAt;
//   String? updatedAt;

//   Doctor(
//       {this.id,
//       this.username,
//       this.firstName,
//       this.lastName,
//       this.middleName,
//       this.dateOfBirth,
//       this.address,
//       this.postCode,
//       this.phoneNumber,
//       this.role,
//       this.gender,
//       this.email,
//       this.emailVerifiedAt,
//       this.createdAt,
//       this.updatedAt});

//   Doctor.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     username = json['username'];
//     firstName = json['firstName'];
//     lastName = json['lastName'];
//     middleName = json['middleName'];
//     dateOfBirth = json['dateOfBirth'];
//     address = json['address'];
//     postCode = json['postCode'];
//     phoneNumber = json['phoneNumber'];
//     role = json['role'];
//     gender = json['gender'];
//     email = json['email'];
//     emailVerifiedAt = json['email_verified_at'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['username'] = this.username;
//     data['firstName'] = this.firstName;
//     data['lastName'] = this.lastName;
//     data['middleName'] = this.middleName;
//     data['dateOfBirth'] = this.dateOfBirth;
//     data['address'] = this.address;
//     data['postCode'] = this.postCode;
//     data['phoneNumber'] = this.phoneNumber;
//     data['role'] = this.role;
//     data['gender'] = this.gender;
//     data['email'] = this.email;
//     data['email_verified_at'] = this.emailVerifiedAt;
//     data['created_at'] = this.createdAt;
//     data['updated_at'] = this.updatedAt;
//     return data;
//   }
// }