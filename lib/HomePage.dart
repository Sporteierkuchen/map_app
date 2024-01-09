import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

import 'CustomerDto.dart';
import 'FormatUtil.dart';
import 'PersistenceUtil.dart';
import 'RegistrationPage.dart';
import 'WrapperPageState.dart';
import 'package:decimal/decimal.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }
}

class HomePageState extends WrapperPageState<HomePage> {
  List<TransactionCard> transaktionenList = <TransactionCard>[];
  int gesamtpunke = 0;
  bool alleAnzeigen = false;
  final srollcontroller = ScrollController();
  final int showMaxTransactionCards = 3;
  int pagecounter = 0;

  bool loadedData = false;
  late CustomerDto? customerDTo;

  @override
  void initState() {
    super.initState();
    print("Set State");

    loadData().whenComplete(() => setState(() {

      // srollcontroller.addListener(() async {
      //
      //   if (srollcontroller.position.maxScrollExtent ==
      //       srollcontroller.offset &&
      //       alleAnzeigen) {
      //     print("Ende erreicht!");
      //     print("Pagecounter: ${pagecounter}");
      //
      //     await loadTransactions(pagecounter, showMaxTransactionCards)
      //         .then((value) => setState(() {
      //       if (value != null) {
      //         print("Elemente: ${value.length}");
      //
      //         for (TransactionDto t in value) {
      //           transaktionenList.add(TransactionCard(
      //               title: FlavorSettings.getFlavorSettings().style!.getTransaktionVom()+
      //                   FormatUtil.formatDateTime(t.creationTime),
      //               amount: t.amount,
      //               points: t.amount.toBigInt().toInt(),
      //               filiale: t.storeName != null ? t.storeName! : FlavorSettings.getFlavorSettings().style!.getUnbekannt()));
      //         }
      //
      //         if (value.length == showMaxTransactionCards) {
      //           pagecounter++;
      //         } else if (value.isEmpty) {
      //           ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      //             content:
      //
      //             Row(
      //               mainAxisAlignment: MainAxisAlignment.center,
      //               mainAxisSize: MainAxisSize.max,
      //               children: [
      //                 const Padding(
      //                   padding: EdgeInsets.only(left: 0, right: 5, top: 0, bottom: 0),
      //                   child: Icon(color: Colors.blue, size: 30, Icons.info_outlined),
      //                 ),
      //                 Expanded(
      //                   child: Text(FlavorSettings.getFlavorSettings().style!.getTransaktionsMeldung()+
      //                       "${transaktionenList.length}",
      //                     softWrap: true,
      //                     style: const TextStyle(
      //                       height: 0,
      //                       fontWeight: FontWeight.bold,
      //                       color: Colors.blue,
      //                       fontSize: 16,
      //                     ),
      //                   ),
      //                 ),
      //               ],
      //             ),
      //
      //           ));
      //         } else {
      //           pagecounter++;
      //         }
      //       }
      //     }));
      //   }
      // });

      loadedData = true;
    }));
  }

  @override
  dispose() {
    print("Disposed");
    super.dispose();
    srollcontroller.dispose();
  }

  @override
  Widget getContent() {
    if (loadedData) {
      return SingleChildScrollView(
        controller: srollcontroller,
        child: getWidgets(),
      );
    } else {
      return Container();
    }
  }

