import 'dart:convert';

import 'package:esprit_kpi/models/branche.dart';
import 'package:esprit_kpi/models/classe.dart';
import 'package:esprit_kpi/ui/student_studentslist.dart';
import 'package:esprit_kpi/ui/teacher_studentlist.dart';
import 'package:esprit_kpi/ui/widgets/student_drawer.dart';
import 'package:esprit_kpi/ui/widgets/teacher_drawer.dart';
import 'package:flutter/material.dart';
import 'package:esprit_kpi/services/classe_api.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import "package:http/http.dart" as http;

import 'widgets/custon_button.dart';

class TeacherClassesList extends StatefulWidget {
  final int niveaux;
  const TeacherClassesList({Key? key, required this.niveaux}) : super(key: key);

  @override
  State<TeacherClassesList> createState() => _TeacherClassesListState();
}

class _TeacherClassesListState extends State<TeacherClassesList> {
  List<Classe> _classeList = [];
  List<Branche> _brancheList = [];
  late int nv;

  Future<List<Classe>> getClasses(int niveau) async {
    final classeList = await ClasseApi().getClassesByNiveau(niveau);
    setState(() {
      _classeList = classeList;
    });
    return classeList;
  }

  Future<List<Classe>> getClassesByBranche(int niveau, String branche) async {
    final classeList = await ClasseApi().getByBranche(niveau, branche);
    setState(() {
      _classeList = classeList;
    });
    return classeList;
  }

  Future<List<Branche>> getBranches(int niveau) async {
    final brancheList = await ClasseApi().getBranches(niveau);
    setState(() {
      _brancheList = brancheList;
    });
    print(brancheList.toString());
    return brancheList;
  }

  @override
  void initState() {
    getClasses(widget.niveaux);
    getBranches(widget.niveaux);
    nv = widget.niveaux;
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
          iconTheme: const IconThemeData(color: Color(0xFFcf171f), size: 50),
          centerTitle: true,
        ),
        drawer: const TeacherDrawer(),
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            children: [
              Container(
                height: 10.0,
              ),
              ElevatedButton(
                onPressed: () {
                  getClasses(nv);
                },
                style: ButtonStyle(
                  elevation: MaterialStateProperty.all(2),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50))),
                  backgroundColor: MaterialStateProperty.all(Colors.red),
                  fixedSize: MaterialStateProperty.all(const Size(300, 60)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Reset Filtre",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.w500),
                    )
                  ],
                ),
              ),
              Container(
                height: 10.0,
              ),
              Container(
                height: 50,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _brancheList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () =>
                          {getClassesByBranche(nv, _brancheList[index].id)},
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Container(
                          padding:
                              const EdgeInsets.only(left: 10.0, right: 10.0),
                          decoration: BoxDecoration(
                              color: Colors.grey[100],
                              border: Border.all(
                                color: Colors.grey,
                              ),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(15))),
                          height: 30,
                          child: Center(
                            child: Text(
                              _brancheList[index].id,
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
              ),
              Container(
                height: 10.0,
                color: Colors.grey[200],
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: _classeList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () => {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TeacherStudentsList(
                                  idclasse: _classeList[index].id),
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
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(20))),
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
              ),
            ],
          ),
        ));
  }
}
