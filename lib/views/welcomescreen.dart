import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getxtodohive/views/Homescreen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(onPressed: (){
              Get.to(HomeScreen());
            }, child: Text('next page')),
            SizedBox(height: 10,),
            
            ElevatedButton(onPressed: (){
              Get.bottomSheet(Container(
              child: Wrap(
                children: [
                    ListTile(
                        leading: Icon(Icons.wb_sunny_outlined),
                         title: Text('light'),
                         onTap: ()=>{Get.changeTheme(ThemeData.light())},
                       ),
             ListTile(
                         leading: Icon(Icons.wb_sunny),  
                         title: Text('dark'),
                         onTap: ()=>{Get.changeTheme(ThemeData.dark())},
                       ),
                ],
              ),
              ));
            }, child: Text('Theme'),)

           
          ],
  
        ) ,
      ),
      // bottomNavigationBar: BottomNavigationBar(items: [bottomnavigationbar()]),
    );
  }
}

// bottomnavigationbar() {
//   return BottomNavigationBarItem(
//     icon: Icon(CupertinoIcons.home),
//     label: 'home',
//     );
// }