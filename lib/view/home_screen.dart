import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resume_builder/repository/sql_helper.dart';
import 'package:resume_builder/resorses/colors.dart';
import 'package:resume_builder/resorses/components/common_button.dart';

import '../resorses/components/common_image_view.dart';
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
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Column(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: const CommonImageView(
                                          //image: Assets.DEFAULT_IMAGE,
                                          height: 80,
                                          width: 80,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  flex: 7,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        resumeList[index]["firstname"],
                                      ),
                                    ],
                                  ),
                                ),
                                IconButton(
                                  icon: Icon(Icons.delete),
                                  onPressed: () {
                                    resumeDetailsModel
                                        .delete(resumeList[index]["id"]);
                                  },
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
}
