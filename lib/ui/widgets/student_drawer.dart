import 'dart:convert';

import 'package:esprit_kpi/home/etudiant/classes.dart';
import 'package:esprit_kpi/models/student.dart';
import 'package:esprit_kpi/util/constantes.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../student_studentslist.dart';


class StudentDrawer extends StatefulWidget {
  const StudentDrawer({Key? key}) : super(key: key);

  @override
  State<StudentDrawer> createState() => _StudentDrawerState();
}

class _StudentDrawerState extends State<StudentDrawer> {

  late Student student=Student(id: "", cin: "", firstName: "", lastName: "", email: "", photo: "profile.png", birthDate: "", phone: "", classeName: "", classeId: "");
  Future <void> getUser() async{
    final prefs = await SharedPreferences.getInstance();
    final studentStr=await prefs.getString("student");
    setState(() {
      student=Student.fromJson(json.decode(studentStr!));
    });
  }

  Future <void> logout() async{
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUser();
  }
  

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child:Row(
                  children:[
                    InkWell(
                      onTap: () => {
                        Navigator.pushNamed(context, "/StudentProfile")
                      },
                      child: CircleAvatar(
                        radius: 40,
                        backgroundImage: NetworkImage('$baseURL/uploads/'+ student.photo),
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    InkWell(
                      onTap: () => {
                        Navigator.pushNamed(context, "/StudentProfile")
                      },
                      child:  Text(
                        student.firstName + " " +student.lastName,
                        style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      )),
                    ),
                  ]
            )
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () => {
              Navigator.pushReplacementNamed(context, "/StudentHome")
            },
          ),
          ListTile(
            leading: const Icon(Icons.people),
            title: const Text('Classmates'),
            onTap: () => {
              Navigator.push(context, MaterialPageRoute(
          builder: (context) => StudentsList( idclasse: student.classeId!),
        ))
            },
          ),
          ListTile(
            leading: const Icon(Icons.book),
            title: const Text('All Classes'),
            onTap: () => {
              Navigator.pushReplacementNamed(context, "/ClassesNiveaux")
            },
          ),
          ListTile(
            leading: const Icon(Icons.book),
            title: const Text('Grades'),
            onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => classes(
                        classe: Map<String, dynamic>(),
                      )));
        },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.exit_to_app),
            title: const Text('Logout'),
            onTap: () => {
              logout(),
              Navigator.pushReplacementNamed(context, "/Welcom")
            },
          ),
        ],
      ),
    );
  }

  
}