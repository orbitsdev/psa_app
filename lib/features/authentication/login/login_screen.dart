import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:psa_app/features/authentication/login/map_screen.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:psa_app/utils/modal.dart';
import 'package:psa_app/widgets/subtitle_text.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormBuilderState>();

  LatLng? selectedLocation;
  String? resultData;
  bool isLoading = false;


void setLoading(bool loading){
  setState(() {
    isLoading = loading;
  });
}
  void submitForm() async {
    setLoading(true);
      final url = Uri.parse('http://146.190.108.6/api/data-collection/create');
  //   // Replace 'key' and 'value' with your actual data
    _formKey.currentState?.saveAndValidate();
    _formKey.currentState?.validate();
    var formValue = _formKey.currentState?.value;
    final data = {
      'first_name': formValue?['first_name'],
      'last_name': formValue?['last_name'],
      'middle_name': formValue?['middle_name'],
      'date_of_birth': formValue?['date_of_birth'] is DateTime
    ? (formValue!['date_of_birth'] as DateTime).toIso8601String()
    : null,

      'place_of_birth_city': formValue?['place_of_birth_city'],
      'place_of_birth_province': formValue?['place_of_birth_province'],
      'place_of_birth_country': formValue?['place_of_birth_country'],
      'father_first_name': formValue?['father_first_name'],
      'father_last_name': formValue?['father_last_name'],
      'father_middle_name': formValue?['father_middle_name'],
      'mother_first_name': formValue?['mother_first_name'],
      'mother_last_name': formValue?['mother_last_name'],
      'mother_middle_name': formValue?['mother_middle_name'],
      'latitude': formValue?['latitude'] != null ? formValue!['latitude'] : null,
      'longitude': formValue?['longitude'] != null ? formValue!['longitude'] : null,

      // 'place_id': formValue?['place_id'],
      'address': formValue?['address'],
      'image': formValue?['first_name'],
    };

    //  print(data);

try {
      // Show loading indicator here if needed

      final response = await http.post(
        url,
        body: jsonEncode(data),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        // Successful request
        Map<String, dynamic> result = jsonDecode(response.body);
            setLoading(false);


        print('Request successful');
        _formKey.currentState?.reset();

        // Show success message or navigate to a success screen
         Modal.showSucces(message: 'Save successful');
      
      } else {
                    setLoading(false);

        // Handle non-200 status codes
        print('Request failed with status: ${response.statusCode}');
        print('Response body: ${response.body}');
       

        Modal.showErrorDialog(context: context, message: 'Request failed with status: ${response.statusCode}');
      }
    } on SocketException catch (e) {
                  setLoading(false);

      print('SocketException: $e');
              Modal.showErrorDialog(context: context, message: 'Network error: $e');
    } on TimeoutException catch (e) {
                  setLoading(false);

      print('TimeoutException: $e');
    
       Modal.showErrorDialog(context: context, message: 'Request timed out');
    } catch (error) {
                  setLoading(false);

      print('Error during request: $error');
  
         Modal.
         showErrorDialog(context: context, message: 'An unexpected error occurred');
    } finally {
                  setLoading(false);

      // Hide loading indicator here if needed
    }

  }

  @override
  void initState() {
    super.initState();
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

  void setLocationDetailsFromMap(LatLng? location) {

    print('_________________________');
    print(location);
    print('_________________________');
       var formState = _formKey.currentState;

    if (location != null) {
      setState(() {
        selectedLocation = location;
       
        formState!.fields['latitude']?.didChange(location.latitude.toString());
        // Modify the value of the 'longitude' field
        formState.fields['longitude']?.didChange(location.longitude.toString());
      });
    } else {

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: Text('Collection Form'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: FormBuilder(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(),
                SubtitleText(
                  title: 'Basic Information',
                ),
                FormBuilderTextField(
                  name: 'first_name',
                  decoration: const InputDecoration(labelText: 'First Name'),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                    // FormBuilderValidators.email(),
                  ]),
                ),
                FormBuilderTextField(
                  name: 'last_name',
                  decoration: const InputDecoration(labelText: 'Last Name'),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                    // FormBuilderValidators.email(),
                  ]),
                ),
                FormBuilderTextField(
                  name: 'middle_name',
                  decoration: const InputDecoration(labelText: 'Middle Name'),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                    // FormBuilderValidators.email(),
                  ]),
                ),
                FormBuilderDateTimePicker(
                  name: 'date_of_birth',
                  inputType: InputType.date,
                  format:
                      DateFormat('yyyy-MM-dd'), // Set the desired date format
                  decoration: const InputDecoration(
                    labelText: 'Date of Birth',
                  ),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                  ]),
                ),

                FormBuilderTextField(
                  name: 'place_of_birth_city',
                  decoration: const InputDecoration(labelText: 'City'),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                    // FormBuilderValidators.email(),
                  ]),
                ),
                FormBuilderTextField(
                  name: 'place_of_birth_province',
                  decoration: const InputDecoration(labelText: 'Province'),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                    // FormBuilderValidators.email(),
                  ]),
                ),
                FormBuilderTextField(
                  name: 'place_of_birth_country',
                  decoration: const InputDecoration(labelText: 'Country'),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                    // FormBuilderValidators.email(),
                  ]),
                ),

                 FormBuilderTextField(
        name: 'address',
        decoration: InputDecoration(labelText: 'Address'),
        maxLines: 3, // Set the number of lines for the text area
        validator: FormBuilderValidators.compose([
          FormBuilderValidators.required(),

        ]),
      ),
                const Gap(10),
                SubtitleText(
                  title: 'Father Information',
                ),
                FormBuilderTextField(
                  name: 'father_first_name',
                  decoration: const InputDecoration(labelText: 'First Name'),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                    // FormBuilderValidators.email(),
                  ]),
                ),
                FormBuilderTextField(
                  name: 'father_last_name',
                  decoration: const InputDecoration(labelText: 'Last Name'),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                    // FormBuilderValidators.email(),
                  ]),
                ),
                FormBuilderTextField(
                  name: 'father_middle_name',
                  decoration: const InputDecoration(labelText: 'Middle Name'),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                    // FormBuilderValidators.email(),
                  ]),
                ),
                const Gap(10),
                SubtitleText(
                  title: 'Mother Information',
                ),
                FormBuilderTextField(
                  name: 'mother_first_name',
                  decoration: const InputDecoration(labelText: 'First Name'),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                    // FormBuilderValidators.email(),
                  ]),
                ),
                FormBuilderTextField(
                  name: 'mother_last_name',
                  decoration: const InputDecoration(labelText: 'Last Name'),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                    // FormBuilderValidators.email(),
                  ]),
                ),
                FormBuilderTextField(
                  name: 'mother_middle_name',
                  decoration: const InputDecoration(labelText: 'Middle Name'),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                    // FormBuilderValidators.email(),
                  ]),
                ),

                const Gap(10),
                SubtitleText(
                  title: 'Location Information',
                ),
                const Gap(2),
                Text(
                  'For latitude  You must select a location abse on the map',
                  style: TextStyle(color: Colors.grey),
                ),
                const Gap(10),

                FormBuilderTextField(
                   enabled: false, 
                  name: 'latitude',
                  decoration: const InputDecoration(labelText: 'Latitude'),
                  keyboardType:
                      TextInputType.number, // Set the keyboard type to number
                  validator: FormBuilderValidators.compose([
                    // FormBuilderValidators.required(),
                    FormBuilderValidators
                        .numeric(), // Validate that the input is a number
                  ]),
                ),
                FormBuilderTextField(
                   enabled: false, 
                  name: 'longitude',
                  decoration: const InputDecoration(labelText: 'Longitude'),
                  keyboardType:
                      TextInputType.number, // Set the keyboard type to number
                  validator: FormBuilderValidators.compose([
                    // FormBuilderValidators.required(),
                    FormBuilderValidators
                        .numeric(), // Validate that the input is a number
                  ]),
                ),

                const SizedBox(height: 10),
                // FormBuilderTextField(
                //   name: 'password',
                //   decoration: const InputDecoration(labelText: 'Password'),
                //   obscureText: true,
                //   validator: FormBuilderValidators.compose([
                //     FormBuilderValidators.required(),
                //   ]),
                // ),

                const Gap(10),
                isLoading ? SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue[900]),
                    onPressed: null,
                    child: CircularProgressIndicator(color: Colors.white,),
                  ),
                )  : SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue[900]),
                    onPressed: () => submitForm(),
                    child: Center(
                        child: const Text(
                      'Submit Form',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    )),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue[900],
        onPressed: () async {
          try {
            LatLng? selectedLocationFromMap = await Get.to(() => MapScreen());
            setLocationDetailsFromMap(selectedLocationFromMap);
          } catch (e) {
            // Handle other exceptions by showing the error dialog
            print('----------------');
            Modal.showErrorDialog(
                context: context, message: 'Unexpected error: $e');
          }

          // Modal.showErrorDialog(context: context);

          // LatLng? selectedLocationFromMap = await Get.to(() => MapScreen());

          // if (selectedLocationFromMap != null) {
          //   var formValue = _formKey.currentState?.value;
          //   print('--------------------------------');
          //   print(formValue);
          //   print('--------------------------------');
          //   print(formValue);
          //   formValue?['latitude'] =
          //       selectedLocationFromMap.latitude.toString();
          //   formValue?['longitude'] =
          //       selectedLocationFromMap.longitude.toString();

          //   setState(() {
          //     selectedLocation = selectedLocationFromMap;
          //   });
          // } else {
          //   print('--------------------------------');
          //   print('DID NOT SELECTED LOCATION');
          //   print('--------------------------------');
          // }
        },
        child: Icon(Icons.pin_drop),
      ),
    );
  }
}
