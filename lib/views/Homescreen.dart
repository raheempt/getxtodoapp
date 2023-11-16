import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:getxtodohive/model/TodoApp.dart';
import 'package:getxtodohive/views/addtodo.dart';
import 'package:getxtodohive/views/edit.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

class HomeScreen extends StatefulWidget {
  const   HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Box<TodoApp> todoBox;

  @override
  void initState() {
    super.initState();
    todoBox = Hive.box<TodoApp>('todoBox');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo'),
        backgroundColor: Color.fromARGB(255, 119, 246, 250),
      ),
      body: ValueListenableBuilder(
        valueListenable: todoBox.listenable(),
        builder: (context, Box<TodoApp> todoBox, child) {
          if (todoBox.isEmpty) {
            return Center(child: Text('No todos'));
          }

          return ListView.builder(
            itemCount: todoBox.length,
            itemBuilder: (ctx, index) {
              TodoApp newTodo = todoBox.getAt(index) as TodoApp;
              return Card(
                child: SizedBox(
                  width: 150,
                  child: ListTile(
                    
                    title: Text(newTodo.name),
                    subtitle: Text(newTodo.text),
                    leading: CircleAvatar(backgroundImage: MemoryImage(newTodo.image),),     
                    trailing: SizedBox(
                      height: 30,
                      width: 30,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [ IconButton(
                        onPressed: () {
                           Navigator.push(
                            context,
                             MaterialPageRoute(
                               builder: (context) => EditScreen(
                                index: index,
                                 name: newTodo.name,
                                 text: newTodo.text,
                                 image: newTodo.image,
                               ),
                             ),
                           );
                         },
                         icon: const Icon(Icons.edit, color: Colors.blue),),
                          // IconButton(
                          //   onPressed: () async {
                          //     todoBox.delete(index).then((value) =>
                          //         ScaffoldMessenger.of(context).showSnackBar(
                          //             SnackBar(content: Text('${newTodo.name} Deleted'))));
                          //   },
                          //   icon: const Icon(Icons.delete_rounded, color: Colors.red),
                          // ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(AddTodo());
        },
        backgroundColor: const Color.fromARGB(255, 247, 245, 245),
        child: Icon(
          Icons.add,
          color: Colors.red,
          size: 40,
        ),
      ),
    );
  }
}
