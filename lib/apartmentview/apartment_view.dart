import 'package:flutter/material.dart';
import 'package:unwaste/completejourny/completejourny.dart';

import '../customformbutton.dart';

class ApartmentView extends StatefulWidget {
  const ApartmentView({Key? key}) : super(key: key);

  @override
  State<ApartmentView> createState() => _ApartmentViewState();
}

class _ApartmentViewState extends State<ApartmentView> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(child: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text('Apartmentview',style: TextStyle(color: Colors.black87,fontSize: 16),),
        leading: Icon(Icons.arrow_back,color: Colors.black87,),
      ),
      body: SingleChildScrollView(
        child: Column(
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Add an image widget to display an image
                        Image.asset('assets/images/apartmentview.png',
                          height:200,
                          width: MediaQuery.of(context).size.width,
                          fit: BoxFit.cover,
                        ),
                        // Add some spacing between the image and the text
                        SizedBox(
                          height: 10,
                        ),
                        const Text('TVH Vista Heights',style: TextStyle(fontWeight: FontWeight.bold),),
                        SizedBox(
                          height: 5,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(Icons.navigation,color: Colors.blue,size:14,),
                              Text('Gopala puram,coimbatore'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10,),
            Container(
              width: MediaQuery.of(context).size.width *0.9,
              height: 45,
              child: ElevatedButton.icon(onPressed: (){}, icon: Icon(Icons.location_on,color: Colors.white,),label: Text('Navigate'),style: ElevatedButton.styleFrom(
                  primary: Colors.blueAccent //elevated btton background color
              ),),
            ),
            SizedBox(height: 10,),
            Container(
              width: MediaQuery.of(context).size.width*0.9,
              height: 45,
              child: ElevatedButton.icon(onPressed: (){}, icon: Icon(Icons.qr_code,color: Colors.white,),label: Text('Scan QR'),style: ElevatedButton.styleFrom(
                  primary: Colors.black87 //elevated btton background color
              ),),
            ),
            SizedBox(height: 10,),
            Text('Apartment 1',style: TextStyle(fontSize: 16),),
            SizedBox(
              height: 10,
            ),
            Text('Bin/Bag Count'),
            SizedBox(
              height: 5,
            ),
            Center(
              child: Container(
                width: 100,
                padding: EdgeInsets.all(3),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Theme.of(context).accentColor),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                        onTap: () {},
                        child: Icon(
                          Icons.remove,
                          color: Colors.white,
                          size: 16,
                        )),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 3),
                      padding:
                      EdgeInsets.symmetric(horizontal: 3, vertical: 2),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(3),
                          color: Colors.white),
                      child: Text(
                        '0',
                        style: TextStyle(color: Colors.black, fontSize: 20,fontWeight: FontWeight.normal),
                      ),
                    ),
                    InkWell(
                        onTap: () {},
                        child: Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 16,
                        )),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              //width: size.width * 0.8,
              width: size.width * 0.9,
              decoration: BoxDecoration(
                color: const Color(0xDD000000),
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextButton(
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>const CompleteJournyPage()));
                },
                child: Text('Submit', style: const TextStyle(color: Colors.white, fontSize: 20),),
              ),
            )
          ],
        ),

      ),
    ));
  }
}
