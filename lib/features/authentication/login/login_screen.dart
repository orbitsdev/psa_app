import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {



  String? resultData;

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController middleNameController = TextEditingController();
  final TextEditingController dateOfBirthController = TextEditingController();
  final TextEditingController placeOfBirthCityController = TextEditingController();
  final TextEditingController placeOfBirthProvinceController = TextEditingController();
  final TextEditingController placeOfBirthCountryController = TextEditingController();
  final TextEditingController fatherFirstNameController = TextEditingController();
  final TextEditingController fatherLastNameController = TextEditingController();
  final TextEditingController fatherMiddleNameController = TextEditingController();
  final TextEditingController motherFirstNameController = TextEditingController();
  final TextEditingController motherLastNameController = TextEditingController();
  final TextEditingController motherMiddleNameController = TextEditingController();
  final TextEditingController latitudeController = TextEditingController();
  final TextEditingController longitudeController = TextEditingController();
  final TextEditingController placeIdController = TextEditingController();
  final TextEditingController imageController = TextEditingController();

  // Future<void> postData() async {

  //   final response = await http.post(
  //     Uri.parse('http://146.190.108.6/data-collection/create',
      
  //     ),
  //      headers: {
  //     'Authorization': 'Bearer 2|sJYOo9p7koDODb9aHLHr5LP7AY5JijiBHSxNrz3N7f39e2e7', // Replace with your actual token
    
  //   },
  //     body: {
  //       'first_name': firstNameController.text,
  //       'last_name': lastNameController.text,
  //       'middle_name': middleNameController.text,
  //       // 'date_of_birth': dateOfBirthController.text,
  //       // 'place_of_birth_city': placeOfBirthCityController.text,
  //       // 'place_of_birth_province': placeOfBirthProvinceController.text,
  //       // 'place_of_birth_country': placeOfBirthCountryController.text,
  //       // 'father_first_name': fatherFirstNameController.text,
  //       // 'father_last_name': fatherLastNameController.text,
  //       // 'father_middle_name': fatherMiddleNameController.text,
  //       // 'mother_first_name': motherFirstNameController.text,
  //       // 'mother_last_name': motherLastNameController.text,
  //       // 'mother_middle_name': motherMiddleNameController.text,
  //       // 'latitude':123,
  //       // 'longitude': 123,
  //       // 'place_id': placeIdController.text,
  //       // 'image': imageController.text,
  //     },
  //    );

  //    Map<String,dynamic> mapData =  jsonDecode(response.body);

  //    print(mapData);
     
  //   //  print(json.decode(response.body));

  //   // if (response.statusCode == 200) {
  //   //   // Successful POST request
  //   //   final data = jsonDecode(response.body);
  //   //   setState(() {
  //   //       resultData = resultData;
  //   //   });
  //   //   print(data);
  //   // } else {
  //   //   // Handle errors
  //   //   print('Error: ${response.statusCode}');
  //   // }
  // }

   @override
  void initState() {
    super.initState();
  }

 
  void testApi() async {
    final url = Uri.parse('http://146.190.108.6/api/data-collection/create');

    
    // Replace 'key' and 'value' with your actual data
    final data = {
        'first_name': firstNameController.text,
        'last_name': lastNameController.text,
        'middle_name': middleNameController.text,
        'date_of_birth': dateOfBirthController.text,
        'place_of_birth_city': placeOfBirthCityController.text,
        'place_of_birth_province': placeOfBirthProvinceController.text,
        'place_of_birth_country': placeOfBirthCountryController.text,
        'father_first_name': fatherFirstNameController.text,
        'father_last_name': fatherLastNameController.text,
        'father_middle_name': fatherMiddleNameController.text,
        'mother_first_name': motherFirstNameController.text,
        'mother_last_name': motherLastNameController.text,
        'mother_middle_name': motherMiddleNameController.text,
        'latitude':latitudeController.text.isNotEmpty ? double.parse(latitudeController.text) : 0,
        'longitude': longitudeController.text.isNotEmpty ? double.parse(latitudeController.text) : 0,
        'place_id': placeIdController.text,
        'image': imageController.text,
      };
    final response = await http.post(
      url,
      body: jsonEncode(data),
      headers: {
        'Content-Type': 'application/json'
        
        },
    );

    Map<String, dynamic> result = jsonDecode(response.body);

    setState(() {
      resultData = result.toString() + 'FROM  HTTP';
    });

    print('________________________________________________________________');
    print(result);
  }

 
  // void testApi() async {
  //   final url = Uri.parse('http://146.190.108.6/api/test');
  //   // Replace 'key' and 'value' with your actual data
  //   final data = {'a': 'b'};

  //   final response = await http.post(
  //     url,
  //     body: jsonEncode(data),
  //     headers: {'Content-Type': 'application/json'},
  //   );

  //   // Corrected decoding
  //   Map<String, dynamic> result = jsonDecode(response.body);

  //   setState(() {
  //     resultData = result.toString() + 'FROM  HTTP';
  //   });

  //   print(result);
  // }

  // void testApiDio() async {
  //   final dio = Dio();
  //   final url = 'http://146.190.108.6/api/test';

  //   // Replace 'key' and 'value' with your actual data
  //   final data = {'a': 'b'};

  //   try {
  //     final response = await dio.post(
  //       url,
  //       data: data,
  //       options: Options(headers: {'Content-Type': 'application/json'}),
  //     );

  //     print(response.data);

      
  //   setState(() {
  //     resultData = response.data.toString() + 'FROM DIO' ;
  //   });
  //   } catch (error) {
  //     print('Error: $error');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
     return Scaffold(
      appBar: AppBar(
        title: Text('Data Collection Form'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // TextFields for all fields in the model
              TextField(
                controller: firstNameController,
                decoration: InputDecoration(labelText: 'First Name'),
              ),
              TextField(
                controller: lastNameController,
                decoration: InputDecoration(labelText: 'Last Name'),
              ),
              TextField(
                controller: middleNameController,
                decoration: InputDecoration(labelText: 'Middle Name'),
              ),
              TextField(
                controller: dateOfBirthController,
                decoration: InputDecoration(labelText: 'Date of Birth'),
              ),
              TextField(
                controller: placeOfBirthCityController,
                decoration: InputDecoration(labelText: 'Place of Birth (City)'),
              ),
              TextField(
                controller: placeOfBirthProvinceController,
                decoration: InputDecoration(labelText: 'Place of Birth (Province)'),
              ),
              TextField(
                controller: placeOfBirthCountryController,
                decoration: InputDecoration(labelText: 'Place of Birth (Country)'),
              ),
              TextField(
                controller: fatherFirstNameController,
                decoration: InputDecoration(labelText: 'Father First Name'),
              ),
              TextField(
                controller: fatherLastNameController,
                decoration: InputDecoration(labelText: 'Father Last Name'),
              ),
              TextField(
                controller: fatherMiddleNameController,
                decoration: InputDecoration(labelText: 'Father Middle Name'),
              ),
              TextField(
                controller: motherFirstNameController,
                decoration: InputDecoration(labelText: 'Mother First Name'),
              ),
              TextField(
                controller: motherLastNameController,
                decoration: InputDecoration(labelText: 'Mother Last Name'),
              ),
              TextField(
                controller: motherMiddleNameController,
                decoration: InputDecoration(labelText: 'Mother Middle Name'),
              ),
              TextField(
                controller: latitudeController,
                decoration: InputDecoration(labelText: 'Latitude'),
              ),
              TextField(
                controller: longitudeController,
                decoration: InputDecoration(labelText: 'Longitude'),
              ),
              TextField(
                controller: placeIdController,
                decoration: InputDecoration(labelText: 'Place ID'),
              ),
              TextField(
                controller: imageController,
                decoration: InputDecoration(labelText: 'Image URL'),
              ),

              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => testApi(),
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