  Widget getWidgets() {
    if (alleAnzeigen == false) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          // crossAxisAlignment:CrossAxisAlignment.start,

          children: [
            Padding(
              padding:
              EdgeInsets.only(left: 18, right: 18, top: 18, bottom: 25),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Kundenkarte",
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
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: Text(
                            customerDTo!=null && customerDTo?.firstName!=null && customerDTo!.firstName!.trim().isNotEmpty ?
                            'Hallo, ${customerDTo?.firstName}'
                                : "Hallo, Unbekannter",
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                              color: Colors.grey,
                              fontSize: 22,
                            ),
                          ),
                        ),
                      ),
                      Column(
                        children: [
                          Text(
                            "Punktestand:",
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
                            color: Color(0xFF7B1A33),
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
            QrImageView(
              data: "www.google.de",
              size: MediaQuery.of(context).size.width * 0.5,
              padding: EdgeInsets.all(0),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Letzte Transaktionen",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 20,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      print("alle Anzeigen gedrückt!");

                      if (this.transaktionenList.isNotEmpty) {
                        setState(() {
                          srollcontroller.jumpTo(0);
                          alleAnzeigen = true;
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
            Column(children: getTheTransAktionList()),
          ],
        ),
      );
    } else {
      return Container(
        constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height -
                MediaQuery.of(context).viewPadding.top -
                MediaQuery.of(context).size.height * 0.09),
        // color: Colors.green,

        child: Padding(
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
                      "Letzte Transaktionen",
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
                              srollcontroller.jumpTo(0);
                              alleAnzeigen = false;
                            });
                          },
                          child: Row(
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(
                                    left: 0, right: 5, top: 0, bottom: 0),
                                child: Icon(
                                    color: Colors.black,
                                    size: 25,
                                    Icons.arrow_back),
                              ),
                              Text(
                                "Zurück",
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
                              "Punktestand:",
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
                              color: Color(0xFF7B1A33),
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
              Column(children: this.transaktionenList),
            ],
          ),
        ),
      );
    }
  }

  List<Widget> getTheTransAktionList() {
    if (transaktionenList.isNotEmpty &&
        transaktionenList.length >= showMaxTransactionCards) {
      return this
          .transaktionenList
          .getRange(0, showMaxTransactionCards)
          .toList(growable: true);
    } else if (transaktionenList.isNotEmpty &&
        transaktionenList.length < showMaxTransactionCards) {
      return this
          .transaktionenList
          .getRange(0, this.transaktionenList.length)
          .toList(growable: true);
    } else {
      List<Widget> keineTransaktionenMeldung = <Widget>[];
      keineTransaktionenMeldung.add(Container(
        margin: const EdgeInsets.only(left: 15, right: 15, top: 20, bottom: 15),
        child: Text(
          "Es wurden noch keine Transaktionen gemacht!",
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontWeight: FontWeight.normal,
            color: Colors.red,
            fontSize: 18,
          ),
        ),
      ));
      return keineTransaktionenMeldung;
    }
  }

  Future<void> loadData() async {
    await PersistenceUtil.getCustomer().then((value) => setState(() {
      customerDTo = value;
    }));

    // for (var i = 0; i < 1; i++) {

    // List<TransactionDto>? value =
    // await loadTransactions(pagecounter, showMaxTransactionCards);
    // setState(() {
    //   if (value != null) {
    //     print("Pagecounter: ${pagecounter}");
    //     print("Elemente: ${value.length}");
    //
    //     for (TransactionDto t in value) {
    //       transaktionenList.add(TransactionCard(
    //           title: FlavorSettings.getFlavorSettings().style!.getTransaktionVom()+
    //               FormatUtil.formatDateTime(t.creationTime),
    //           amount: t.amount,
    //           points: t.amount.toBigInt().toInt(),
    //           filiale: t.storeName != null ? t.storeName! : FlavorSettings.getFlavorSettings().style!.getUnbekannt()));
    //     }
    //
    //     if (value.length == showMaxTransactionCards) {
    //       pagecounter++;
    //     } else if (value.isEmpty) {
    //       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    //         content:
    //
    //         Row(
    //           mainAxisAlignment: MainAxisAlignment.center,
    //           mainAxisSize: MainAxisSize.max,
    //           children: [
    //             const Padding(
    //               padding: EdgeInsets.only(left: 0, right: 5, top: 0, bottom: 0),
    //               child: Icon(color: Colors.blue, size: 30, Icons.info_outlined),
    //             ),
    //             Expanded(
    //               child: Text(FlavorSettings.getFlavorSettings().style!.getTransaktionsMeldung()+
    //                   "${transaktionenList.length}",
    //                 softWrap: true,
    //                 style: const TextStyle(
    //                   height: 0,
    //                   fontWeight: FontWeight.bold,
    //                   color: Colors.blue,
    //                   fontSize: 16,
    //                 ),
    //               ),
    //             ),
    //           ],
    //         ),
    //       ));
    //     } else {
    //       pagecounter++;
    //     }
    //   }
    // });

    // }
  }

  // Future<List<TransactionDto>?> loadTransactions(int page, int pageSize) async {
  //   LiveApiRequest<TransactionDto> liveApiRequest =
  //   LiveApiRequest<TransactionDto>(
  //       path: "/customer/transactions/page/" +
  //           page.toString() +
  //           "/" +
  //           pageSize.toString());
  //   ApiResponse apiResponse = await liveApiRequest.executeGet();
  //   if (apiResponse.status == Status.SUCCESS) {
  //     List<TransactionDto> transactions = [];
  //     List<TransactionDto>.from(jsonDecode(apiResponse.body!)
  //         .map((model) => TransactionDto.fromJson(model))).forEach((element) {
  //       transactions.add(element);
  //     });
  //
  //     return transactions;
  //   } else if (apiResponse.status == Status.EXCEPTION) {
  //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //       duration: Duration(seconds: 2),
  //       content:
  //       Row(
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         // mainAxisSize: MainAxisSize.max,
  //         crossAxisAlignment: CrossAxisAlignment.center,
  //         children: [
  //           const Padding(
  //             padding: EdgeInsets.only(left: 0, right: 5, top: 0, bottom: 0),
  //             child: Icon(color: Colors.orange, size: 30, Icons.warning_outlined),
  //           ),
  //           Expanded(
  //             child:
  //
  //             Align(
  //               alignment: Alignment.centerLeft,
  //               child: Text("Exception!",
  //                 textAlign: TextAlign.center,
  //                 softWrap: true,
  //                 style: const TextStyle(
  //                   height: 0,
  //                   fontWeight: FontWeight.bold,
  //                   color: Colors.orange,
  //                   fontSize: 16,
  //                 ),
  //               ),
  //             ),
  //           ),
  //         ],
  //       ),
  //
  //     ));
  //   } else if (apiResponse.status == Status.ERROR) {
  //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //       duration: Duration(seconds: 2),
  //       content:
  //       Row(
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         mainAxisSize: MainAxisSize.max,
  //         crossAxisAlignment: CrossAxisAlignment.center,
  //         children: [
  //           const Padding(
  //             padding: EdgeInsets.only(left: 0, right: 5, top: 0, bottom: 0),
  //             child: Icon(color: Colors.red, size: 30, Icons.error_outline_outlined),
  //           ),
  //           Expanded(
  //             child:
  //
  //             Align(
  //               alignment: Alignment.centerLeft,
  //               child: Text("Error!",
  //                 textAlign: TextAlign.center,
  //                 softWrap: true,
  //                 style: const TextStyle(
  //                   height: 0,
  //                   fontWeight: FontWeight.bold,
  //                   color: Colors.red,
  //                   fontSize: 16,
  //                 ),
  //               ),
  //             ),
  //           ),
  //         ],
  //       ),
  //
  //     ));
  //   }
  //   return null;
  // }
}

