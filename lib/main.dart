import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:psa_app/features/authentication/login/login_screen.dart';
import 'package:psa_app/features/authentication/login/map_screen.dart';

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
      debugShowCheckedModeBanner: false,
      home:  MapScreen(),
      getPages: [
        GetPage(name: '/login', page: ()=>  LoginScreen()),
        GetPage(name: '/map', page: ()=>  MapScreen())
      ],

    );
  }
}