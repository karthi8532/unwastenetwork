import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unwaste/apartmentview/apartment_view.dart';
import 'package:unwaste/appcolors.dart';
import 'package:unwaste/dashboard/RouteModel.dart';
import 'package:unwaste/dashboard/start_journymodel.dart';
import 'package:unwaste/login/appconstants.dart';
import 'package:unwaste/profileview.dart';
import 'package:http/http.dart'as http;

import '../CustomSingleDialog.dart';

class Dashboardpage extends StatefulWidget {
  const Dashboardpage({Key? key}) : super(key: key);
  @override
  State<Dashboardpage> createState() => _DashboardpageState();
}

class _DashboardpageState extends State<Dashboardpage> {
  String sessionmobile="";
  String sessiontoken="";
  String sessionname="";
  String sessionid="";
  RouteModel modell=RouteModel(data: []);
  bool loading=false;
  late int postionselect=0;
  String cdate = DateFormat("yyyy-MM-dd").format(DateTime.now());
  bool startjourny=false;
  @override
  void initState() {
    print(cdate);
    getStringValuesSF();
    super.initState();
  }
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 2,
        title: Text('Home-Dashboard',style: TextStyle(color: Colors.black87,fontSize: 16),),
        actions: [
          InkWell(onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>Profileview()));
          }, child: Padding(
            padding: const EdgeInsets.only(right: 15),
            child: Image.asset('assets/images/avatarmale.png',height: 40,width: 40,),
          ))
        ],
      ),
        body:!loading? Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
             Text('Hello,Welcome',style: TextStyle(fontSize: 12,color: Colors.black54),),
             SizedBox(height: 5,),
             Text(sessionname,style: TextStyle(fontWeight: FontWeight.bold),),
             SizedBox(height: 5,),
             Row(mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.all(5.0),
                  padding: const EdgeInsets.symmetric(horizontal: 5.0,vertical: 2.0),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                      borderRadius:BorderRadius.all(Radius.circular(5)),
                      border: Border.all(color: AppColors.kdashblue),
                  ),
                  child: Text('DriverID:${sessionid.toString()}',style: TextStyle(fontSize: 12),),
                ),
                Container(
                  margin: const EdgeInsets.all(5.0),
                  padding: const EdgeInsets.symmetric(horizontal: 5.0,vertical: 2.0),
                  decoration: BoxDecoration(
                    color: Colors.green.shade50,
                    borderRadius:BorderRadius.all(Radius.circular(5)),
                    border: Border.all(color: Colors.green),
                  ),
                  child: Text('Route No.:01',style: TextStyle(fontSize: 12),),
                ),
                Container(
                  margin: const EdgeInsets.all(5.0),
                  padding: const EdgeInsets.symmetric(horizontal: 5.0,vertical: 2.0),
                  decoration: BoxDecoration(
                    color: Colors.brown.shade50,
                    borderRadius:BorderRadius.all(Radius.circular(5)),
                    border: Border.all(color: AppColors.kdashbrown),
                  ),
                  child: Text('Date:12.02.2023',style: TextStyle(fontSize: 12,color: Colors.brown),),
                ),
              ],
              ),
             SizedBox(height: 5,),
             Divider(
                color: Colors.grey,
                height: 1,
                thickness: 0.8,
              ),
              SizedBox(height: 10,),
              Text('List of Appartments',style: TextStyle(fontSize: 16),),
              SizedBox(height: 25,),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(color: Colors.grey.shade100,borderRadius: BorderRadius.only(topLeft: Radius.circular(25),topRight: Radius.circular(25))),
                  child: Padding(
                    padding: const EdgeInsets.all(13.0),
                    child: modell.data!.length>0?
                    ListView.builder(
                        itemCount: modell.data!.length,
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            onTap: (){
                              setState(() {
                                print('select');
                                postionselect=index;
                              });
                            },
                            child: Card(
                              color: postionselect==index?Colors.lightBlue.shade200 :Colors.white,
                              child: Row(
                                children: [
                                  Expanded(child: Container(
                                      margin: EdgeInsets.all(12),
                                      child: Container(
                                          padding: EdgeInsets.symmetric(vertical: 5,horizontal: 5),
                                          color: Colors.grey.shade200,
                                          child: Image.asset('assets/images/dashlogo.png',width: 40,height: 40,))),flex: 2),
                                      Expanded(child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 5),
                                        child: Text(modell.data![index].apratmentsName.toString()),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 5),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            Image.asset('assets/images/iconnavigate.png',color: AppColors.kdashblue,height: 18,width: 18,),
                                            SizedBox(width: 5,),
                                            Text('${modell.data![index].apratmentsArea.toString()},${modell.data![index].apratmentsAddress.toString()}',style: TextStyle(fontSize: 10,color: Colors.black54),),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(right: 20.0),
                                        child: Divider(
                                          color: Colors.grey.shade400,
                                          height: 1,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 8),
                                        child: Row(
                                          children: [
                                            Image.asset('assets/images/iconbinbag.png',width: 20,height: 20,),
                                            SizedBox(width: 5,),
                                            Text('Bin/Bag-',style: TextStyle(fontSize: 12,color: Colors.black54),),
                                            Text('0',style: TextStyle(fontSize: 14,color: Colors.black87,fontWeight: FontWeight.bold),),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),flex: 8,),
                                ],
                              ),
                            ),
                          );
                        }):Center(child: Text('No Data!'),),
                  ),
                )
              ),
            ],
          ),
        ):Center(child: CircularProgressIndicator(),),
        bottomNavigationBar:
          Visibility(
            visible: startjourny,
            child: ElevatedButton(style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      side: BorderSide(color: Colors.blue)
                  )
              )
        ),
            onPressed: () {
              if (modell.data!.length == 0) {
                 ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Data should not empty!')),);
              } else {
                Navigator.push(context, MaterialPageRoute(builder: (context) =>
                    ApartmentView(
                        routeModel: modell, routeposition: postionselect)));
              }
            },
            child: const SizedBox(
              height: kToolbarHeight,
              width: double.infinity,
              child: Center(
                child: Text(
                  'Start Journey',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
        ),
          ),
      ),
    );
  }
  Future getStringValuesSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    sessiontoken = prefs.getString('Token').toString();
    sessionmobile = prefs.getString('Phone').toString();
    sessionname = prefs.getString('Name').toString();
    sessionid = prefs.getString('ID').toString();
    getstartjournysinglelist();
    //setState(() {});
  }
  Future<void> getstartjournysinglelist() async {
    var headers = {"Content-Type": "application/json",'Authorization': 'Bearer $sessiontoken',};

    var body = {
      "date":cdate
    };

    setState(() {
      loading = true;
    });
    try {
      final response = await http.post(
          Uri.parse(AppConstants.LIVE_URL + 'api/route-assigning/get-driver-assigned-route'),
          body: jsonEncode(body),
          headers: headers);
      print(jsonEncode(body));

      print('REPOSD  ${jsonDecode(response.body)['status']}');
      setState(() {
        loading = false;
      });
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
          modell = RouteModel.fromJson(jsonDecode(response.body));
          setState(() {
            if(modell.data!.length == 0){
              startjourny==false;
            }else{
              startjourny==true;
            }
          });
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
