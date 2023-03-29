import 'package:flutter/material.dart';
import 'package:unwaste/apartmentview/apartment_view.dart';
import 'package:unwaste/profileview.dart';

class Dashboardpage extends StatefulWidget {
  const Dashboardpage({Key? key}) : super(key: key);

  @override
  State<Dashboardpage> createState() => _DashboardpageState();
}

class _DashboardpageState extends State<Dashboardpage> {
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
          }, child: Image.asset('assets/images/avatarmale.png',height: 40,width: 40,))
        ],
      ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
             Text('Hello,Welcome',style: TextStyle(fontSize: 12,color: Colors.black54),),
             SizedBox(height: 5,),
             Text('Karthikeyan',style: TextStyle(fontWeight: FontWeight.bold),),
             SizedBox(height: 5,),
             Row(
                mainAxisAlignment: MainAxisAlignment.start,

              children: [
                Container(
                  margin: const EdgeInsets.all(5.0),
                  padding: const EdgeInsets.symmetric(horizontal: 5.0,vertical: 2.0),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                      borderRadius:BorderRadius.all(Radius.circular(5)),
                      border: Border.all(color: Colors.blueAccent),
                  ),
                  child: Text('DriverID:03342',style: TextStyle(fontSize: 12),),
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
                    border: Border.all(color: Colors.brown),
                  ),
                  child: Text('Date:12.02.2023',style: TextStyle(fontSize: 12),),
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
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.builder(
                        itemCount: 5,
                        itemBuilder: (BuildContext context, int index) {
                          return Card(
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
                                      child: Text('VTS Vista height',),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 5),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Icon(Icons.navigation,color: Colors.blue,size:14,),
                                          Text('Gopala puram,coimbatore',style: TextStyle(fontSize: 10,color: Colors.black54),),
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
                                          Icon(Icons.delete_outline_outlined,color: Colors.red,size:20,),
                                          Text('Bin/Bag-',style: TextStyle(fontSize: 12,color: Colors.black54),),
                                          Text('8',style: TextStyle(fontSize: 14,color: Colors.black87,fontWeight: FontWeight.bold),),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),flex: 8,),
                              ],
                            ),
                          );
                        }),
                  ),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: ElevatedButton(style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    side: BorderSide(color: Colors.blue)
                )
            )
        ),
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>ApartmentView()));
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
    );
  }
}
