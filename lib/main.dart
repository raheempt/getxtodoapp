import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:getxtodohive/model/TodoApp.dart';
import 'package:getxtodohive/views/welcomescreen.dart';
import 'package:hive/hive.dart';             
import 'package:path_provider/path_provider.dart';

void main()async{ 
  WidgetsFlutterBinding.ensureInitialized();
  Directory directory = await getApplicationCacheDirectory();
  Hive.init(directory.path);
  Hive.registerAdapter<TodoApp>(TodoAppAdapter());    
  await Hive.openBox<TodoApp>('todoBox');
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    home: WelcomeScreen(),
  ));

  }
