import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unwaste/apartmentview/apartment_view.dart';
import 'package:unwaste/appcolors.dart';
import 'package:unwaste/check_open_journeymodel.dart';
import 'package:unwaste/profileview.dart';
import 'package:http/http.dart' as http;

import '../CustomSingleDialog.dart';
import '../apartmentview/PostLocation.dart';
import '../appconstants/appconstants.dart';
import 'dashboardmodel.dart';

class Dashboardpage extends StatefulWidget {
  const Dashboardpage({Key? key}) : super(key: key);

  @override
  State<Dashboardpage> createState() => _DashboardpageState();
}

class _DashboardpageState extends State<Dashboardpage> {
  String sessionmobile = "";
  String sessiontoken = "";
  String sessionname = "";
  String sessionid = "";
  String sessionroutemasterid = "";
  String sessiondate = "";
  String sessionassignid = "";
  String sessiondriverID = "";
  String sessionrouteID = "";

  //RouteModel modell=RouteModel(data: []);
  CheckOpenJourneyModel openjourneymodel = CheckOpenJourneyModel();
  DashboardModel dashboardModel = DashboardModel();

  bool loading = false;
  late int postionselect = 0;
  var clickapartmentid = "";
  bool? startjourny;
  bool isdataavailable=false;
  @override
  void initState() {
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
          title: const Text(
            'Home - Dashboard',
            style: TextStyle(color: Colors.black87, fontSize: 16),
          ),
          actions: [
            InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Profileview()));
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: Image.asset(
                    'assets/images/avatarmale.png',
                    height: 40,
                    width: 40,
                  ),
                )),
          ],
        ),
        body: !loading ?Padding(
                padding: const EdgeInsets.only(left: 16, right: 16, top: 10),
                child: 
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text(
                      'Hello,Welcome',
                      style: TextStyle(fontSize: 12, color: Colors.black54),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      sessionname,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.all(5.0),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 5.0, vertical: 2.0),
                            decoration: BoxDecoration(
                              color: Colors.blue.shade50,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(5)),
                              border: Border.all(color: AppColors.kdashblue),
                            ),
                            child: Text(
                              'Driver ID : ${sessionid.toString()}',
                              style: const TextStyle(fontSize: 12),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.all(5.0),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 5.0, vertical: 2.0),
                            decoration: BoxDecoration(
                              color: Colors.green.shade50,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(5)),
                              border: Border.all(color: Colors.green),
                            ),
                            child:Text(
                               dashboardModel.data==null?  "Route : $sessionroutemasterid" : "Route : ${dashboardModel.data!.routeMasterName.toString()}"
                             
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.all(5.0),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 5.0, vertical: 2.0),
                            decoration: BoxDecoration(
                              color: Colors.brown.shade50,
                              borderRadius: BorderRadius.all(Radius.circular(5)),
                              border: Border.all(color: AppColors.kdashbrown),
                            ),
                            child: Text(
                              'Date : ${sessiondate}' ?? "",
                              style: TextStyle(fontSize: 12, color: Colors.brown),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    const Divider(
                      color: Colors.grey,
                      height: 1,
                      thickness: 0.8,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                         const  Expanded(
                            child: Text(
                          'List of Apartments',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        )),
                        TextButton.icon(
                          onPressed: () {
                            checkjournystartornot();
                          },
                          icon: const Icon(Icons.refresh, color: Colors.white),
                          label: const Text('Refresh',
                              style: TextStyle(color: Colors.white)),
                          style: const ButtonStyle(
                              backgroundColor:
                                  MaterialStatePropertyAll(Color(0xFF192C49)),
                              maximumSize:
                                  MaterialStatePropertyAll(Size(120, 36))),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Expanded(
                        child: Container(
                      decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius:const BorderRadius.only(
                              topLeft: Radius.circular(25),
                              topRight: Radius.circular(25))),
                      child: Padding(
                        padding: const EdgeInsets.all(13.0),
                        child: isdataavailable==true
                            ? ListView.builder(
                                itemCount: 1,
                                itemBuilder: (BuildContext context, int index) {
                                  return GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        postionselect = index;
                                      });
                                    },
                                    child:isdataavailable==true
                                        ? Card(
                                            color: postionselect == index
                                                ? Colors.white
                                                : Colors.white,
                                            child: Row(
                                              children: [
                                                Expanded(
                                                    flex: 2,
                                                    child: Container(
                                                        margin:
                                                        const EdgeInsets.all(12),
                                                        child: Container(
                                                            padding:const EdgeInsets
                                                                .symmetric(
                                                                    vertical: 5,
                                                                    horizontal:
                                                                        5),
                                                            color: Colors
                                                                .grey.shade200,
                                                            child: Image.asset(
                                                              'assets/images/dashlogo.png',
                                                              width: 40,
                                                              height: 40,
                                                            )))),
                                                dashboardModel.data
                                                        .toString()
                                                        .isNotEmpty
                                                    ? Expanded(
                                                        flex: 8,
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .symmetric(
                                                                      vertical:
                                                                          5),
                                                              child: Text(
                                                                dashboardModel.data!.apartment![index].name.toString(),
                                                                style:const TextStyle(
                                                                    fontSize:
                                                                        16),
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .symmetric(
                                                                      vertical:
                                                                          5),
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Image.asset(
                                                                    'assets/images/iconnavigate.png',
                                                                    color: AppColors
                                                                        .kdashblue,
                                                                    height: 18,
                                                                    width: 18,
                                                                  ),
                                                                  const SizedBox(
                                                                    width: 5,
                                                                  ),
                                                                  Expanded(
                                                                    flex: 1,
                                                                    child: Column(
                                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                                      children: [
                                                                        Text(
                                                                          dashboardModel
                                                                              .data!
                                                                              .apartment![index]
                                                                              .area
                                                                              .toString(),
                                                                          style: const TextStyle(
                                                                              fontSize:
                                                                                  12,
                                                                              color:
                                                                                  Colors.black54),
                                                                          overflow:
                                                                              TextOverflow.ellipsis,
                                                                        ),
                                                                        Text(
                                                                          dashboardModel.data!.apartment![index].address.toString(),
                                                                          style: const TextStyle(
                                                                              fontSize:
                                                                                  12,
                                                                              color:
                                                                                  Colors.black54),
                                                                          overflow:
                                                                              TextOverflow.ellipsis,
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      right:
                                                                          20.0),
                                                              child: Divider(
                                                                color: Colors
                                                                    .grey
                                                                    .shade400,
                                                                height: 1,
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .symmetric(
                                                                      vertical:
                                                                          8),
                                                              child: Row(
                                                                children: [
                                                                  Image.asset(
                                                                    'assets/images/iconbinbag.png',
                                                                    width: 20,
                                                                    height: 20,
                                                                  ),
                                                                  const SizedBox(
                                                                    width: 5,
                                                                  ),
                                                                  const Text(
                                                                    'Bin/Bag - ',
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            12,
                                                                        color: Colors
                                                                            .black54),
                                                                  ),
                                                                  const  Text(
                                                                    '0',
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            14,
                                                                        color: Colors
                                                                            .black87,
                                                                        fontWeight:
                                                                            FontWeight.bold),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      )
                                                    : Container(),
                                              ],
                                            ),
                                          )
                                        : const Center(
                                            child: Text('NoData'),
                                          ),
                                  );
                                })
                            : const Center(
                                child: Text('No Apartment Found!'),
                              ),
                      ),
                    )),
                  ],
                )
              )
            : const Center(
                child: CircularProgressIndicator(),
              ),
        bottomNavigationBar: Visibility(
          child: ElevatedButton(
            style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        side:const BorderSide(color: Colors.blue)))),
            onPressed: isdataavailable == false
                ? null
                :
                () async {
              Future<SharedPreferences> _prefs =
                  SharedPreferences.getInstance();
              final SharedPreferences prefs = await _prefs;
              prefs.setString("RouteId", dashboardModel.data!.rmId.toString());
              prefs.setString("RouteassignID",
                  dashboardModel.data!.routeAssignId.toString());
              prefs.setString(
                  "VehicleId", dashboardModel.data!.vehicleId.toString());
              prefs.setString(
                  "JournyEndId", dashboardModel.data!.id.toString());
              prefs.setString(
                  "RouteName", dashboardModel.data!.routeMasterName.toString());
              _getCurrentPosition();
              //}
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
    sessionroutemasterid = prefs.getString('RouteId').toString();
    sessiondate = prefs.getString('Date').toString();
    sessionassignid = prefs.getString('RouteassignID').toString() ?? "0";
    sessiondriverID = prefs.getString('DriverID').toString() ?? "0";
    //sessionrouteID = prefs.getString('RouteID').toString() ?? "0";

    checkjournystartornot();
    setState(() {});
  }

  Future<void> checkjournystartornot() async {
    setState(() {
      loading = true;
    });
    try {
      SharedPreferences prefs1 = await SharedPreferences.getInstance();
      sessionroutemasterid = prefs1.getString('RouteId').toString();
      var headers = {
        "Content-Type": "application/json",
        'Authorization': 'Bearer $sessiontoken',
      };

      var body = {
        "date": AppConstants.cdate,
        "route_id": int.parse(sessionroutemasterid) ?? 0,
        "driver_id": int.parse(sessiondriverID),
      };
      print('CHECk OPEN ${jsonEncode(body)}');

      final response = await http.post(
          Uri.parse(AppConstants.CHECKJOURNYORNOT),
          body: jsonEncode(body),
          headers: headers);

      if (response.statusCode == 200) {
        if (jsonDecode(response.body)['success'] == true) {
          openjourneymodel =
              CheckOpenJourneyModel.fromJson(jsonDecode(response.body));
          if (openjourneymodel.data!.isOpenJourney.toString()=="1") {
             if (mounted) {
             getalreadylogged();
            }
          } else {
            if (mounted) {
            getstartjournysinglelist();
            }
          }
        } else {
          if(!mounted) return;
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
        }
      }
    } on Exception catch (e) {
      setState(() {
        loading = false;
      });
      return showDialog(
        barrierColor: Colors.black26,
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return CustomDialogSingle(
            title: "Failed",
            description: e.toString(),
          );
        },
      );
    }
  }

  Future<void> getalreadylogged() async {
    var headers = {
      "Content-Type": "application/json",
      'Authorization': 'Bearer $sessiontoken',
    };

    var body = {
      "date": AppConstants.cdate,
      "driver_id": int.parse(sessiondriverID),
    };

    setState(() {
      loading = true;
    });
    try {
      final response = await http.post(
          Uri.parse(AppConstants.GETDRIVERASSIGNROUTE),
          body: jsonEncode(body),
          headers: headers);
     
    
      setState(() {
        loading = false;
      });
      if (response.statusCode == 200) {
        if (jsonDecode(response.body)['success'].toString() == "false") {
          setState(() {
            isdataavailable=false;
          });
          if (!mounted) return;
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
         
          dashboardModel = DashboardModel.fromJson(jsonDecode(response.body));
       
          Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
          final SharedPreferences prefs = await _prefs;
          prefs.setString("RouteId", dashboardModel.data!.rmId.toString());
          prefs.setString(
              "RouteassignID", dashboardModel.data!.routeAssignId.toString());
          prefs.setString(
              "VehicleId", dashboardModel.data!.vehicleId.toString());
          prefs.setString("JournyEndId", dashboardModel.data!.id.toString());
          prefs.setString(
              "RouteName", dashboardModel.data!.routeMasterName.toString());

          setState(() {
            /*if(dashboardModel.data!.length == 0){

            }else{
              startjourny==true;
            }*/
             isdataavailable=true;
            startjourny == false;
          });

     
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => ApartmentView()));

        }
      } else {
        showDialog(
          barrierColor: Colors.black26,
          context: context,
          barrierDismissible: false,
          builder: (context) {
            return CustomDialogSingle(
              title: "Failed",
              description: response.reasonPhrase.toString(),
            );
          },
        );
      }
    } on SocketException {
      setState(() {
        loading = false;
        showDialog(
            context: context,
            builder: (_) =>const AlertDialog(
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

  Future<void> getstartjournysinglelist() async {
    var headers = {
      "Content-Type": "application/json",
      'Authorization': 'Bearer $sessiontoken',
    };
    var body = {
      "date": AppConstants.cdate,
      "driver_id": int.parse(sessiondriverID),
    };
    setState(() {
      loading = true;
    });
    try {
       final response = await http.post(
          Uri.parse(AppConstants.GETDRIVERASSIGNROUTE),
          headers: headers,
           body: jsonEncode(body),);
     
      setState(() {
        loading = false;
      });
      if (response.statusCode == 200) {
        if (jsonDecode(response.body)['success'].toString() == "false") {
        if (!mounted) return;
        _ackAlert(context, '${jsonDecode(response.body)['message']}');
         
        } else {
          var streetsFromJson = jsonDecode(response.body)['data'];
          if (streetsFromJson.length == 0) {
                setState(() {
                  isdataavailable = false;
                  });
                } else {
            // List<String> streetsList = new List<String>.from(streetsFromJson);
                dashboardModel = DashboardModel.fromJson(jsonDecode(response.body));
                setState(() {
                isdataavailable = true;
            });
          }
        }
      } else {
       if (!mounted) return;
        _ackAlert(context, '${jsonDecode(response.body)['message']}');
        }
    } on SocketException {
      setState(() {
        loading = false;
        showDialog(
            context: context,
            builder: (_) => const AlertDialog(
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

Future _ackAlert(BuildContext context,String message) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title:  Text(message),
        actions: [
          TextButton(
            child: const Text('Ok'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
  Future<void> _getCurrentPosition() async {
    setState(() {
      loading = true;
    });
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    journystart(position.latitude, position.longitude);
  }

  Future<void> journystart(lat, lang) async {
    setState(() {
      loading = true;
    });
    var headers = {
      "Content-Type": "application/json",
      'Authorization': 'Bearer $sessiontoken',
    };

    var body = {
      "journey_date": AppConstants.cdate,
      "rm_id": int.parse(dashboardModel.data!.rmId.toString()),
      "driver_id": int.parse(sessiondriverID),
      "start_apt_id": int.parse(
          dashboardModel.data!.apartment![postionselect].id.toString()),
      "start_lat": lat,
      "start_lon": lang,
      "vehicle_id": int.parse(dashboardModel.data!.vehicleId.toString()),
      "unload_id": 0,
      "waste_id": 0,
      "measurement_id": 0,
    };

    try {
      final response = await http.post(Uri.parse(AppConstants.JOURNYSTART),
          body: jsonEncode(body), headers: headers);
      setState(() {
        loading = false;
      });
      if (response.statusCode == 200) {
        if (jsonDecode(response.body)['success'].toString() == "false") {
          setState(() {
            isdataavailable=false;
          });
          if (!mounted) return;
          showDialog(
            barrierColor: Colors.black26,
            context: context,
            barrierDismissible: false,
            builder: (context) {
              return CustomDialogSingle(
                title: "Failed",
                description: response.body,
              );
            },
          );
        } else {
          if (!mounted) return;
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => ApartmentView()));
        }
      } else {
        if (!mounted) return;
        showDialog(
          context: context,
          barrierColor: Colors.black26,
          barrierDismissible: false,
          builder: (context) {
            return CustomDialogSingle(
              title: "Error",
              description: response.body.toString(),
            );
          },
        );
      }
    } on SocketException {
      setState(() {
        loading = false;
      });
      showDialog(
          context: context,
          builder: (_) => const AlertDialog(
              backgroundColor: Colors.black,
              title: Text(
                "No Response!..",
                style: TextStyle(color: Colors.purple),
              ),
              content: Text(
                "Slow Server Response or Internet connection",
                style: TextStyle(color: Colors.white),
              )));
      throw Exception('Internet is down');
    }
  }
}
