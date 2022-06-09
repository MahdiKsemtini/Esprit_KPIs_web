import 'dart:convert';

import 'package:esprit_kpi/ui/student_classlist.dart';
import 'package:esprit_kpi/ui/teacher_classlist.dart';
import 'package:esprit_kpi/ui/widgets/student_drawer.dart';
import 'package:esprit_kpi/ui/widgets/teacher_drawer.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import "package:http/http.dart" as http;

import 'widgets/custon_button.dart';

class TeacherClassesNiveaux extends StatefulWidget {
  const TeacherClassesNiveaux({Key? key}) : super(key: key);

  @override
  State<TeacherClassesNiveaux> createState() => _TeacherClassesNiveauxState();
}

class _TeacherClassesNiveauxState extends State<TeacherClassesNiveaux> {
  late TooltipBehavior _tooltip;
  final List<String> entries = <String>[
    '1ére Année',
    '2éme Année',
    '3éme Année',
    '4éme Année',
    '5éme Année'
  ];
  final List<int> niveaux = <int>[1, 2, 3, 4, 5];

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
            child: ListView.separated(
          padding: const EdgeInsets.all(8),
          itemCount: entries.length,
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
              onTap: () => {
                Navigator.push(context, MaterialPageRoute(
          builder: (context) => TeacherClassesList( niveaux: niveaux[index]),
        ))
              },
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.grey[300],
                    border: Border.all(
                      color: Colors.grey,
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(20))),
                height: 110,
                child: Center(
                  child: Text(
                    entries[index],
                    style: const TextStyle(
                      color: Color(0xFFcf171f),
                      fontSize: 30,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index) =>
              const Divider(),
        )));
  }
}
