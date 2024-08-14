import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:project/view/loginPage.dart";

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title:"Demo",
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}
