
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getxtodohive/condroller/condroller.dart';
import 'package:getxtodohive/model/TodoApp.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';

class AddTodo extends StatefulWidget {
  const AddTodo({super.key});

  @override
  State<AddTodo> createState() => _AddTodoState();
}

class _AddTodoState extends State<AddTodo> {

  TimeOfDay selectedtime =TimeOfDay.now();
  final nameControllar = TextEditingController();
  final texcontroller = TextEditingController();
   late Box<TodoApp> todoBox;
  late TodoModelController controller;
  
  @override
  void initState() {
    todoBox = Hive.box<TodoApp>('todoBox');
    controller = Get.put(TodoModelController());
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
      Obx(() => controller.selectedImagePath.value==''?
      Text('select image form cemera/gallery ',style:TextStyle(fontSize: 20),)  
       :Image.file(File(controller.selectedImagePath.value))
      ),
     SizedBox(
      height: 10,
     ),
     Obx(() => Text(controller.selectedImageSize.value==''?'':
     controller.selectedImageSize.value, style: TextStyle(fontSize: 20),),
     ),
           Center(
            child: TextButton(onPressed: () {
              
              controller.getImage(ImageSource.camera);

            }, child:Text("camera") ),
           ),
            Center(
            child: TextButton(onPressed: () {
              controller.getImage(ImageSource.gallery);

            }, child:Text("gallery") ),
           ),
            CircleAvatar(
              maxRadius: 100,
          backgroundColor: Colors.brown.shade800,radius: 50,
          
          // child: const Icon(Icons.person,size: 30,),
          
        )
        
          ,
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
        
            TextFormField(
              controller: texcontroller,
               decoration: InputDecoration(
                
                    labelText: 'text',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(32),
                    ),
                  ),
            ),
                
                        SizedBox(height: 10,),
                        Text("${selectedtime.hour}:${selectedtime.minute}"),
            ElevatedButton(onPressed: ()async{
              final TimeOfDay? timeOfDay = await showTimePicker(
                context: context,
                 initialTime: selectedtime,
                 initialEntryMode: TimePickerEntryMode.dial,
                  ); 
               final name=nameControllar.text;
               final text=texcontroller.text;
               String filePath=controller.selectedImagePath.value;
               Uint8List imagebytes=await File(filePath).readAsBytes();
               controller.addNotes(name, text,imagebytes,);
              
                Navigator.pop(context);
        
            }, child: const Text('Save'))
          ],
              ),
        ),),
    );
  }
}