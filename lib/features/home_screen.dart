
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:psa_app/features/authentication/login/login_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({ Key? key }) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
     final String svgString = '''
    <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
      <path d="M19 7l-9 9-4-4 9-9-2-2-7 7"/>
    </svg>
  ''';

   return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // SVG image
              SvgPicture.string(
                svgString,
                width: 120,
                height: 120,
                color: Colors.blue, // Customize the color if needed
              ),
              SizedBox(height: 16),
              // Text
              Text(
                'Create New Record',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 32),
              // Button
              SizedBox(
                height: 50,
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue[900]
                  ),
                  onPressed: () {
                    Get.to(()=> LoginScreen(), transition: Transition.cupertino);
                    // Handle button press
                    // print('Button pressed');
                  },
                  child: Text('Get Started', style: TextStyle(fontSize: 18),),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}