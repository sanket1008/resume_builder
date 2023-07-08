import 'package:flutter/material.dart';
import 'package:resume_builder/resorses/colors.dart';
import 'package:resume_builder/resorses/components/common_button.dart';
import 'package:resume_builder/view/resume_list_card.dart';

import '../util/routes/routes_name.dart';
import 'add_resume_details.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                    const Text("List of Resume",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                    CommonButton(text: "Add Resume", onPress: (){
                     Navigator.push(context, MaterialPageRoute(builder: (context)=>const AddResumeDetails()));
                    })
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                ListView.builder(
                    itemCount: 6,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return ResumeListCard();
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
