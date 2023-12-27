

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:decimal/decimal.dart';
import 'WrapperPageState.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }
}

class HomePageState extends WrapperPageState<HomePage> {

  List<TransactionCard> transaktionenList = <TransactionCard>[];
  int gesamtpunke=0;
  bool alleAnzeigen=false;

  void refresh() {
    print("Refresh");
    setState(() {

      List<TransactionCard> oldtransaktionenList = <TransactionCard>[];

      for (int i = 0; i < 7; i++) {
       TransactionCard t= TransactionCard(title: "test", amount: Decimal.parse("11.10"), points: 133);
       gesamtpunke+=t.points;
       oldtransaktionenList.add(t);
      }

     oldtransaktionenList.add(TransactionCard(title: "erste", amount: Decimal.parse("11.10"), points: 1));
     oldtransaktionenList.add(TransactionCard(title: "zweite", amount: Decimal.parse("11.10"), points: 2));
     oldtransaktionenList.add(TransactionCard(title: "dritte", amount: Decimal.parse("11.10"), points: 3));
     oldtransaktionenList.add(TransactionCard(title: "vierte", amount: Decimal.parse("11.10"), points: 4));
      gesamtpunke+=10;

      this.transaktionenList=oldtransaktionenList.reversed.toList(growable: true);

    });
  }

  List<Widget> getTheTransAktionList() {

    if(transaktionenList.isNotEmpty && transaktionenList.length>=3){

      return this.transaktionenList.getRange(0, 3).toList(growable: true);

    }
    else if(transaktionenList.isNotEmpty && transaktionenList.length<3){
      return this.transaktionenList.getRange(0, this.transaktionenList.length).toList(growable: true);
    }
    else{
      List<Widget> keineTransaktionenMeldung = <Widget>[];
      keineTransaktionenMeldung.add(Container(margin:const EdgeInsets.only(
          left: 15, right: 15, top: 20, bottom: 15),
        child: Text("Es wurden noch keine Transaktionen gemacht!",
         textAlign: TextAlign.center,
          style: const TextStyle(
        fontWeight: FontWeight.normal,
        color: Colors.red,
        fontSize: 18,
      ),),
      ));
      return keineTransaktionenMeldung;
    }

  }


  @override
  void initState() {
    super.initState();
    print("Set State");
    refresh();
  }

  @override
  Widget getContent() {

    if(alleAnzeigen==false){
      return SingleChildScrollView(
          child:

          Padding(
            padding: const EdgeInsets.only(bottom: 10),

            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              // crossAxisAlignment:CrossAxisAlignment.start,

              children: [
                Padding(
                  padding: EdgeInsets.all(18.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "test",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 25,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Hallo, Max.',
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                              color: Colors.grey,
                              fontSize: 22,
                            ),
                          ),
                          Column(
                            children: [
                              Text(
                                "Punkte",
                                style: const TextStyle(
                                  fontWeight: FontWeight.normal,
                                  color: Colors.grey,
                                  fontSize: 22,
                                ),
                              ),
                              Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                color: Colors.red,
                                margin: const EdgeInsets.only(
                                    left: 15, right: 15, top: 10, bottom: 5),
                                elevation: 3,
                                child:  Padding(
                                  padding: EdgeInsets.only(
                                      left: 15, right: 15, top: 10, bottom: 10),
                                  child: Text(
                                 gesamtpunke.toString() ,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                      height: 300,
                      child: Container(
                        color: Colors.green,
                        child: null,
                      )),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Transaktionen",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 20,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          print("alle Anzeigen gedrückt!");

                          if(this.transaktionenList.isNotEmpty){

                            setState(() {

                              alleAnzeigen=true;
                            });

                          }
                        },

                        child: Text(
                          "Alle anzeigen",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                    children:getTheTransAktionList()
                ),
              ],
            ),
          ));
    }
    else{

      return SingleChildScrollView(
          child:

          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              // crossAxisAlignment:CrossAxisAlignment.start,

              children: [
                Padding(
                  padding: EdgeInsets.all(18.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Transaktionen",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                           GestureDetector(
                             onTap: () {

                               setState(() {
                                 print("zurück gedrückt!");
                                 alleAnzeigen=false;
                               });

                             },

                             child: Row(
                               children: [

                                 const Padding(
                                   padding:
                                   EdgeInsets.only(left: 0, right: 5, top: 0, bottom: 0),
                                   child: Icon(
                                       color: Colors.black, size: 25, Icons.arrow_back),
                                 ),

                                 Text(
                                  'zurück',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey,
                                    fontSize: 15,
                                  ),
                          ),
                               ],
                             ),
                           ),

                          Column(
                            children: [
                              Text(
                                "Punkte",
                                style: const TextStyle(
                                  fontWeight: FontWeight.normal,
                                  color: Colors.grey,
                                  fontSize: 22,
                                ),
                              ),
                              Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                color: Colors.red,
                                margin: const EdgeInsets.only(
                                    left: 15, right: 15, top: 10, bottom: 5),
                                elevation: 3,
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      left: 15, right: 15, top: 10, bottom: 10),
                                  child: Text(
                                    gesamtpunke.toString(),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ),

                Column(
                    children:this.transaktionenList
                ),

              ],
            ),
          ));

    }

  }
}

class TransactionCard extends StatelessWidget {
  String title;
  Decimal amount;
  int points;

  TransactionCard(
      {required this.title, required this.amount, required this.points});

  @override
  Widget build(BuildContext context) {
    return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        margin: const EdgeInsets.all(5),
        elevation: 3,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          // crossAxisAlignment:CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              // crossAxisAlignment:CrossAxisAlignment.start,

              children: [
                const Padding(
                  padding:
                      EdgeInsets.only(left: 10, right: 15, top: 20, bottom: 20),
                  child: Icon(
                      color: Colors.grey, size: 30, Icons.article_outlined),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 18,
                      ),
                    ),
                    Text(
                       "$amount €",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Card(
              color: Colors.red,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              margin: EdgeInsets.only(left: 10, right: 8, top: 20, bottom: 20),
              elevation: 3,
              child: Padding(
                padding:
                    EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
                child: Text(
                  points.toString(),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
