class Appointment {
  int? id;
  String? reason;
  String? appointmentDetails;
  String? startTime;
  String? endTime;
  String? date;
  String? status;
  int? patientId;
  int? doctorId;
  String? createdAt;
  String? updatedAt;

  Appointment(
      {this.id,
      this.reason,
      this.appointmentDetails,
      this.startTime,
      this.endTime,
      this.date,
      this.status,
      this.patientId,
      this.doctorId,
      this.createdAt,
      this.updatedAt});

  Appointment.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    reason = json['reason'];
    appointmentDetails = json['appointmentDetails'];
    startTime = json['startTime'];
    endTime = json['endTime'];
    date = json['date'];
    status = json['status'];
    patientId = json['patientId'];
    doctorId = json['doctorId'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['reason'] = this.reason;
    data['appointmentDetails'] = this.appointmentDetails;
    data['startTime'] = this.startTime;
    data['endTime'] = this.endTime;
    data['date'] = this.date;
    data['status'] = this.status;
    data['patientId'] = this.patientId;
    data['doctorId'] = this.doctorId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
