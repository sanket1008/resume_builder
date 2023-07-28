import 'dart:io';
import 'dart:typed_data';

import 'package:android_path_provider/android_path_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:printing/printing.dart';
import 'package:provider/provider.dart';
import 'package:resume_builder/repository/sql_helper.dart';
import 'package:resume_builder/resorses/colors.dart';
import 'package:resume_builder/resorses/components/common_button.dart';
import 'package:share_plus/share_plus.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import '../util/assets.dart';
import '../view_model/resume_details_view_model.dart';
import 'add_resume_details.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Map<String, dynamic>> resumeList = [];
  bool _isLoading = true;

  void _refreshResume() async {
    final data = await SqlHelper.getItems();

    setState(() {
      resumeList = data;
      _isLoading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    _refreshResume();
    print("number of itme ${resumeList.length}");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _refreshResume();
    final resumeDetailsModel =
        Provider.of<ResumeDetailsViewModel>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        centerTitle: false,
        backgroundColor: AppColors.appBarColor,
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "List of Resume",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    CommonButton(
                        text: "Add Resume",
                        onPress: () {
                          resumeDetailsModel.resumeTitle.clear();
                          resumeDetailsModel.firstName.clear();
                          resumeDetailsModel.lastName.clear();
                          resumeDetailsModel.address.clear();
                          resumeDetailsModel.skills.clear();
                          resumeDetailsModel.aboutYou.clear();
                          resumeDetailsModel.educationalDetails.clear();
                          resumeDetailsModel.DOB.clear();
                          resumeDetailsModel.hobbies.clear();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AddResumeDetails(
                                        edit: false,
                                      )));
                        })
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                ListView.builder(
                    itemCount: resumeList.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () async {
                          _showForm(resumeList[index]["id"], context);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AddResumeDetails(
                                        edit: true,
                                        id: resumeList[index]["id"] ?? 0,
                                      )));
                        },
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: Column(
                                        children: [
                                          ClipRRect(
                                            borderRadius: BorderRadius.circular(10),
                                            child: Image.asset(
                                              Assets.RESUME,
                                              height: 80,
                                              width: 80,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      flex: 7,
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "${resumeList[index]["resumeTitle"]}",
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15),
                                            ), Text(
                                              "${resumeList[index]["firstname"]} ${resumeList[index]["lastname"]}",
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            Text("${resumeList[index]["about"]}",
                                                overflow: TextOverflow.ellipsis),
                                            Text("${resumeList[index]["skills"]}",
                                                overflow: TextOverflow.ellipsis),

                                          ],
                                        ),
                                      ),
                                    ),

                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    IconButton(
                                      icon:
                                      Icon(Icons.delete, color: Colors.red),
                                      onPressed: () {
                                        resumeDetailsModel
                                            .delete(resumeList[index]["id"]);
                                      },
                                    ),
                                    IconButton(
                                      icon: Icon(
                                        Icons.share,
                                        color: Colors.blueAccent,
                                      ),
                                      onPressed: () async {
                                        await Share.share(
                                            "Name: ${resumeList[index]["firstname"]}${resumeList[index]["lastname"]}\nDate of birth: ${resumeList[index]["dob"]}\nAbout you: ${resumeList[index]["about"]}\n Address: ${resumeList[index]["address"]}\nEducation details: ${resumeList[index]["education"]}\nSkills: ${resumeList[index]["skills"]}\n Hobbies: ${resumeList[index]["hobbies"]}",
                                            subject: "share");
                                      },
                                    ),
                                    IconButton(
                                      icon: Icon(
                                        Icons.download,
                                        color: Colors.blueAccent,
                                      ),
                                      onPressed: () async {
                                        // _generatePdf(PdfPageFormat.a4,"first");
                                        // final font = await PdfGoogleFonts
                                        //     .nunitoExtraLight();
                                        // final pdf = pw.Document();
                                        //
                                        // pdf.addPage(pw.Page(
                                        //     pageFormat: PdfPageFormat.a4,
                                        //     build: (pw.Context context) {
                                        //       return pw.Center(
                                        //         child: pw.Text("Hello World",
                                        //             style: pw.TextStyle(
                                        //                 font: font)),
                                        //       ); // Center
                                        //     }));
                                        // saveDocument(
                                        //     name: 'my_example.pdf', pdf: pdf);
                                        Fluttertoast.showToast(
                                            msg: "Downloading...",
                                            gravity: ToastGravity.CENTER,
                                            timeInSecForIosWeb: 1,
                                            backgroundColor: Colors.black,
                                            textColor: Colors.white,
                                            fontSize: 14.0);
                                        await FileStorage.writeCounter(
                                            "Name: ${resumeList[index]["firstname"]}${resumeList[index]["lastname"]}\nDate of birth: ${resumeList[index]["dob"]}\nAbout you: ${resumeList[index]["about"]}\n Address: ${resumeList[index]["address"]}\nEducation details: ${resumeList[index]["education"]}\nSkills: ${resumeList[index]["skills"]}\n Hobbies: ${resumeList[index]["hobbies"]}",
                                            "${resumeList[index]["resumeTitle"]}.txt");
                                        Fluttertoast.showToast(
                                            msg: "Download has been completed, Please check in download file",
                                            gravity: ToastGravity.CENTER,
                                            timeInSecForIosWeb: 1,
                                            backgroundColor: Colors.black,
                                            textColor: Colors.white,
                                            fontSize: 14.0);
                                        // FileStorage.saveDocument(name: "${resumeList[index]["firstname"]}.pdf", pdf: pdf);
                                      },
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showForm(int? id, BuildContext context) {
    final resumeDetailsModel =
        Provider.of<ResumeDetailsViewModel>(context, listen: false);
    if (id != null) {
      final existingjournal =
          resumeList.firstWhere((element) => element["id"] == id);
      resumeDetailsModel.firstName.text = existingjournal['firstname'];
      resumeDetailsModel.lastName.text = existingjournal['lastname'];
      resumeDetailsModel.DOB.text = existingjournal['dob'];
      resumeDetailsModel.aboutYou.text = existingjournal['about'];
      resumeDetailsModel.educationalDetails.text = existingjournal['education'];
      resumeDetailsModel.address.text = existingjournal['address'];
      resumeDetailsModel.skills.text = existingjournal['skills'];
      resumeDetailsModel.hobbies.text = existingjournal['hobbies'];
    }
  }

  Future<File> saveDocument({
    required String name,
    required pw.Document pdf,
  }) async {
    // pdf save to the variable called bytes
    final bytes = await pdf.save();
   // final path = await _localPath;
    // here a beautiful pakage  path provider helps us and take dircotory and name of the file  and made a proper file in internal storage
    final dir = (await getApplicationDocumentsDirectory());
    final file = File('${dir.path}/$name');
    print("${file.path}");

    await file.writeAsBytes(bytes);

    // reterning the file to the top most method which is generate centered text.
    return file;
  }

Future<Uint8List> _generatePdf(PdfPageFormat format, String title) async {
  final pdf = pw.Document(version: PdfVersion.pdf_1_5, compress: true);
  final font = await PdfGoogleFonts.nunitoExtraLight();

  pdf.addPage(
    pw.Page(
      pageFormat: format,
      build: (context) {
        return pw.Column(
          children: [
            pw.SizedBox(
              width: double.infinity,
              child: pw.FittedBox(
                child: pw.Text(title, style: pw.TextStyle(font: font)),
              ),
            ),
            pw.SizedBox(height: 20),
            pw.Flexible(child: pw.FlutterLogo())
          ],
        );
      },
    ),
  );

  return pdf.save();
}
}

