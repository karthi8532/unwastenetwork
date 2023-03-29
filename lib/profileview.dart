import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:unwaste/login/login_page.dart';
import 'package:unwaste/splashscreen.dart';

class Profileview extends StatefulWidget {
  const Profileview({Key? key}) : super(key: key);

  @override
  State<Profileview> createState() => _ProfileviewState();
}

class _ProfileviewState extends State<Profileview> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text('Profile',style: TextStyle(color: Colors.black87,fontSize: 16),),
        actions: [
          InkWell(child: Icon(Icons.clear,color: Colors.black87,),onTap: (){
            Navigator.pop(context);
          },)
        ],
      ),
      body: Column(
        mainAxisAlignment:  MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              child: Column(
                children: [
                  Image.asset('assets/images/avatarmale.png',width: 100,height: 100,),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Karthikeyan'),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('+91-9750045024'),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: const EdgeInsets.all(15.0),
                        padding: const EdgeInsets.symmetric(horizontal: 3.0,vertical: 3.0),
                        decoration: BoxDecoration(
                          color: Colors.blue.shade50,
                          borderRadius:BorderRadius.all(Radius.circular(5)),
                          border: Border.all(color: Colors.blueAccent),
                        ),
                        child: Text('DriverID:03342',style: TextStyle(fontSize: 12),),
                      ),
                      SizedBox(width: 5,),
                      Container(
                        margin: const EdgeInsets.all(15.0),
                        padding: const EdgeInsets.symmetric(horizontal: 3.0,vertical: 3.0),
                        decoration: BoxDecoration(
                          color: Colors.green.shade50,
                          borderRadius:BorderRadius.all(Radius.circular(5)),
                          border: Border.all(color: Colors.green),
                        ),
                        child: Text('Route No.:01',style: TextStyle(fontSize: 12),),
                      ),
                    ],
                  ),

                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 15.0),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.9,
              decoration: BoxDecoration(
                color:  Colors.red,
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextButton(
                onPressed: (){
                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>LoginPage()), (route) => false);
                },
                child: Text("Sign Out", style: const TextStyle(color: Colors.white, fontSize: 20),),
              ),
            ),
          ),

        ],
      ),
    ));
  }
}
