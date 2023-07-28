import 'package:flutter/material.dart';

import '../repository/sql_helper.dart';

class ResumeDetailsViewModel with ChangeNotifier{

  final firstName=TextEditingController();
  final resumeTitle=TextEditingController();
  final lastName=TextEditingController();
  final DOB=TextEditingController();
  final aboutYou=TextEditingController();
  final address=TextEditingController();
  final educationalDetails=TextEditingController();
  final hobbies=TextEditingController();
  final skills=TextEditingController();

  Future<void> addItems() async{

    print("in add resume");
    await SqlHelper.createIem(resumeTitle.text,firstName.text,lastName.text,DOB.text,aboutYou.text,address.text,educationalDetails.text, skills.text,hobbies.text);


    final data = await SqlHelper.getItems();

    print(data);


  }

  Future<void> updateItem(int? id) async{

    print("in add resume");
    await SqlHelper.updateItem(id??0,resumeTitle.text,firstName.text,lastName.text,DOB.text,aboutYou.text,address.text,educationalDetails.text, skills.text,hobbies.text);
    final data = await SqlHelper.getItems();
    print(data);




  }

  Future<void> delete(int? id) async{


    await SqlHelper.deleteItem(id??0);
    final data = await SqlHelper.getItems();

    print(data);


  }

}