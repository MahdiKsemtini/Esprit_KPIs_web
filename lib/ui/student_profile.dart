import 'dart:convert';

import 'package:esprit_kpi/models/student.dart';
import 'package:esprit_kpi/services/student_api.dart';
import 'package:esprit_kpi/ui/widgets/student_drawer.dart';
import 'package:esprit_kpi/util/constantes.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import "package:http/http.dart" as http;
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'widgets/custon_button.dart';

class StudentProfile extends StatefulWidget {
  const StudentProfile({Key? key}) : super(key: key);

  @override
  State<StudentProfile> createState() => _StudentProfileState();
}

class _StudentProfileState extends State<StudentProfile> {
  late Student student = Student(
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
  Future<void> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    final studentStr = await prefs.getString("student");
    setState(() {
      student = Student.fromJson(json.decode(studentStr!));
    });
  }



  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }


  XFile? imageFile;

  void saveImagePath(String? idImagePath) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("idImagePath", idImagePath!);
  }

  void _openCamera(BuildContext context) async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.camera,
    );

    var pickedImagePath = pickedFile?.path;
    if (pickedImagePath != null && _isImage(pickedImagePath)) {
      setState(() {
        imageFile = pickedFile;
      });
      saveImagePath(pickedFile?.path);
      await StudentApi().updateProfilePic(student.id, imageFile!.path);
      var stud = await StudentApi().getStudentsById(student.id);
      var prefs = await SharedPreferences.getInstance();
      await prefs.setString("student", json.encode(stud.toJson()));
      setState(() {
      student = Student.fromJson(json.decode( prefs.getString("student")!));
    });
    } else {
      // User canceled the picker
    }
    Navigator.pop(context);
  }

  void _openFiles(BuildContext context) async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(type: FileType.any);

    var pickedImagePath = result?.files.single.path;
    if (pickedImagePath != null && _isImage(pickedImagePath)) {
      final pickedFile = XFile(pickedImagePath);
      setState(() {
        imageFile = pickedFile;
      });
      saveImagePath(pickedFile.path);
      await StudentApi().updateProfilePic(student.id, imageFile!.path);
      var stud = await StudentApi().getStudentsById(student.id);
      var prefs = await SharedPreferences.getInstance();
      await prefs.setString("student", json.encode(stud.toJson()));
      setState(() {
      student = Student.fromJson(json.decode( prefs.getString("student")!));
    });
    } else {
      // User canceled the picker
    }

    Navigator.pop(context);
  }

  bool _isImage(String path) {
    final mimeType = lookupMimeType(path);
    return mimeType?.startsWith('image/') ?? false;
  }

  void _openGallery(BuildContext context) async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    var pickedImagePath = pickedFile?.path;
    if (pickedImagePath != null && _isImage(pickedImagePath)) {
      setState(() {
        imageFile = pickedFile;
      });
      saveImagePath(pickedFile?.path);
      await StudentApi().updateProfilePic(student.id, imageFile!.path);
      var stud = await StudentApi().getStudentsById(student.id);
      var prefs = await SharedPreferences.getInstance();
      await prefs.setString("student", json.encode(stud.toJson()));
      setState(() {
      student = Student.fromJson(json.decode( prefs.getString("student")!));
    });
    } else {
      // User canceled the picker
    }

    Navigator.pop(context);
  }

  Future<void> _showChoiceDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              "choose from",
              style: TextStyle(color: Theme.of(context).primaryColor),
              textAlign: TextAlign.center,
            ),
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  ListTile(
                    onTap: () {
                      _openGallery(context);
                    },
                    title: Text(
                      "gallery",
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    leading: const Icon(
                      Icons.photo_library,
                      color: Colors.black,
                    ),
                  ),
                  const Divider(
                    height: 1,
                    color: Colors.black,
                  ),
                  ListTile(
                    onTap: () {
                      _openFiles(context);
                    },
                    title: Text(
                      "files",
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    leading: const Icon(
                      Icons.file_copy,
                      color: Colors.black,
                    ),
                  ),
                  const Divider(
                    height: 1,
                    color: Colors.black,
                  ),
                  ListTile(
                    onTap: () {
                      _openCamera(context);
                    },
                    title: Text(
                      "camera",
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    leading: const Icon(
                      Icons.camera_alt,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }




  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUser();
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
        drawer: StudentDrawer(),
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
                                    Center(
                                      child: Text(
                                        "Profile",
                                        style: const TextStyle(
                                          fontSize: 24,
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () => _showChoiceDialog(context),
                                      child: Container(
                                        width: 50,
                                        height: 50,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          color: Colors.white,
                                        ),
                                        child: const Icon(
                                          Icons.photo,
                                          color: Colors.red,
                                        ),
                                      ),
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
                                                  student.photo),
                                          fit: BoxFit.cover)),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Center(
                                child: Text(
                                  student.firstName + " " + student.lastName,
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
                                child: Text(student.email,
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
                              student.firstName +
                              " " +
                              student.lastName,
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
                                          text: student.email))
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
                          "     " + student.email,
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
                          "     " + student.phone,
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
                              student.birthDate.characters.take(10).toString(),
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
                          "     " + student.classeName!,
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
