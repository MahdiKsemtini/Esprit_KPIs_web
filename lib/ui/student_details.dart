import 'dart:convert';
import 'package:esprit_kpi/ui/widgets/teacher_drawer.dart';
import 'package:esprit_kpi/util/constantes.dart';
import 'package:flutter/services.dart';

import 'package:esprit_kpi/models/student.dart';
import 'package:esprit_kpi/services/student_api.dart';
import 'package:esprit_kpi/ui/widgets/student_drawer.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import "package:http/http.dart" as http;
import 'package:url_launcher/url_launcher.dart';

import 'widgets/custon_button.dart';

class StudentsDetails extends StatefulWidget {
  final String idstudent;
  const StudentsDetails({Key? key, required this.idstudent}) : super(key: key);

  @override
  State<StudentsDetails> createState() => _StudentsDetailsState();
}

class _StudentsDetailsState extends State<StudentsDetails> {
  late Student _student = Student(
      id: "",
      cin: "",
      firstName: "",
      lastName: "",
      email: "",
      photo: "profile.png",
      birthDate: "",
      phone: "",
      classeName: "",
      classeId: "");

  Future<Student> getStudentById(String idstudent) async {
    final st = await StudentApi().getStudentsById(idstudent);
    setState(() {
      _student = st;
    });
    return st;
  }

  _launchCaller(String? phone) async {
    var url = "tel:$phone";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _sendMail(String? toemail) async {
    var url = "mailto:$toemail";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  void initState() {
    getStudentById(widget.idstudent);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final ImageProvider _imageProvider;
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 100.0,
          backgroundColor: Colors.white,
          title: Container(
            width: 180,
            child: Image.asset('assets/images/logoEsprit.png'),
          ),
          iconTheme: const IconThemeData(color: Color(0xFFcf171f), size: 50),
          centerTitle: true,
        ),
        drawer: TeacherDrawer(),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Container(
            color: Colors.grey[100],
            child: Column(
              children: [
                Container(
                  color: Colors.grey[100],
                  child: Stack(
                    children: [
                      Stack(
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 20, right: 20, top: 20),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                      child: Container(
                                        width: 50,
                                        height: 50,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          color: Colors.white,
                                        ),
                                        child: const Icon(
                                          Icons.arrow_back,
                                          color: Colors.red,
                                        ),
                                      ),
                                    ),
                                    Center(
                                      child: Text(
                                        "Student",
                                        style: const TextStyle(
                                          fontSize: 24,
                                        ),
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            _sendMail(_student.email);
                                          },
                                          child: Container(
                                            width: 50,
                                            height: 50,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              color: Colors.white,
                                            ),
                                            child: const Icon(
                                              Icons.mail,
                                              color: Colors.red,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          width: 10.0,
                                        ),
                                        InkWell(
                                          onTap: () {
                                            _launchCaller(_student.phone);
                                          },
                                          child: Container(
                                            width: 50,
                                            height: 50,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              color: Colors.white,
                                            ),
                                            child: const Icon(
                                              Icons.phone,
                                              color: Colors.red,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Center(
                                child: Container(
                                  margin: const EdgeInsets.only(top: 40),
                                  height: 100,
                                  width: 100,
                                  decoration: BoxDecoration(
                                      boxShadow: const [
                                        BoxShadow(
                                            spreadRadius: 0.1,
                                            blurRadius: 2,
                                            offset: Offset(0, 5))
                                      ],
                                      borderRadius: BorderRadius.circular(30),
                                      color: Colors.blueAccent,
                                      image: DecorationImage(
                                          image: NetworkImage(
                                              '$baseURL/uploads/' +
                                                  _student.photo),
                                          fit: BoxFit.cover)),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Center(
                                child: Text(
                                  _student.firstName + " " + _student.lastName,
                                  style: const TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Center(
                                child: Text(_student.email,
                                    style: const TextStyle(
                                        fontSize: 18, color: Colors.black54)),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50.0),
                        topRight: Radius.circular(50.0),
                      )),
                  child: Padding(
                    padding:
                        const EdgeInsets.only(top: 40, left: 20, right: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Name :",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "     " +
                              _student.firstName +
                              " " +
                              _student.lastName,
                          style: TextStyle(fontSize: 24),
                        ),
                        Row(
                          children: [
                            Text(
                              "Email :",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Spacer(),
                            InkWell(
                                onTap: () {
                                  Clipboard.setData(ClipboardData(
                                          text: _student.email))
                                      .then((_) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            content: Text(
                                                "Email address copied to clipboard")));
                                  });
                                  ;
                                },
                                child: Icon(
                                  Icons.copy,
                                  size: 22.0,
                                  color: Colors.red,
                                ),
                              ),
                          ],
                        ),
                        Text(
                          "     " + _student.email,
                          style: TextStyle(fontSize: 24),
                        ),
                        const Text(
                          "Phone N° :",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "     " + _student.phone,
                          style: TextStyle(fontSize: 24),
                        ),
                        const Text(
                          "Birth Date :",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "     " +
                              _student.birthDate.characters.take(10).toString(),
                          style: TextStyle(fontSize: 24),
                        ),
                        const Text(
                          "Classe :",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "     " + _student.classeName!,
                          style: TextStyle(fontSize: 24),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
