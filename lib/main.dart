import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:psa_app/features/authentication/login/login_screen.dart';
import 'package:psa_app/features/authentication/login/map_screen.dart';
import 'package:psa_app/features/home_screen.dart';

void main() {
  runApp(const PSA());
}


class PSA extends StatefulWidget {
  const PSA({ Key? key }) : super(key: key);

  @override
  _PSAState createState() => _PSAState();
}

class _PSAState extends State<PSA> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        builder: FToastBuilder(),
      debugShowCheckedModeBanner: false,
      home:  HomeScreen(),
      getPages: [
        GetPage(name: '/home', page: ()=>  HomeScreen(), transition: Transition.cupertino),
        GetPage(name: '/login', page: ()=>  LoginScreen(),transition: Transition.cupertino),
        GetPage(name: '/map', page: ()=>  MapScreen(),transition: Transition.cupertino),
      ],

    );
  }
}