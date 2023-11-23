
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getxtodohive/condroller/condroller.dart';
import 'package:getxtodohive/model/TodoApp.dart';
import 'package:hive/hive.dart';

class EditScreen extends StatefulWidget {
  final String name;
  final String text;
  final int index;
  final Uint8List image;

  EditScreen({
    required this.index,
    required this.name,
    required this.text,
    required this.image,
  });

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  final nameController = TextEditingController();
  final textController = TextEditingController();
  final controller = Get.put(TodoModelController());
  late Box<TodoApp> todoBox;

  @override
  void initState() {
    super.initState();
    todoBox = Hive.box<TodoApp>('todoBox');
    nameController.text = widget.name;
    textController.text = widget.text;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update'),
        backgroundColor: Color.fromARGB(255, 132, 26, 231),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: 'Name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(32),
                ),
              ),
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: textController,
              decoration: InputDecoration(
                labelText: 'Text',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(32),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                final name = nameController.text;
                final text = textController.text;
                final image = widget.image;

                TodoApp edit = TodoApp(
                  name: name.toUpperCase(),
                  text: text,
                  image: image,
                  dateTime: DateTime.now(), 
                );

                todoBox.putAt(widget.index, edit);

                Navigator.pop(context);
              },
              child: Text('Save'),
            )
          ],
        ),
      ),
    );
  }
}
