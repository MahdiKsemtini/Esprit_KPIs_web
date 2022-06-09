import 'dart:convert';

import 'package:esprit_kpi/models/student.dart';
import 'package:esprit_kpi/util/constantes.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class StudentApi {
  Future<String> studentLogin(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseURL/students/authenticate'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{'email': email, 'password': password}),
    );
    final responseBody = jsonDecode(response.body);
    if (response.statusCode == 200) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString("token", responseBody["token"]);
      final studentJson = responseBody["student"];
      print(studentJson);
      final student = Student.fromJson(studentJson);
      if (studentJson["classe"] != null) {
        student.classeName = studentJson["classe"]["name"];
        student.classeId = studentJson["classe"]["id"];
      }
      await prefs.setBool("isLogedIn", true);
      await prefs.setString("student", json.encode(student.toJson()));
      return responseBody["message"];
    } else {
      return responseBody["message"];
    }
  }

  Future<List<Student>> getStudentsByClasse(String classeId) async {
    final response = await http.get(
      Uri.parse('$baseURL/students/classe/$classeId'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => Student.fromJson(data)).toList();
    } else {
      throw Exception('Unexpected error occured!');
    }
  }

  Future<Student> getStudentsById(String id) async {
    final response = await http.get(
      Uri.parse('$baseURL/students/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    if (response.statusCode == 200) {
      final responseBody = json.decode(response.body);
      final studentJson = responseBody;
      final student = Student.fromJson(studentJson);
        student.classeName = studentJson["classe"]["name"];
        student.classeId = studentJson["classe"]["id"];
      return student;
      
    } else {
      throw Exception('Unexpected error occured!');
    }
  }

  Future<List<Student>> getAllStudents() async {
    final response = await http.get(
      Uri.parse('$baseURL/students/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => Student.fromJson(data)).toList();
    } else {
      throw Exception('Unexpected error occured!');
    }
  }

  Future<String?> updateProfilePic( String studentId, String filePath) async {
    var request = http.MultipartRequest(
        'PUT',
        Uri.parse(
            '$baseURL/students/photo/$studentId'));
    request.files.add(await http.MultipartFile.fromPath(
        'photo', filePath));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  }
}
