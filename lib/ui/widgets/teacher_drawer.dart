import 'dart:convert';

import 'package:esprit_kpi/home/classes.dart';
import 'package:esprit_kpi/models/student.dart';
import 'package:esprit_kpi/util/constantes.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../student_studentslist.dart';

class TeacherDrawer extends StatefulWidget {
  const TeacherDrawer({Key? key}) : super(key: key);

  @override
  State<TeacherDrawer> createState() => _TeacherDrawerState();
}

class _TeacherDrawerState extends State<TeacherDrawer> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
              child: Row(children: [
            InkWell(
              onTap: () => {Navigator.pushNamed(context, "/StudentProfile")},
              child: CircleAvatar(
                radius: 40,
              ),
            ),
            const SizedBox(
              width: 15,
            ),
            InkWell(
              onTap: () => {Navigator.pushNamed(context, "/StudentProfile")},
              child: Text("Full Name",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  )),
            ),
          ])),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () =>
                {Navigator.pushReplacementNamed(context, "/TeacherHome")},
          ),
          ListTile(
            leading: const Icon(Icons.book),
            title: const Text('All Classes'),
            onTap: () => {
              Navigator.pushReplacementNamed(context, "/TeacherClassesNiveaux")
            },
          ),
          ListTile(
            leading: const Icon(Icons.query_stats_sharp),
            title: const Text('Grades'),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => classes()));
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.exit_to_app),
            title: const Text('Logout'),
            onTap: () => {Navigator.pushReplacementNamed(context, "/Welcom")},
          ),
        ],
      ),
    );
  }
}
