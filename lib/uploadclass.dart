import 'package:flutter/material.dart';
import 'package:unwaste/dashboard/dashboard.dart';
import 'DashedRect.dart';
import 'customformbutton.dart';

class UploadScreen extends StatefulWidget {
  const UploadScreen({Key? key}) : super(key: key);

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(child: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text('Upload Garbage-Weight',style: TextStyle(color: Colors.black87,fontSize: 16),),

      ),
      body: SingleChildScrollView(
        child:
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(10),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Enter Weight(kg/ton)'),
                        SizedBox(height: 5,),
                        TextField(
                          keyboardType: TextInputType.number,
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
                          ),
                        ),
                        SizedBox(height: 10,),
                        Text('Bill Photo'),
                        SizedBox(height: 5,),
                        Container(
                          height: 200,
                          width: double.infinity,
                          color: Colors.black12,
                          child: DashedRect(color: Colors.grey, strokeWidth: 1.0, gap: 3.0,),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Center(
                child: Container(
                  //width: size.width * 0.8,
                  width: size.width * 0.9,
                  decoration: BoxDecoration(
                    color: const Color(0xDD000000),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextButton(
                    onPressed: (){
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return  Dialog(
                              child: Container(
                                height: 400,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Image.asset('assets/images/apartmentview.png'),
                                    SizedBox(height: 10,),
                                    Text("Thank you!!",style:TextStyle(fontSize: 20),),
                                    SizedBox(height: 10,),
                                    Text("Your Daily task hasbeen Completed. ",style:TextStyle(fontSize: 14),),
                                    SizedBox(height: 5,),
                                    Text("Have a nice day!. ",style:TextStyle(fontSize: 12),),
                                    SizedBox(height: 5,),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: CustomFormButton(innerText: 'Close', onPressed:(){
                                        Navigator.of(context).pop();
                                        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>Dashboardpage()), (route) => false);
                                      }),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          });
                    },
                    child: Text('Submit', style: const TextStyle(color: Colors.white, fontSize: 20),),
                  ),
                ),
              )
            ],
          ),
      ),
    ));
  }
}
