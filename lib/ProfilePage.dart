import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class ProfilePage extends StatefulWidget{
  const ProfilePage({super.key});
  @override
  State<StatefulWidget> createState() {
    return ProfilePageState();
  }

}

class ProfilePageState extends State<ProfilePage>{
  @override
  Widget build(BuildContext context) {
    return


       // Container(color: Colors.green);



      SafeArea(
        child: SingleChildScrollView(
          child: Stack(
            children:[
              // The containers in the background
              Column(
                children:[

               Container(
                   height: MediaQuery.of(context).size.height * .40,
                 width: MediaQuery.of(context).size.width,
                 padding: EdgeInsets.only(
                     left: 100, right: 100, top: 10, bottom: 40),
                    color: Colors.red[200],
                 child:

                    Container(
                      padding: EdgeInsets.all(7),
                      decoration: BoxDecoration(color: Colors.white,shape: BoxShape.circle),
                      child: const CircleAvatar(
                       backgroundImage: AssetImage('lib/images/profilbild.jpg'),
                   ),
                    ),

                  ),
                  // Container(
                  //   height: MediaQuery.of(context).size.height * .50,
                  //   color: Colors.brown[100]
                  // )

                ],
              ),

              // The card widget with top padding,
              // incase if you wanted bottom padding to work,
              // set the `alignment` of container to Alignment.bottomCenter
              Container(
               // color: Colors.brown,
                alignment: Alignment.topCenter,
                padding:  EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * .35,
                    right: 5.0,
                    left: 5.0),
                child:  Container(
                  width: MediaQuery.of(context).size.width,
                  child:
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    color: Colors.pink[900],
                    margin: const EdgeInsets.only(
                        left: 0, right: 0, top: 0, bottom: 10),
                    elevation: 3,
                    child:


                    Padding(
                      padding: const EdgeInsets.only(left: 20,right: 20,top: 20,bottom: 5),
                      child: Column(


                        children: [

                          Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),),
                             margin: const EdgeInsets.only(bottom: 15),
                              elevation: 3,
                              child:

                              Padding(
                                padding: const EdgeInsets.only(left: 25,right: 10,top: 20,bottom: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  // crossAxisAlignment:CrossAxisAlignment.start,
                                  children: [

                                    const Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment:CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Persönliche Daten',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                            fontSize: 18,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 12,
                                        ),

                                        Text(
                                          'Herr',
                                          style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 15,
                                          ),
                                        ),

                                        const SizedBox(
                                          height:5,
                                        ),

                                        Text(
                                          'Max Mustermann',
                                          style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 15,
                                          ),
                                        ),

                                        const SizedBox(
                                          height: 5,
                                        ),

                                        Text(
                                          'Musterstraße 123',
                                          style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 15,
                                          ),
                                        ),

                                        const SizedBox(
                                          height: 10,
                                        ),

                                        Text(
                                          '00000 Musterstadt',
                                          style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 15,
                                          ),
                                        ),

                                      ],),



                                    const Padding(
                                      padding: EdgeInsets.only(left: 10,right: 15,top: 20,bottom: 20),
                                      child:
                                      Icon(
                                          color: Colors.grey,
                                          size: 30,
                                          Icons.info_outlined),
                                    ),


                                  ],),
                              )
                          ),

                          Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),),
                              margin: const EdgeInsets.only(bottom: 15),
                              elevation: 3,
                              child:

                              Padding(
                                padding: const EdgeInsets.only(left: 25,right: 10,top: 20,bottom: 25),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  // crossAxisAlignment:CrossAxisAlignment.start,
                                  children: [

                                    const Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment:CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'E-Mail-Adresse',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                            fontSize: 18,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 12,
                                        ),

                                        Text(
                                          'MaxMustermann@muster.de',
                                          style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 15,
                                          ),
                                        ),


                                      ],),



                                    const Padding(
                                      padding: EdgeInsets.only(left: 10,right: 15,top: 20,bottom: 20),
                                      child:
                                      Icon(
                                          color: Colors.grey,
                                          size: 30,
                                          Icons.info_outlined),
                                    ),


                                  ],),
                              )
                          ),

                          Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),),
                              margin: const EdgeInsets.only(bottom: 15),
                              elevation: 3,
                              child:

                              Padding(
                                padding: const EdgeInsets.only(left: 25,right: 10,top: 20,bottom: 25),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  // crossAxisAlignment:CrossAxisAlignment.start,
                                  children: [

                                    const Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment:CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Passwort',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                            fontSize: 18,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 12,
                                        ),

                                        Text(
                                          '*************************',
                                          style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 15,
                                          ),
                                        ),


                                      ],),



                                    const Padding(
                                      padding: EdgeInsets.only(left: 10,right: 15,top: 20,bottom: 20),
                                      child:
                                      Icon(
                                          color: Colors.grey,
                                          size: 30,
                                          Icons.info_outlined),
                                    ),


                                  ],),
                              )
                          ),


                        ],
                      ),
                    ),




                  ),
                ),
              )
            ],
          ),
        ),
      );

    //Overlay.of(context).insert(stackOverlay);


      //Container();
  }
}