import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

import 'loginPage.dart';

class MainView extends StatelessWidget {
  RxInt value = 0.obs;
  RxBool isLoading=false.obs;

  void Increase() {
    value.value++;
  }

  Future<void> storeValueInFirestore() async {
     isLoading.value=true;
    const String apiKey = 'AIzaSyBuppluSi99rQ5xxgeoMZOt9T_8I7k7cj8'; // Your API Key
    const String projectId = 'valuestore-73dc6'; // Your Project ID
    const String collection = 'values'; // Collection name

    // Construct the URL for the REST API
    final String url =
        'https://firestore.googleapis.com/v1/projects/$projectId/databases/(default)/documents/$collection?key=$apiKey';

    final Map<String, dynamic> data = {
      'fields': {
        'value': {
          'integerValue': value.value,
        }
      },
    };

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(data),
      );

      if (response.statusCode == 200) {
        isLoading.value=false;
        Get.defaultDialog(
          barrierDismissible: false,
          title: "Stored",
          titleStyle: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w400,
          ),
          content: Text(
            "Your value has been stored in Firebase",
            style: TextStyle(fontSize: 18),
          ),
          contentPadding: EdgeInsets.all(10),
          confirm: TextButton(
            onPressed: () {
              value.value = 0;
              Get.back();
            },
            child: Text(
              "Back",
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontStyle: FontStyle.italic,
                letterSpacing: 1,
              ),
            ),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.cyan),
              padding: MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: 18)),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
              )),
            ),
          ),
        );
      } else {
        // Handle error
        Get.snackbar(
          'Error',
          'Failed to store value: ${response.body}',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

    } catch (e) {
      // Handle exceptions
      Get.snackbar(
        'Error',
        'Failed to store value: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.width;
    double width = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text(
              "Value will be storing FireBase",
              style: TextStyle(
                fontSize: 21,
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
          backgroundColor: Colors.cyan,
        ),
        body:Obx(() {
           if(isLoading.value){
            return Center(
            child:CircularProgressIndicator(),
              );
              }
          else{
          return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                "Store the value securely and efficiently in Firebase Realtime Database",
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
            SizedBox(height: height * 0.04),
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Value  :",
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(width: width * 0.05),
                  Text(
                    "$value",
                    style: TextStyle(
                      fontSize: 23,
                      color: Colors.black,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            SizedBox(height: height * 0.04),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                "Click Increase button the value will be INCREASED",
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
            SizedBox(height: height * 0.04),
            Container(
              height: height * 0.12,
              width: width * 0.2,
              decoration: BoxDecoration(
                color: Colors.cyan,
                borderRadius: BorderRadius.circular(120),
              ),
              child: GestureDetector(
                child: Center(
                  child: Text(
                    "INCREASE",
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.white,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 1,
                    ),
                  ),
                ),
                onTap: () {
                  Increase();
                },
              ),
            ),
            SizedBox(height: height * 0.04),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                "Click STORE button the value will be Stored in FireBase",
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
            Container(
              height: height * 0.12,
              width: width * 0.2,
              decoration: BoxDecoration(
                color: Colors.cyan,
                borderRadius: BorderRadius.circular(120),
              ),
              child: GestureDetector(
                child: Center(
                  child: Text(
                    "STORE",
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.white,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 1,
                    ),
                  ),
                ),
                onTap: () {
                  storeValueInFirestore();
                },
              ),
            ),
            SizedBox(height: height * 0.13),
      Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Container(
                      height: height * 0.12,
                      width: width * 0.2,
                      decoration: BoxDecoration(
                          color: Colors.cyan,
                          borderRadius: BorderRadius.circular(120)),
                      child: GestureDetector(
                        child: Center(
                          child: Text("SignOut",
                              style: TextStyle(
                                  fontSize: 25,
                                  color: Colors.white,
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 1)),
                        ),
                        onTap: () {
                          Get.defaultDialog(
                              barrierDismissible: false,
                              title: "SignOut",
                              titleStyle: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400),
                              content: Text("Are you sure to SignOut",
                                  style: TextStyle(fontSize: 18)),
                              contentPadding: EdgeInsets.all(10),
                              cancel: TextButton(
                                  onPressed: () {
                                    Get.back();
                                  },
                                  child: Text("No",
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w700,
                                          fontStyle: FontStyle.italic,
                                          letterSpacing: 1)),
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Colors.cyan),
                                      padding: MaterialStateProperty.all(
                                          EdgeInsets.symmetric(horizontal: 18)),
                                      shape: MaterialStateProperty.all(
                                          RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(18))))),
                              confirm: TextButton(
                                  onPressed: () {
                                    Get.to(LoginPage());
                                  },
                                  child: Text("Yes",
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w700,
                                          fontStyle: FontStyle.italic,
                                          letterSpacing: 1)),
                                  style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty.all(Colors.cyan),
                                      padding: MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: 18)),
                                      shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(18))))));
                        },
                      )),
                ),
              ],
            ),
          ],
        );}
        }
          ),
      ),
    );
  }
}
