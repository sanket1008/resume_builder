import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resume_builder/resorses/components/common_button.dart';
import 'package:resume_builder/view_model/resume_details_view_model.dart';

import '../resorses/components/common_input_box.dart';

class AddResumeDetails extends StatelessWidget {
  const AddResumeDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final resumeDetailsModel = Provider.of<ResumeDetailsViewModel>(context);
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Add Resume Details",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
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
                  onPress: () {})
            ],
          ),
        ),
      )),
    );
  }
}
