import 'dart:convert';

import 'package:esprit_kpi/models/branche.dart';
import 'package:esprit_kpi/models/classe.dart';
import 'package:esprit_kpi/models/nbClasseByNiveau.dart';
import 'package:esprit_kpi/util/constantes.dart';
import 'package:http/http.dart' as http;

class ClasseApi {
  Future<List<Classe>> getClassesByNiveau(int level) async {
    final response = await http.get(
      Uri.parse('$baseURL/classes/niveau/${level.toString()}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => Classe.fromJson(data)).toList();
    }
    else{
      throw Exception('Unexpected error occured!');
    }
  }


  Future<List<Classe>> getAllClasses() async {
    final response = await http.get(
      Uri.parse('$baseURL/classes/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => Classe.fromJson(data)).toList();
    } else {
      throw Exception('Unexpected error occured!');
    }
  }


  Future<List<Nbclassebyniveau>> getNbClasseByNiveau() async {
    final response = await http.get(
      Uri.parse('$baseURL/classes/nv'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => Nbclassebyniveau.fromJson(data)).toList();
    } else {
      throw Exception('Unexpected error occured!');
    }
  }



  Future<List<Branche>> getBranches(int level) async {
    final response = await http.get(
      Uri.parse('$baseURL/classes/branche/${level.toString()}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => Branche.fromJson(data)).toList();
    } else {
      throw Exception('Unexpected error occured!');
    }
  }

  Future<List<Classe>> getByBranche(int level,String branche) async {
    final response = await http.get(
      Uri.parse('$baseURL/classes/br/$level/?name=$branche'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => Classe.fromJson(data)).toList();
    } else {
      throw Exception('Unexpected error occured!');
    }
  }
}