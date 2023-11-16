
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getxtodohive/condroller/condroller.dart';
import 'package:getxtodohive/model/TodoApp.dart';
import 'package:hive/hive.dart';


class EditScreen extends StatefulWidget {

   String name;
   String text;
   Uint8List image;
   int index;
    EditScreen({required this.index,required this.name, required this.text,required this.image, super.key});


  @override
  State<EditScreen> createState() => _EditScreenState();  
}

class _EditScreenState extends State<EditScreen> {
   final nameControllar = TextEditingController();
  final textControllar = TextEditingController();   
  final controller = Get.put(TodoModelController());
   
  Box todoBox = Hive.box<TodoApp>('todoBox');
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
   appBar: AppBar(title: Text('update'),backgroundColor: Color.fromARGB(255, 26, 149, 231),),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
controller: nameControllar..text=widget.name,
   decoration: InputDecoration(
                  labelText: 'title',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32),
                  ),
                ),



            ),
            SizedBox(height: 10,),
            TextFormField(
              controller: textControllar..text=widget.text,
                 decoration: InputDecoration(
                  labelText: 'content',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32),
                  ),
                ),
            ),
            ElevatedButton(onPressed: (){  
controller.updateNotes(widget.index, widget.name, widget.text,widget.image);
              Navigator.pop(context);
            }, child: Text('Save '))
          ],
        ),
      ),
  );
  }
}