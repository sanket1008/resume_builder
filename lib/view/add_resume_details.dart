import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resume_builder/repository/sql_helper.dart';
import 'package:resume_builder/resorses/components/common_button.dart';
import 'package:resume_builder/view_model/resume_details_view_model.dart';

import '../resorses/components/common_input_box.dart';

class AddResumeDetails extends StatefulWidget {
  const AddResumeDetails({Key? key, required this.edit, this.id})
      : super(key: key);
  final bool edit;
  final int? id;


  @override
  State<AddResumeDetails> createState() => _AddResumeDetailsState();
}

class _AddResumeDetailsState extends State<AddResumeDetails> {
  final _form = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final resumeDetailsModel = Provider.of<ResumeDetailsViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: widget.edit==true?Text("Edit Resume Details"):Text("Add Resume Details"),
        automaticallyImplyLeading: true,
      ),
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Form(
            key: _form,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonInputBox(
                  isBorderEnabled: true,
                  maxLines: 1,
                  label: "Resume title",
                  controller: resumeDetailsModel.resumeTitle,
                  validator: (value) {
                    if (value.toString().isEmpty) {
                      return "Enter title";
                    } else {
                      return null;
                    }
                  },
                ),
                CommonInputBox(
                  isBorderEnabled: true,
                  maxLines: 1,
                  label: "First Name",
                  controller: resumeDetailsModel.firstName,
                  validator: (value) {
                    if (value.toString().isEmpty) {
                      return "Enter name";
                    } else {
                      return null;
                    }
                  },
                ),
                CommonInputBox(
                  isBorderEnabled: true,
                  maxLines: 1,
                  label: "Last Name",
                  controller: resumeDetailsModel.lastName,
                  validator: (value) {
                    if (value.toString().isEmpty) {
                      return "Enter Last name";
                    } else {
                      return null;
                    }
                  },
                ),
                CommonInputBox(
                  isBorderEnabled: true,
                  maxLines: 1,
                  label: "Date of Birth",
                  controller: resumeDetailsModel.DOB,
                  validator: (value) {
                    if (value.toString().isEmpty) {
                      return "Enter Date of birth";
                    } else {
                      return null;
                    }
                  },
                ),
                CommonInputBox(
                  isBorderEnabled: true,
                  maxLines: 4,
                  label: "About you",
                  controller: resumeDetailsModel.aboutYou,
                  validator: (value) {
                    if (value.toString().isEmpty) {
                      return "Enter About you";
                    } else {
                      return null;
                    }
                  },
                ),
                CommonInputBox(
                  isBorderEnabled: true,
                  maxLines: 2,
                  label: "Address",
                  controller: resumeDetailsModel.address,
                  validator: (value) {
                    if (value.toString().isEmpty) {
                      return "Enter address";
                    } else {
                      return null;
                    }
                  },
                ),
                CommonInputBox(
                  isBorderEnabled: true,
                  maxLines: 2,
                  label: "Education Details",
                  controller: resumeDetailsModel.educationalDetails,
                  validator: (value) {
                    if (value.toString().isEmpty) {
                      return "Enter Education Details";
                    } else {
                      return null;
                    }
                  },
                ),
                CommonInputBox(
                  isBorderEnabled: true,
                  maxLines: 2,
                  label: "Skills",
                  controller: resumeDetailsModel.skills,
                  validator: (value) {
                    if (value.toString().isEmpty) {
                      return "Enter Hobbies";
                    } else {
                      return null;
                    }
                  },
                ),
                CommonInputBox(
                  isBorderEnabled: true,
                  maxLines: 4,
                  label: "Hobbies",
                  controller: resumeDetailsModel.hobbies,
                  validator: (value) {
                    if (value.toString().isEmpty) {
                      return "Enter Hobbies";
                    } else {
                      return null;
                    }
                  },
                ),
                CommonButton(
                    text: "Submit",
                    width: MediaQuery.of(context).size.height,
                    onPress: () async {
                      if (_form.currentState!.validate()) {


                        if (widget.edit==true) {
                          resumeDetailsModel.updateItem(widget.id??0).then((value) {
                            Navigator.pop(context);
                          });
                        } else {
                          resumeDetailsModel.addItems().then((value) {
                            Navigator.pop(context);

                            // resumeDetailsModel.firstName.clear();
                            // resumeDetailsModel.lastName.clear();
                            // resumeDetailsModel.address.clear();
                            // resumeDetailsModel.skills.clear();
                            // resumeDetailsModel.educationalDetails.clear();
                            // resumeDetailsModel.DOB.clear();
                            // resumeDetailsModel.hobbies.clear();

                          });
                        }
                      }
                    })
              ],
            ),
          ),
        ),
      )),
    );
  }
}
