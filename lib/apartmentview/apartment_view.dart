import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unwaste/CustomSingleDialog.dart';
import 'package:unwaste/apartmentview/apartment_model.dart';
import 'package:unwaste/completejourny/completejourny.dart';
import 'package:unwaste/dashboard/RouteModel.dart';
import 'package:unwaste/login/login_page.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart'as http;
import '../appcolors.dart';
import '../appconstants/appconstants.dart';
import '../customformbutton.dart';
import '../dashboard/start_journymodel.dart';
import 'PostLocation.dart';

class ApartmentView extends StatefulWidget {
   ApartmentView({Key? key,/*required this.routeModel,required this.routeposition*/}) : super(key: key,);


  @override
  State<ApartmentView> createState() => _ApartmentViewState();
}

class _ApartmentViewState extends State<ApartmentView> {
  Uint8List bytes = Uint8List(0);
  late TextEditingController _outputController;
  int qty=0;
  String sessionmobile="";
  String sessiontoken="";
  String sessiondriverID="";
  String sessionid="";
  String sessionname="";
  String sessionrouteid="";
  String sessionwastageid="";
  String sessionassignid="";
  String sessionvehicleID="";
  bool loading=false;
  ApartmentModel model=ApartmentModel();
  int totalapartmentcount=0;
  int currentapartmentcount=0;
  String buttonname="";
  int?nodata=0;
  bool qtycon =false;
  Timer? _timer;
  late String cdatetime;
  @override
  initState() {
    super.initState();
    _outputController = TextEditingController();
    getStringValuesSF();

   _timer = Timer.periodic(const Duration(seconds: 30), (Timer t) {
      //_update();
     PostLocationState().getCurrentPosition();
    });
  }
  // void _update() {
  //   setState(() {
  //      cdatetime = DateFormat("yyyy-MM-dd HH:mm:ss").format(DateTime.now());
  //   });
  // }
  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {

   Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text('Apartment View',style: TextStyle(color: Colors.black87,fontSize: 18),),
        leading: InkWell(
          onTap: (){
            //Navigator.pop(context);
          },
            child: const Icon(Icons.arrow_back,color: Colors.black87,)),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: InkWell(
              onTap: (){
                getlist();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                 Icon(Icons.refresh,color: Colors.black,)
                ],
              ),
            ),
          )
        ],
      ),
      body: !loading? SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 16,right: 16,top: 10),
          child: model.data![0].apartment!=null?
          Column(
            children: [
              Card(
                // Define the shape of the card
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
                // Define how the card's content should be clipped
                clipBehavior: Clip.antiAliasWithSaveLayer,
                // Define the child widget of the card
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:[
                    // Add padding around the row widget
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child:model.data![0].apartment!.isNotEmpty?
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Add an image widget to display an image
                          Image.asset('assets/images/apartmentview1.png',
                            height:200,
                            width: MediaQuery.of(context).size.width,
                            fit: BoxFit.cover,
                          ),
                          // Add some spacing between the image and the text
                          const SizedBox(
                            height: 10,
                          ),
                          //debugPrint()
                          Text(model.data![0].apartment![currentapartmentcount].name ?? "-" ,style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 14),),
                          const SizedBox(
                            height: 5,
                          ),
                         /* Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Image.asset('assets/images/iconnavigate.png',color: AppColors.kdashblue,height: 18,width: 18,),
                                SizedBox(width: 5,),
                                Text('${model.data![0].apartment![0].area.toString()=="null"?"-":model.data![0].apartment![0].area.toString()},${model.data![0].apartment![0].address.toString()=="null"?"-":model.data![0].apartment![0].address.toString()}',style: TextStyle(fontSize: 10),),
                              ],
                            ),
                          ),*/
                        ],
                      ):const Center(child: Text('No Apartments Found!')),
                    ),
                  ],
                )//:Center(child: Text('No data'),),
              ),
              const SizedBox(height: 10,),
              Container(
                width: MediaQuery.of(context).size.width * 0.9,
                height: 45,
                child: ElevatedButton.icon(onPressed: ()=> openMapsSheet(context), icon: Icon(Icons.location_on,color: Colors.white,),label: Text('Navigate'),style: ElevatedButton.styleFrom(
                    primary: Colors.blueAccent //elevated btton background color
                ),),
              ),
              const SizedBox(height: 10,),
              model.data![0].apartment!.isNotEmpty?Container(
                width: MediaQuery.of(context).size.width * 0.9,
                height: 45,
                child: ElevatedButton.icon(onPressed: () {
                    scan();
                    }, icon: const Icon(Icons.qr_code,color: Colors.white,),label: Text('Scan QR'),style: ElevatedButton.styleFrom(
                    primary: Colors.black87 //elevated btton background color
                ),),
              ):Container(),
              SizedBox(height: 10,),
              model.data![0].apartment!.isNotEmpty?
              Text(model.data![0].apartment![currentapartmentcount].name.toString().isEmpty?"-":model.data![0].apartment![currentapartmentcount].name.toString(),style: TextStyle(fontSize: 16),):Text(''),
              const SizedBox(
                height: 10,
              ),
              const Text('Bin/Bag Count'),
              const SizedBox(
                height: 15,
              ),
              Center(
                child:Visibility(
                  visible:qtycon,
                  child: Container(
                    padding: EdgeInsets.all(8),
                    width: 150,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        border: Border.all(color: Colors.black)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                          onTap: (){
                            decrement();
                          },
                          child: const Icon(
                            Icons.remove,
                            size: 30,
                            color:  Colors.black,
                          ),
                        ),
                        Text(
                          qty.toString(),
                          style: const TextStyle(
                            fontSize: 30,
                            color:  Colors.black
                          ),
                        ),
                        InkWell(
                          onTap: (){
                            increment();
                          },
                          child: const Icon(
                            Icons.add,
                            size: 30,
                            color:  Colors.black
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              !loading?Container(
                //width: size.width * 0.8,
                width: size.width * 0.9,
                decoration: BoxDecoration(
                  color: const Color(0xDD000000),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextButton(
                  onPressed: (){
                    if(qty==0){
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please Enter Qty..')),);
                    }else {
                      submitwastage();
                    }
                  },
                  child: const Text('Submit', style:  TextStyle(color: Colors.white, fontSize: 20),),
                )
              ):const Center(child: CircularProgressIndicator(),),
            ],
          ):Container(alignment: Alignment.bottomCenter,child: const Center(child: Text('Apartments not Available!'))),
        )

      ):const Center(child: CircularProgressIndicator(),),
    ));
  }


  void increment(){
    setState(() {
      if(qty>=1000){
        return;
      }
      qty=qty+1;
    });
  }
  void decrement(){
    setState(() {
      if(qty<1){
        return;
      }
      qty=qty-1;
    });
  }
  Future scan() async {
    print('inside');
    await Permission.camera.request();
    String ? barcode = await scanner.scan();
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    if (barcode == null) {
      print('nothing return.');
      setState(() {
        qtycon=false;
      });
      showDialog(
        barrierColor: Colors.black26,
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return CustomDialogSingle(
            title: "Invalid Barcode",
            description: _outputController.text,
          );
        },
      );
    } else {
      _outputController.text="";
      this._outputController.text = barcode;

      try{

        var _distanceInMeters = await Geolocator.distanceBetween(
          double.parse(model.data![0].apartment![currentapartmentcount].lat.toString()),
          double.parse(model.data![0].apartment![currentapartmentcount].lng.toString()),
          position.latitude,
          position.longitude,
        );
        if(_distanceInMeters>100){
          showDialog(
              context: context,
              builder: (_) => AlertDialog(
                content: Text('Distance Between  100 Meters only!'),
              )
          );
        }else{
          setState(() {
            if(barcode.toString()== model.data![0].apartment![currentapartmentcount].qrCode.toString()){
            print('BARCODE ${barcode}');
            qtycon=true;
          }else{
            qtycon=false;
            showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  content: Text('Invalid QR Code'),
                )
            );
          }
        });
        }
      }catch(e){
        print(e.toString());
      }

    }
  }

  Future getStringValuesSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    sessiondriverID = prefs.getString('DriverID').toString();
    sessiontoken = prefs.getString('Token').toString();
    sessionmobile = prefs.getString('Phone').toString();
    sessionname = prefs.getString('Name').toString();
    sessionrouteid = prefs.getString('RouteId').toString();
    sessionwastageid = prefs.getString('WastageID').toString();
    sessionassignid= prefs.getString('RouteassignID').toString();
    sessionvehicleID= prefs.getString('VehicleId').toString();
    print(sessiontoken);

    getlist();
    setState(() {

    });
  }

  Future<void> getlist() async {
    setState(() {
      loading = true;
    });
    try {
      
    var headers = {"Content-Type": "application/json",'Authorization': 'Bearer $sessiontoken'};
    var body = {
      "date":AppConstants.cdate,
      "route_id":int.parse(sessionrouteid),
      "driver_id":int.parse(sessiondriverID),
      "route_assign_id":int.parse(sessionassignid),
    };

      print(jsonEncode(body));

      final response = await http.post(
          Uri.parse(AppConstants.APARTMENTLIST),
          body: jsonEncode(body),
          headers: headers);
     // print(jsonEncode(body));
     // print(headers);
      setState(() {
        loading = false;
      });
      if (response.statusCode == 200) {
        if (jsonDecode(response.body)['success'].toString() == "false") {
          //model.data![0].apartment==0;
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
          model=ApartmentModel.fromJson(jsonDecode(response.body));
          totalapartmentcount=int.parse(model.data![0].totalApartmentCount.toString());
          currentapartmentcount=int.parse(model.data![0].wastageLogAddedApartmentCount.toString());
          print('PRINT${model.data![0].apartment!}');

          if(totalapartmentcount==currentapartmentcount){
            print('COUNT COMPLETE${totalapartmentcount-currentapartmentcount}');
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>
                CompleteJournyPage()));
          }

        }
      } else {
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
        // logoutfunction(context);
      }
    } on Exception catch (e) {
      setState(() {
        loading = false;
          showDialog(
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
      });
      throw Exception('Internet is down');
    }
  }

  Future<void> submitwastage() async {
    cdatetime = DateFormat("yyyy-MM-dd HH:mm:ss").format(DateTime.now());
    var headers = {"Content-Type": "application/json",'Authorization': 'Bearer $sessiontoken'};
    var body = {
      "vehicle_id":sessionvehicleID,
      "driver_id":sessiondriverID,
      "apt_id":model.data![0].apartment![currentapartmentcount].id.toString(),
      "rm_id":sessionrouteid,
      "waste_id":"1",
      "waste_count":qty,
      "date":AppConstants.cdate,
      "status":0,
      "remarks":"",
      "route_assign_id":int.parse(sessionassignid),
      "measurement_id":0,
      "pickup_at":cdatetime,
      "photo":'',
    };

    print(jsonEncode(body));
    setState(() {
      loading = true;
    });
    try {
      final response = await http.post(
          Uri.parse(AppConstants.WASTAGELOGCREATE),
          body: jsonEncode(body),
          headers: headers);
      print(jsonEncode(body));
      print(headers);
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
                description: '${jsonDecode(response.body)['message'].toString()}',
              );
            },
          );
        } else {
          /*SnackBar(
            behavior: SnackBarBehavior.floating,
            margin: EdgeInsets.only(top: 100.0),
            content: Text('${jsonDecode(response.body)['message'].toString()}'),
          );*/
          showDialog<void>(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                content: Text('${jsonDecode(response.body)['message'].toString()}'),
                actions: <Widget>[
                  TextButton(
                    style: TextButton.styleFrom(
                      textStyle: Theme.of(context).textTheme.labelLarge,
                    ),
                    child: const Text('Ok'),
                    onPressed: () {
                     Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>ApartmentView()));
                    },
                  ),
                ],
              );
            },
          );
          //setState(() {});
        }
      } else {
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
       // logoutfunction(context);
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

  openMapsSheet(context) async {
    try {
      final coords = Coords(double.parse(model.data![0].apartment![currentapartmentcount].lat.toString().toString()), double.parse(model.data![0].apartment![currentapartmentcount].lng.toString().toString()));
      final title = model.data![0].apartment![currentapartmentcount].name.toString().toString();
      final availableMaps = await MapLauncher.installedMaps;
      showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return SafeArea(
            child: SingleChildScrollView(
              child: Container(
                child: Wrap(
                  children: <Widget>[
                    for (var map in availableMaps)
                      ListTile(
                        onTap: () => map.showMarker(
                          coords: coords,
                          title: title,
                        ),
                        title: Text(map.mapName),
                        /*leading: SvgPicture.asset(
                          map.icon,
                          height: 30.0,
                          width: 30.0,
                        ),*/
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    } catch (e) {
      print(e);
    }
  }
  logoutfunction(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.setBool("LoggedIn", false);
      prefs.clear();
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => LoginPage(),),(route) => false,
      );
    });
  }
}
