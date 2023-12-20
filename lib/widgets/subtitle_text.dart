// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class SubtitleText extends StatelessWidget {

  String title;
   SubtitleText({
    Key? key,
    required this.title,
  }) : super(key: key);
  @override
  Widget build(BuildContext context){
    return 
        Text('${title}', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),);
  }
}
