import 'dart:convert';

import 'package:esprit_kpi/models/classe.dart';
import 'package:esprit_kpi/models/nbClasseByNiveau.dart';
import 'package:esprit_kpi/models/student.dart';
import 'package:esprit_kpi/services/classe_api.dart';
import 'package:esprit_kpi/services/student_api.dart';
import 'package:esprit_kpi/ui/widgets/student_drawer.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import "package:http/http.dart" as http;

import 'widgets/custon_button.dart';

class StudentHome extends StatefulWidget {
  const StudentHome({Key? key}) : super(key: key);

  @override
  State<StudentHome> createState() => _StudentHomeState();
}

class _StudentHomeState extends State<StudentHome> {
  late List<_ChartData> data;
  late TooltipBehavior _tooltip;

  List<Student> _studentList = [];
  List<Classe> _classeList = [];
  List<Nbclassebyniveau> _nbclasseList = [];

  Future<List<Student>> getStudentsList() async {
    final studentList = await StudentApi().getAllStudents();
    setState(() {
      _studentList = studentList;
    });
    return studentList;
  }

  Future<List<Classe>> getClassesList() async {
    final classeList = await ClasseApi().getAllClasses();
    setState(() {
      _classeList = classeList;
    });
    return classeList;
  }

  Future<List<Nbclassebyniveau>> getNbClassesByNiveau() async {
    final nbclasseList = await ClasseApi().getNbClasseByNiveau();
    setState(() {
      _nbclasseList = nbclasseList;
      for (var i=0 ; i<_nbclasseList.length ; i++) {
      data.add(_ChartData(_nbclasseList[i].niveau.toString(),_nbclasseList[i].nbclasse.toDouble()));
    }
    });
    return nbclasseList;
  }




  final List<ChartData2> chartData = [
    ChartData2('David', 10250, Colors.red),
    ChartData2('Jack', 7800, Colors.grey)
  ];

  @override
  void initState() {
    data =[];

    getNbClassesByNiveau();

    


    _tooltip = TooltipBehavior(enable: true);
    getStudentsList();
    getClassesList();
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
        drawer: StudentDrawer(),
        backgroundColor: Colors.white,
        body: SafeArea(
            child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 15.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    height: 100,
                    width: 170,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                      Text(_studentList.length.toString(), style: TextStyle(fontSize: 32,color: Color(0xFFcf171f))),
                      Text('Students', style: TextStyle(fontSize: 28,color: Color(0xFFcf171f))),
                    ],)
                  ),
                  Container(
                    height: 100,
                    width: 170,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                      Text(_classeList.length.toString(), style: TextStyle(fontSize: 32,color: Color(0xFFcf171f))),
                      Text('Classes', style: TextStyle(fontSize: 28,color: Color(0xFFcf171f))),
                    ],)
                  ),
                ],
              ),
              Container(
                height: 20.0,
              ),
              SfCartesianChart(
                  title: ChartTitle(
                      text: "Classes Number by level",
                      textStyle: const TextStyle(
                        color: Color(0xFFcf171f),
                        fontFamily: 'Roboto',
                        fontStyle: FontStyle.italic,
                        fontSize: 14,
                      )),
                  primaryXAxis: CategoryAxis(),
                  primaryYAxis:
                      NumericAxis(minimum: 0, maximum: 10, interval: 2),
                  tooltipBehavior: _tooltip,
                  series: <ChartSeries<_ChartData, String>>[
                    ColumnSeries<_ChartData, String>(
                        dataSource: data,
                        xValueMapper: (_ChartData data, _) => data.x,
                        yValueMapper: (_ChartData data, _) => data.y,
                        name: 'Classes number',
                        color: Color(0xFFcf171f))
                  ]),
              Container(
                color: Colors.grey[300],
                height: 10.0,
              ),
              SfCircularChart(
                  title: ChartTitle(
                      text: "Admission / Enrollement",
                      textStyle: const TextStyle(
                        color: Color(0xFFcf171f),
                        fontFamily: 'Roboto',
                        fontStyle: FontStyle.italic,
                        fontSize: 14,
                      )),
                  series: <CircularSeries>[
                    // Render pie chart
                    PieSeries<ChartData2, String>(
                        dataSource: chartData,
                        pointColorMapper: (ChartData2 data, _) => data.color,
                        xValueMapper: (ChartData2 data, _) => data.x,
                        yValueMapper: (ChartData2 data, _) => data.y)
                  ]),
              Container(
                color: Colors.grey[300],
                height: 30.0,
              ),
              Image.asset('assets/images/logoEsprit.png',
                  width: 300, height: 200, fit: BoxFit.contain),
              Container(
                color: Colors.pink, // Yellow
                height: 120.0,
              ),
              Text(_studentList.length.toString(),
                  style: TextStyle(fontSize: 28)),
              Text(_nbclasseList.toString(), style: TextStyle(fontSize: 28)),
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

class _ChartData {
  _ChartData(this.x, this.y);

  final String x;
  final double y;
}

class ChartData2 {
  ChartData2(this.x, this.y, this.color);
  final String x;
  final double y;
  final Color color;
}
