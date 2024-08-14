import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import 'MainView.dart';
class LoginPage extends StatelessWidget {
  final GlobalKey<FormState> formKey=GlobalKey<FormState>();
  TextEditingController name=TextEditingController();
  TextEditingController phone=TextEditingController();
  TextEditingController email=TextEditingController();
  TextEditingController password=TextEditingController();
  RxBool visibility=false.obs;
  @override
  Widget build(BuildContext context) {
    double height=MediaQuery.of(context).size.width;
    double width=MediaQuery.of(context).size.height;
    return Scaffold(
      body:Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
          height:height*0.4,
          width:width,
          decoration: BoxDecoration(
              color:Colors.cyan,
            borderRadius: BorderRadius.only(
              bottomLeft:Radius.circular(40),
              bottomRight:Radius.circular(40),

            )
          ),
          child:Stack(
            children:[
              Positioned(
                bottom:10,
                right:width*0.10,
                child: Center(
                  child: Text(
                    """Welcome to our 
        Page""",
                    style:TextStyle(fontSize:30,
                    color:Colors.white,
                    fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1
                    )
                  ),
                ),
              )
            ]
          )
        ),
          SizedBox(height:height*0.1),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top:30,bottom: 10),
              child: Text(
                "Login",
                style:TextStyle(
                  fontSize:30,
                  color:Colors.cyan,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1
                )
              ),
            ),
          ),
          Obx(() {
            return Form(
              key: formKey,
              child: Expanded(
                  child: SingleChildScrollView(
                      child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 18,
                                  right: 18,
                                  bottom: 20),
                              child: TextFormField(
                                  controller: name,
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(Icons.person),
                                    hintText: "Enter Your Name",
                                    focusedBorder: UnderlineInputBorder(
                                     borderSide: BorderSide(
                                       color:Colors.cyan
                                     )
                                    )
                                  ),

                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return " Enter Your Name";
                                    }
                                    return null;
                                  }
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 18,
                                  right: 18,
                                  bottom: 20),
                              child: TextFormField(
                                  controller: phone,
                                  keyboardType:TextInputType.number,
                                  decoration: InputDecoration(
                                    hintText: "Enter Your Phone No",
                                    prefixIcon: Icon(Icons.call_outlined),
                                    focusedBorder:UnderlineInputBorder(
                                      borderSide:BorderSide(
                                        color:Colors.cyan,
                                      )
                                    )
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Enter Your Phone No";
                                    }
                                    else if (value.length < 10 || value.length>=11) {
                                      return "Phone Number Must Be 10 Numbers";
                                    }
                                    return null;
                                  }
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 18,
                                  right: 18,
                                  bottom: 20),
                              child: TextFormField(
                                  controller: email,
                                  decoration: InputDecoration(
                                      hintText: "Enter Your Email",
                                      prefixIcon: Icon(Icons.email_outlined),
                                    focusedBorder:UnderlineInputBorder(
                                      borderSide:BorderSide(
                                        color:Colors.cyan,
                                      )
                                    )
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Enter Your Email Id";
                                    }
                                    else if (!RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$')
                                        .hasMatch(value)) {
                                      return "Please Enter A Valid Email Address";
                                    }
                                    return null;
                                  }
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 18,
                                  right: 18,
                                  bottom: 20),
                              child: TextFormField(
                                  controller: password,
                                  obscureText: visibility.value ? false : true,
                                  decoration: InputDecoration(
                                      hintText: "Enter Your Password",
                                      prefixIcon: Icon(
                                          Icons.lock_open_outlined),
                                      suffixIcon: IconButton(
                                          icon: visibility.value? Icon(
                                              Icons.visibility_outlined) :
                                          Icon(Icons.visibility_off_outlined),
                                          onPressed: () {
                                            visibility.value = !visibility.value;
                                          }
                                      ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color:Colors.cyan,
                                      )
                                    )
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Enter Your Password ";
                                    }
                                    else if (value.length <6) {
                                      return "Password  Must Be At Least 6 Numbers";
                                    }
                                    return null;
                                  }
                              ),
                            ),
                            SizedBox(height: 20),
                            Center(
                              child: TextButton(
                                  style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty
                                          .all(
                                        Colors.cyan,
                                      ),
                                      shape: MaterialStateProperty.all(
                                          RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                10),
                                          )
                                      ),
                                      padding: MaterialStateProperty.all(
                                          EdgeInsets.only(right: 20,
                                              left: 20,
                                              top: 10,
                                              bottom: 10))
                                  ),
                                  onPressed: () {
                                    if (formKey.currentState?.validate() ?? false) {
                                  Get.off(MainView());
                                  };
                                    },
                                  child: Text(
                                      "SignIn",
                                      style: TextStyle(
                                          fontSize: 30,
                                          color: Colors.white,
                                          fontStyle: FontStyle.italic,
                                          fontWeight: FontWeight.w500,
                                          letterSpacing: 1
                                      )
                                  )
                              ),
                            )
                          ]
                      )
                  )),
            );
          }
          )
      ]
      )
      //backgroundColor: Colors.cyan,
    );
  }
}
