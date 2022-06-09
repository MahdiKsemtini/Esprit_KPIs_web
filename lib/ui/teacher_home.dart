import 'dart:convert';

import 'package:esprit_kpi/models/classe.dart';
import 'package:esprit_kpi/models/nbClasseByNiveau.dart';
import 'package:esprit_kpi/models/student.dart';
import 'package:esprit_kpi/services/classe_api.dart';
import 'package:esprit_kpi/services/student_api.dart';
import 'package:esprit_kpi/ui/widgets/student_drawer.dart';
import 'package:esprit_kpi/ui/widgets/teacher_drawer.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import "package:http/http.dart" as http;

import 'widgets/custon_button.dart';

class TeacherHome extends StatefulWidget {
  const TeacherHome({Key? key}) : super(key: key);

  @override
  State<TeacherHome> createState() => _TeacherHomeState();
}

class _TeacherHomeState extends State<TeacherHome> {
  late TooltipBehavior _tooltip;





  @override
  void initState() {
    _tooltip = TooltipBehavior(enable: true);
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
            child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 15.0,
              ),
              
              
              Image.asset('assets/images/logoEsprit.png',
                  width: 300, height: 200, fit: BoxFit.contain),
              Container(
                color: Colors.pink, // Yellow
                height: 120.0,
              ),
              Text('Some Sample Text - 3', style: TextStyle(fontSize: 28)),
              Container(
                color: Colors.redAccent, // Yellow
                height: 120.0,
              ),
              Image.asset('assets/images/logoEsprit.png',
                  width: 300, height: 200, fit: BoxFit.contain),
              Container(
                color: Colors.green, // Yellow
                height: 120.0,
              ),
              Container(
                color: Colors.pink, // Yellow
                height: 120.0,
              ),
              Text('Some Sample Text - 1', style: TextStyle(fontSize: 28)),
              Text('Some Sample Text - 2', style: TextStyle(fontSize: 28)),
              Text('Some Sample Text - 3', style: TextStyle(fontSize: 28)),
              Container(
                color: Colors.redAccent, // Yellow
                height: 120.0,
              ),
            ],
          ),
        )));
  }
}