class TransactionCard extends StatelessWidget {
  String filiale;
  String title;
  Decimal amount;
  int points;

  TransactionCard(
      {required this.title,
        required this.amount,
        required this.points,
        required this.filiale});

  @override
  Widget build(BuildContext context) {
    return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        margin: const EdgeInsets.all(5),
        elevation: 3,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            const Padding(
              padding:
              EdgeInsets.only(left: 10, right: 15, top: 20, bottom: 20),
              child: Icon(color: Colors.grey, size: 30, Icons.article_outlined),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      filiale,
                      style: TextStyle(
                        height: 0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      title,
                      style: TextStyle(
                        height: 0,
                        color: Colors.grey,
                        fontSize: 15,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      FormatUtil.formatCurrency(amount) + "€",
                      style: TextStyle(
                        height: 0,
                        color: Colors.grey,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Card(
              color: Color(0xFF7B1A33),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              margin: EdgeInsets.only(left: 10, right: 8, top: 20, bottom: 20),
              elevation: 3,
              child: Padding(
                padding:
                EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
                child: Text(
                  FormatUtil.forceSign(points),
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



// @override
// String getStartPageTitle() {
//   return "Kundenkarte";
// }
//
// @override
// String getAlleAnzeigenString() {
//   return "Alle anzeigen";
//
// }
//
// @override
// String getPunkteString() {
//   return "Punktestand:";
// }
//
// @override
// String getTransaktionenString() {
//   return "Letzte Transaktionen";
// }
//
// @override
// String getStandortMeldung1() {
//   return "Ihr Standort konnte nicht bestimmt werden...!";
// }
//
// @override
// String getStandortMeldung2() {
//   return 'Der Standort ist deaktiviert... Bitte Aktivieren sie die Dienste!';
// }
//
// @override
// String getStandortMeldung3() {
//   return 'Standortberechtigungen wurden verweigert!';
// }
//
// @override
// String getStandortMeldung4() {
//   return 'Standortberechtigungen wurden dauerhaft verweigert, es kann nicht nach Berechtigungen gefragt werden.';
// }
//
// @override
// String getAlleErgebnisse() {
//   return "Alle Ergebnisse";
// }
//
// @override
// String getSuche() {
//   return 'Suche...';
// }
//
// @override
// String getNichtsGefunden() {
//   return "Nichts gefunden!";
// }
//
// @override
// String getErgebnisse() {
//   return "ERGEBNISSE";
// }
//
// @override
// String getStandortMeldung5() {
//   return 'Ihr Standort wird ermittelt...';
// }
//
// @override
// String getStandorte() {
//   return "Standorte";
// }
//
// @override
// String getKeineOrte() {
//   // TODO: implement getKeineOrte
//   return "Es konnten keine Orte geladen werden!";
// }
//
// @override
// String getUUID() {
//   return "e23b776c-e3b4-4e8e-be72-b91767fcfc24";
// }
//
// @override
// String getTransaktionsMeldung() {
//   return "Es wurden alle Transaktionen geladen! Anzahl Transaktionen: ";
// }
//
// @override
// String getTransaktionVom() {
//   // TODO: implement getTransaktionVom
//   return "Transaktion vom ";
// }
//
// @override
// String getUnbekannt() {
//   // TODO: implement getUnbekannt
//   return "Unbekannt";
// }
//
// @override
// String getKeineTransaktionen() {
//   // TODO: implement getKeineTransaktionen
//   return "Es wurden noch keine Transaktionen gemacht!";
// }
//
// @override
// String getZurueck() {
//   // TODO: implement getZurück
//   return "Zurück";
// }
//
// @override
// String getDatenAktualisiert() {
//   // TODO: implement getDatenAktualisiert
//   return "Daten wurden erfolgreich aktualisiert!";
//
// }
//
// @override
// String getDatenNichtAktualisiert() {
//   // TODO: implement getDatenNichtAktualisiert
//   return "Daten konnten nicht aktualisiert werden!";
// }