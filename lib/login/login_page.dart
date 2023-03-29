import 'package:flutter/material.dart';
import 'package:unwaste/appcolors.dart';
import 'package:unwaste/dashboard/dashboard.dart';
import 'package:unwaste/login/appconstants.dart';
import 'package:unwaste/login/pageheader.dart';

import '../customformbutton.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //
  final _loginFormKey = GlobalKey<FormState>();

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
                                child: CustomFormButton(innerText: 'Login', onPressed: _handleLoginUser,)),
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
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Dashboardpage()),
      );
    }
  }
}