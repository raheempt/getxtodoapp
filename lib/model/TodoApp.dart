
import 'dart:typed_data';

import 'package:hive/hive.dart';

part 'TodoApp.g.dart';
@HiveType(typeId: 1)
class TodoApp{
@HiveField(0)
  String name;
@HiveField(1)
  String text;  
@HiveField(2)
Uint8List image;
@HiveField(3)
DateTime dateTime;

TodoApp({
  required this.name , required this.text , required this.image, required this.dateTime
});

}