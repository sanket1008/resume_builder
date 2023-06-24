import 'package:flutter/material.dart';
import 'package:resume_builder/resorses/colors.dart';
import 'package:resume_builder/view/resume_list_card.dart';

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
                Text("List of Resume",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
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
