import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unwaste/appcolors.dart';
import 'package:unwaste/dashboard/dashboard.dart';
import 'package:unwaste/login/appconstants.dart';
import 'package:unwaste/login/login_model.dart';
import '../CustomSingleDialog.dart';
import '../customformbutton.dart';
import '../main.dart';
import 'package:http/http.dart'as http;


class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //
  final _loginFormKey = GlobalKey<FormState>();
  TextEditingController edt_mobileno=TextEditingController();
  TextEditingController edt_password=TextEditingController();
  bool loading=false;
  LoginModel loginModel=LoginModel();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,//const Color(0xffEEF1F3),
        body: Column(
          children: [
            //const PageHeader(),
            Container(
              width: 100,
              height: 100,
              child: Image.asset('assets/images/logo.png'),
            ),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20),),
                ),
                child: SingleChildScrollView(
                  child: Form(
                    key: _loginFormKey,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Text('Login',style: TextStyle(color: AppColors.primarynormal,fontSize: 16,fontWeight: FontWeight.bold),),
                          SizedBox(height: 10,),
                          Text(AppConstants.LOGINDESC,style: TextStyle(color: Colors.black54),),
                          SizedBox(height: 25,),
                          const Text('Mobile Number'),
                          Padding(
                            padding: const EdgeInsets.only(right: 10,top: 10,bottom: 10,),
                            child: TextField(
                              controller: edt_mobileno,
                              obscureText: false,
                              textAlign: TextAlign.start,
                              maxLines: 1,
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.normal,
                                fontSize: 14,
                                color: Color(0xff000000),
                              ),
                              decoration: InputDecoration(
                                hintText: 'Enter Mobile Number',
                                disabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  borderSide: BorderSide(color: Colors.black26, width: 1),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  borderSide: BorderSide(color: Colors.black87, width: 1),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  borderSide: BorderSide(color: Colors.black26, width: 1),
                                ),
                                filled: true,
                                fillColor: Color(0xffffffff),
                                /*prefixIcon:
                                Icon(Icons.person, color: Colors.black26, size: 24),*/
                              ),
                            ),
                          ),
                          const Text('Password'),
                          Padding(
                            padding: const EdgeInsets.only(right: 10,top: 10,bottom: 10,),
                            child: TextField(
                              controller: edt_password,
                              obscureText: true,
                              textAlign: TextAlign.start,
                              maxLines: 1,
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.normal,
                                fontSize: 14,
                                color: Color(0xff000000),
                              ),
                              decoration: InputDecoration(
                                hintText: 'Enter Password',
                                disabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  borderSide: BorderSide(color: Colors.black26, width: 1),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  borderSide: BorderSide(color: Colors.black87, width: 1),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  borderSide: BorderSide(color: Colors.black26, width: 1),
                                ),
                                filled: true,
                                fillColor: Color(0xffffffff),
                                /*prefixIcon:
                                Icon(Icons.password, color: Colors.black26, size: 24),*/
                              ),
                            ),
                          ),

                          const SizedBox(height: 16,),
                          Padding(
                            padding: const EdgeInsets.only(right: 10,top: 10,bottom: 10,),
                            child: Center(
                                child: !loading?CustomFormButton(innerText: 'Login', onPressed: _handleLoginUser,):Center(child: CircularProgressIndicator(),)),
                          ),
                          const SizedBox(height: 18,),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handleLoginUser() {
    if (_loginFormKey.currentState!.validate()) {
     /* ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Submitting data..')),
      );*/
      requestCameraPermission();
    }
  }
  Future<void> requestCameraPermission() async {

    final serviceStatus = await Permission.camera.isGranted ;

    bool isCameraOn = serviceStatus == ServiceStatus.enabled;

    final status = await Permission.camera.request();

    if (status == PermissionStatus.granted) {
      requestLocationPermission();
      //print()
    } else if (status == PermissionStatus.denied) {
      print('Permission denied');
    } else if (status == PermissionStatus.permanentlyDenied) {
      print('Permission Permanently Denied');
      await openAppSettings();
    }
  }
  Future<void> requestLocationPermission() async {

    final serviceStatusLocation = await Permission.locationWhenInUse.isGranted ;

    bool isLocation = serviceStatusLocation == ServiceStatus.enabled;

    final status = await Permission.locationWhenInUse.request();

    if (status == PermissionStatus.granted) {
     getcallpsotmethod();
    } else if (status == PermissionStatus.denied) {
      print('Permission denied');
    } else if (status == PermissionStatus.permanentlyDenied) {
      print('Permission Permanently Denied');
      await openAppSettings();
    }

  }
  Future<void> getcallpsotmethod() async {
    var headers = {"Content-Type": "application/json"};
    var body = {
      "username": "${edt_mobileno.text}",
      "password": "${edt_password.text}",
    };
    setState(() {
      loading = true;
    });
    try {
      final response = await http.post(
          Uri.parse(AppConstants.LIVE_URL + 'api/auth/login'),
          body: jsonEncode(body),
          headers: headers);
      print(jsonEncode(body));
      setState(() {
        loading = false;
      });
      print('REPOSD  ${jsonDecode(response.body)}');
      if (response.statusCode == 200) {
        if ('${jsonDecode(response.body)['success'].toString()}' == "false") {
          showDialog(
            barrierColor: Colors.black26,
            context: context,
            barrierDismissible: false,
            builder: (context) {
              return CustomDialogSingle(
                title: "Failed",
                description: '${jsonDecode(response.body)['message']}',
              );
            },
          );
        } else {
          loginModel = LoginModel.fromJson(jsonDecode(response.body));
          print(jsonDecode(response.body));
          Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

          final SharedPreferences prefs = await _prefs;
          prefs.setString("Token", loginModel.data!.token.toString());
          prefs.setString("Name", loginModel.data!.name.toString());
          prefs.setString("Type", loginModel.data!.type.toString());
          prefs.setString("Usertype", loginModel.data!.usertype.toString());
          prefs.setString("Phone", loginModel.data!.phone.toString());
          prefs.setString("Email", loginModel.data!.email.toString());
          prefs.setString("Photo", loginModel.data!.photo.toString());
          prefs.setString("Status", loginModel.data!.photo.toString());
          prefs.setString("ID", loginModel.data!.id.toString());
          prefs.setString("DriverID", loginModel.data!.driverId.toString());
          prefs.setBool("LoggedIn", true);

          Navigator.pushReplacement(
            this.context,
            MaterialPageRoute(builder: (context) => const Dashboardpage()),
          );
        }
      } else {
        showDialog(
          barrierColor: Colors.black26,
          context: context,
          barrierDismissible: false,
          builder: (context) {
            return CustomDialogSingle(
              title: "Failed",
              description: "Failed to Connect Login Api",
            );
          },
        );
      }
    } on SocketException {
      setState(() {
        loading = false;
        showDialog(
            context: this.context,
            builder: (_) => AlertDialog(
                backgroundColor: Colors.black,
                title: Text(
                  "No Response!..",
                  style: TextStyle(color: Colors.purple),
                ),
                content: Text(
                  "Slow Server Response or Internet connection",
                  style: TextStyle(color: Colors.white),
                )));
      });
      throw Exception('Internet is down');
    }
  }
}