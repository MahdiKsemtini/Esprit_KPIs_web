import 'package:esprit_kpi/ui/splash_screen.dart';
import 'package:esprit_kpi/ui/student_classlist.dart';
import 'package:esprit_kpi/ui/student_home.dart';
import 'package:esprit_kpi/ui/student_login.dart';
import 'package:esprit_kpi/ui/student_niveaux.dart';
import 'package:esprit_kpi/ui/student_profile.dart';
import 'package:esprit_kpi/ui/teacher_home.dart';
import 'package:esprit_kpi/ui/teacher_login.dart';
import 'package:esprit_kpi/ui/teacher_niveaux.dart';
import 'package:esprit_kpi/ui/welcom.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Esprit KPI',
      routes: {
        "/StudentProfile": (BuildContext context) {
          return const StudentProfile();
        },
        "/ClassesNiveaux": (BuildContext context) {
          return const ClassesNiveaux();
        },
        "/TeacherClassesNiveaux": (BuildContext context) {
          return const TeacherClassesNiveaux();
        },
        "/StudentHome": (BuildContext context) {
          return const StudentHome();
        },
        "/StudentLogin": (BuildContext context) {
          return const StudentLogin();
        },
        "/TeacherLogin": (BuildContext context) {
          return const TeacherLogin();
        },
        "/Welcom": (BuildContext context) {
          return const Welcom();
        },
        "/TeacherHome": (BuildContext context) {
          return const TeacherHome();
        },
        "/": (BuildContext context) {
          return const SplashScreen();
        }
      },
    );
  }

}