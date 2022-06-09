import 'package:esprit_kpi/models/classe.dart';

class Student {
  final String id;
  final String cin;
  final String firstName;
  final String lastName;
  final String email;
  final String birthDate;
  late String photo;
  late String phone;
  late String? classeId;
  late String? classeName;

  Student(
      {required this.id,
      required this.cin,
      required this.firstName,
      required this.lastName,
      required this.email,
      required this.photo,
      required this.phone,
      required this.birthDate,
      this.classeId,
      this.classeName});

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      id: json['id'],
      cin: json['cin'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      photo: json['photo'],
      phone: json['phone']??"",
      birthDate: json['birthDate'],
      classeId: json['classeId'] ?? "",
      classeName: json['classeName'] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'cin': cin,
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'photo': photo,
        'phone': phone,
        'birthDate': birthDate,
        'classeId': classeId,
        'classeName': classeName,
      };
}
