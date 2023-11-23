
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:getxtodohive/model/TodoApp.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';


class TodoModelController extends GetxController {

var selectedImagePath=''.obs;
var selectedImageSize=''.obs;  


  void resetImageSelection() {
    selectedImagePath.value = '';
    selectedImageSize.value = '';
  }
 void getImage(ImageSource imageSource)async
{
  
  final pickedFile=await ImagePicker().pickImage(source:imageSource); 
  if(pickedFile!=null){
    selectedImagePath.value=pickedFile.path;
    selectedImageSize.value= ((File(selectedImagePath.value)).lengthSync()/1024/1024).toStringAsFixed(2)+"Mb";

  }else{
    Get.snackbar('error', 'no image',snackPosition: SnackPosition.BOTTOM,
backgroundColor: Colors.white,colorText: Colors.red
    );
  }
}


  late Box<TodoApp> todoBox;

  @override
  void onInit() {
    super.onInit();
    todoBox = Hive.box<TodoApp>('todoBox');
  }

  addNotes(String name, String text,Uint8List image,DateTime dateTime) {
    TodoApp todoApp = TodoApp(name: name, text: text,image: image,dateTime: dateTime);
    todoBox.add(todoApp);
  }

  deleteNotes(int index) async {
    await todoBox.deleteAt(index);
  }

  updateNotes(int index, String name, String text,Uint8List image,DateTime dateTime) {
    TodoApp todoApp = TodoApp(name: name, text: text,image:image,dateTime: dateTime);
    todoBox.putAt(index, todoApp);
  }
}
