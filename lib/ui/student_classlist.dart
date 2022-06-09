import 'dart:convert';

import 'package:esprit_kpi/models/classe.dart';
import 'package:esprit_kpi/ui/student_studentslist.dart';
import 'package:esprit_kpi/ui/widgets/student_drawer.dart';
import 'package:flutter/material.dart';
import 'package:esprit_kpi/services/classe_api.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import "package:http/http.dart" as http;

import 'widgets/custon_button.dart';

class ClassesList extends StatefulWidget { 
  final int niveaux;
  const ClassesList( {Key? key, required this.niveaux}) : super(key: key);

  @override
  State<ClassesList> createState() => _ClassesListState();
}

class _ClassesListState extends State<ClassesList> {

  List<Classe> _classeList=[];

  Future <List<Classe>> getClasses(int niveau) async {
    final classeList = await ClasseApi().getClassesByNiveau(niveau);
    setState(() {
      _classeList=classeList;
    });
     return classeList;
  }

 
  @override
  void initState() {
    getClasses(widget.niveaux);
    super.initState();
  }
  

  @override
  Widget build(BuildContext context) {

    print(_classeList);
    

    // final ImageProvider _imageProvider;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80.0,
        backgroundColor: Colors.white,
        title: Container(
          width: 150,
          child: Image.asset('assets/images/logoEsprit.png'),
        ),
        iconTheme: const IconThemeData(color: Color(0xFFcf171f),size: 50),
        centerTitle: true,
      ),
      drawer: const StudentDrawer(),
      backgroundColor: Colors.white,
      body: SafeArea(
          child: ListView.builder(
            itemCount: _classeList.length,
            itemBuilder: (BuildContext context, int index) { 
              return InkWell(
              onTap: () => {
                Navigator.push(context, MaterialPageRoute(
          builder: (context) => StudentsList( idclasse: _classeList[index].id),
        ))
              },
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.grey[300],
                      border: Border.all(
                        color: Colors.grey,
                      ),
                      borderRadius: const BorderRadius.all(Radius.circular(20))),
                  height: 80,
                  child: Center(
                    child: Text(
                      _classeList[index].name,
                      style: const TextStyle(
                        color: Color(0xFFcf171f),
                        fontSize: 30,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              ),
            );
             },
          ),
      )
    );
  }
}