class FileStorage {
  static Future<String> getExternalDocumentPath() async {
    // To check whether permission is given for this app or not.
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      // If not we will ask for permission first
      await Permission.storage.request();
    }
    Directory _directory = Directory("");
    if (Platform.isAndroid) {
      // Redirects it to download folder in android
      _directory = Directory("/storage/emulated/0/Download");
    } else {
      _directory = await getApplicationDocumentsDirectory();
    }

    final exPath = _directory.path;
    print("Saved Path: $exPath");
    await Directory(exPath).create(recursive: true);
    return exPath;
  }

  static Future<String> get _localPath async {
    // final directory = await getApplicationDocumentsDirectory();
    // return directory.path;
    // To get the external path from device of download folder
    final String directory = await getExternalDocumentPath();
    return directory;
  }

  static Future<File> writeCounter(String bytes, String name) async {
    final path = await _localPath;
    // Create a file for the path of
    // device and file name with extension
    File file = File('$path/$name');

    print("Save file");

    // Write the data in the file you have created
    return file.writeAsString(bytes);
  }

  static Future<File> saveDocument({
    required String name,
    required pw.Document pdf,
  }) async {
    // pdf save to the variable called bytes
    final bytes = await pdf.save();
    final path = await _localPath;
    // here a beautiful pakage  path provider helps us and take dircotory and name of the file  and made a proper file in internal storage
    //final dir = (await getApplicationDocumentsDirectory());
    final file = File('${path}/$name');

    await file.writeAsBytes(bytes);

    // reterning the file to the top most method which is generate centered text.
    return file.writeAsBytes(bytes);
  }
}
