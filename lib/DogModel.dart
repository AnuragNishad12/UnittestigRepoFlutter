import 'dart:convert';

class DogModel {
  var message;
  var status;

  DogModel({required this.message, required this.status});

  factory DogModel.fromJson(Map<String, dynamic> json) {
    return DogModel(
      message: json['message'] ?? "",
      status: json['status'] ?? "",
    );
  }
}
