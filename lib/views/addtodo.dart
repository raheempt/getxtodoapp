
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getxtodohive/condroller/condroller.dart';
import 'package:getxtodohive/model/TodoApp.dart';
import 'package:getxtodohive/views/Homescreen.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';

class AddTodo extends StatefulWidget {
  const AddTodo({super.key});

  @override
  State<AddTodo> createState() => _AddTodoState();
}

class _AddTodoState extends State<AddTodo> {

  final nameControllar = TextEditingController();
  final texcontroller = TextEditingController();
  late TodoModelController controller;
     late Box<TodoApp> todoBox;
  late RxString selectedImagePath;
  late RxString selectedImageSize;
  
  @override
  void initState() {
    todoBox = Hive.box<TodoApp>('todoBox');
    controller = Get.put(TodoModelController());
       controller.  resetImageSelection();
       selectedImagePath = controller.selectedImagePath;
    selectedImageSize = controller.selectedImageSize;
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose(); 
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
 selectedImagePath.value.isEmpty
                  ? IconButton(
                      onPressed: () {
                        showimagePickeroption(context);
                      },
                      icon: Icon(Icons.add_a_photo, size: 60),
                    )
                  : Image.file(File(selectedImagePath.value)),
              selectedImageSize.value.isNotEmpty
                  ? Text(
                      selectedImageSize.value,
                      style: TextStyle(fontSize: 10),
                    )
                  : SizedBox(),
     SizedBox(
      height: 30,
     ),
            TextFormField(
              controller: nameControllar,
               decoration: InputDecoration(
                    labelText: 'name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(32),
                    ),
                  ),
            ),
                        SizedBox(height: 10,),
        
            Column(
              children: [
                TextFormField(
                  controller: texcontroller,
                   decoration: InputDecoration(
                        labelText: 'text',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(32),
                        ),
                      ),
                ),
              ],
            ),

            ElevatedButton(onPressed: ()async{
               final name=nameControllar.text;
               final text=texcontroller.text;
               String filePath=controller.selectedImagePath.value;
               Uint8List imagebytes=await File(filePath).readAsBytes();
               controller.addNotes(name, text,imagebytes, DateTime.now());


                Get.to(HomeScreen());
                
            }, child: const Text('Save'))
          ],
              ),
        ),),
    );
  }
  void showimagePickeroption(BuildContext context){
 showModalBottomSheet(
  context: context,
   builder: (builder){
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height /4,
        child: Row(children: [
          Expanded(
            child: InkWell(  
              onTap: (){
               controller.getImage(ImageSource.gallery);
              },
              child: SizedBox(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.image),
                    Text('Gallery')
                  ],
                ),
              ),
            ),
          ),
             Expanded(
               child: InkWell(  
                       onTap: (){
                       controller.getImage(ImageSource.camera);
                       },
                       child: SizedBox(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.camera),
                    Text('Camera')
                  ],
                ),
                       ),
                     ),
             )
        ],),
      ),
    );
   }
   );
 
}
}

  