import 'dart:convert';
import 'package:esprit_kpi/ui/student_details.dart';
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

class TeacherStudentsList extends StatefulWidget {
  final String idclasse;
  const TeacherStudentsList({Key? key, required this.idclasse}) : super(key: key);

  @override
  State<TeacherStudentsList> createState() => _TeacherStudentsListState();
}

class _TeacherStudentsListState extends State<TeacherStudentsList> {
  List<Student> _studentList = [];

  Future<List<Student>> getStudentsList(String idclasse) async {
    final classeList = await StudentApi().getStudentsByClasse(idclasse);
    setState(() {
      _studentList = classeList;
    });
    return classeList;
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
    getStudentsList(widget.idclasse);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final ImageProvider _imageProvider;
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 80.0,
          backgroundColor: Colors.white,
          title: Container(
            width: 150,
            child: Image.asset('assets/images/logoEsprit.png'),
          ),
          iconTheme: const IconThemeData(color: Color(0xFFcf171f), size: 50),
          centerTitle: true,
        ),
        drawer: TeacherDrawer(),
        backgroundColor: Colors.white,
        body: SafeArea(
          child: ListView.builder(
            itemCount: _studentList.length,
            itemBuilder: (BuildContext context, int index) {
              return InkWell(
                onTap: () => {
                Navigator.push(context, MaterialPageRoute(
          builder: (context) => StudentsDetails(idstudent: _studentList[index].id),
        ))
              },
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Container(
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                        color: Colors.grey[100],
                        border: Border.all(
                          color: Color(0xFFcf171f),
                        ),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20))),
                    height: 100,
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 35,
                            backgroundImage: NetworkImage('$baseURL/uploads/' +
                                _studentList[index].photo),
                          ),
                          SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _studentList[index].firstName +
                                    " " +
                                    _studentList[index].lastName,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                _studentList[index].cin,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Text(
                                _studentList[index].email,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                          Spacer(),
                          Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  _sendMail(_studentList[index].email);
                                },
                                child: Icon(
                                  Icons.mail_outline,
                                  size: 22.0,
                                ),
                              ),
                              Spacer(),
                              InkWell(
                                onTap: () {
                                  Clipboard.setData(ClipboardData(
                                          text: _studentList[index].email))
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
                                ),
                              ),
                              Spacer(),
                              InkWell(
                                onTap: () {
                                  _launchCaller(_studentList[index].phone);
                                },
                                child: Icon(Icons.phone, size: 22.0),
                              )
                            ],
                          )
                        ]),
                  ),
                ),
              );
            },
          ),
        ));
  }
}
