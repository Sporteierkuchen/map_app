import 'dart:math';

import 'package:decimal/decimal.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:geolocator/geolocator.dart';
import 'package:syncfusion_flutter_maps/maps.dart';

class LocationsPage extends StatefulWidget {
  const LocationsPage({super.key});
  @override
  State<StatefulWidget> createState() {
    return LocationsPageState();
  }
}

class LocationsPageState extends State<LocationsPage> {
  Position? _currentPosition;
  String positionsMeldung = "";

  bool standortErmittelt = false;

  bool mapLoaded = false;

  List<_LocationDetails> _orte = <_LocationDetails>[];

  bool karteOhneGesuchteOrte = true;
  bool showAllResults = false;
  bool karteNeu = true;
  List<_LocationDetails> _orteGefunden = <_LocationDetails>[];

  List<_LocationDetails> _orteAnzeigenInListe = <_LocationDetails>[];

  final fieldText = TextEditingController();

  late List<_LocationDetails> _orteAnzeigenAufKarte;


  late PageController _pageViewController;
  late MapTileLayerController _mapController;
  late MapZoomPanBehavior _zoomPanBehavior;
  late double _cardHeight;
  late int _currentSelectedIndex;
  late int _previousSelectedIndex;
  late int _tappedMarkerIndex;
  late bool _canUpdateFocalLatLng;
  late bool _canUpdateZoomLevel;

  late MapController _mapController2;

  @override
  void initState() {
    super.initState();
    print("init state");

    _getCurrentPosition().whenComplete(() =>

        setState(() {
          standortErmittelt=true;
          // Update your UI with the desired changes.
        })

    );

    _currentSelectedIndex = 0;
    _canUpdateFocalLatLng = true;
    _canUpdateZoomLevel = true;
    _mapController = MapTileLayerController();

    _orteAnzeigenAufKarte = <_LocationDetails>[];

    _orte.add(const _LocationDetails(
        continent: 'Europa',
        country: 'Deutschland',
        state: 'Sachsen',
        town: 'Leipzig',
        adress: 'Willy-Brandt-Platz 7 04109 Leipzig',
        name: 'Leipzig HBF',
        description: 'beschreibung',
        imagePath: 'lib/images/leipzig_hbf.jpg',
        latitude: 51.344760,
        longitude: 12.380221));

    _orte.add(const _LocationDetails(
        continent: 'Europa',
        country: 'Deutschland',
        state: 'Sachsen',
        town: 'Leipzig',
        adress: 'Str. des 18. Oktober 100, 04299 Leipzig',
        name: 'Völkerschlachtdenkmal in Leipzig.',
        description:
            'beschreibung uzgd d d d kd kdv dkv.y v cdx dkv dyk vdkvdl vlyd v vdlkjdk vdl vldvykv cvx vd lvdvl vd vd ll  vd lvdl vl ',
        imagePath: 'lib/images/Völkerschlachtdenkmal.jpg',
        latitude: 51.312367,
        longitude: 12.413267));
    print("icfbcb");
    _orte.add(const _LocationDetails(
        continent: 'Europa',
        country: 'Deutschland',
        state: 'Sachsen',
        town: 'Leipzig',
        adress: 'Markranstädter Str. 8A, 04229 Leipzig',
        name: 'Jump House in Leipzig.',
        description: 'jump house',
        imagePath: 'lib/images/jumphouse.jpg',
        latitude: 51.32607730986849,
        longitude: 12.329589807395056));
    print("ifgfhgfe");
    _orte.add(const _LocationDetails(
        continent: 'Europa',
        country: 'Deutschland',
        state: 'Thüringen',
        town: 'Greiz',
        adress: 'Poststraße 12, 07973 Greiz',
        name: 'Greiz Bahnhof',
        description: 'gleich haben wir den salat',
        imagePath: 'lib/images/greizbahnhof.jpg',
        latitude: 50.65675405746982,
        longitude: 12.194118651798352));

    _zoomPanBehavior = MapZoomPanBehavior(
      minZoomLevel: 4,
      maxZoomLevel: 15,
      //  focalLatLng: MapLatLng(51, 12.5),
      //       focalLatLng: MapLatLng(_orteAnzeigenAufKarte[_currentSelectedIndex].latitude,
      //        _orteAnzeigenAufKarte[_currentSelectedIndex].longitude),
      enableDoubleTapZooming: true,
      enableMouseWheelZooming: true,
    );

  }

  @override
  void dispose() {
    print("Disposed");
    _pageViewController.dispose();
    _mapController.dispose();
    _orte.clear();
    super.dispose();
  }




  @override
  Widget build(BuildContext context) {

    if (standortErmittelt == true) {
      print("build");


      if (karteNeu) {
        print("Karte neu...currentselectedindex=0");
        _currentSelectedIndex = 0;
        karteNeu = false;
      }



      if (mapLoaded == false) {
        print("Map wird neu geladen!");


        _mapController.clearMarkers();
        if(karteOhneGesuchteOrte){
          print("Es wird die Karte ohne gesuchte Orte geladen!");

          _orteAnzeigenAufKarte.clear();
          if (isLocationavailable()) {
            _orteAnzeigenAufKarte.add(_LocationDetails(
                continent: "",
                country: "",
                state: "",
                town: "testtown",
                adress: "testadress",
                name: "username",
                description: "",
                imagePath: 'lib/images/profilbild.jpg',
                latitude: _currentPosition!.latitude,
                longitude: _currentPosition!.longitude));
            _orteAnzeigenAufKarte.add(getkleinsteEntfernung());
            _currentSelectedIndex = 1;

          } else {
            _orteAnzeigenAufKarte.add(_orte[0]);
          }

        }
        else{
          // print("Es wird die Karte mit gesuchten Orten geladen!");
          //
          // if (isLocationavailable()) {
          //   _orteAnzeigenAufKarte.removeLast();
          // } else {
          //   _orteAnzeigenAufKarte.clear();
          // }
          //
          // for (_LocationDetails l in _orteAnzeigenInListe) {
          //   _orteAnzeigenAufKarte.add(l);
          // }

        }

        for (var i = 0; i < _orteAnzeigenAufKarte.length; i++) {

          _mapController.insertMarker(i);

        }

        mapLoaded = true;
      }


      _pageViewController = PageController(
          keepPage: false,
          initialPage: _currentSelectedIndex,
          viewportFraction: //0.8,

          (MediaQuery.of(context).orientation == Orientation.landscape)
              ? 0.8
              : 0.8
      );

      if (_canUpdateZoomLevel) {
        _zoomPanBehavior.zoomLevel = 10;
        _canUpdateZoomLevel = false;
      }

      _cardHeight = (MediaQuery.of(context).orientation == Orientation.landscape)
          ? MediaQuery.of(context).size.height * 0.27
          : MediaQuery.of(context).size.height * 0.19;


      return SafeArea(
        child: SingleChildScrollView(
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              (MediaQuery.of(context).orientation == Orientation.portrait)
                  ? Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(
                        top: 25, left: 18, right: 18, bottom: 5),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          "Standorte",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 25,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(
                        top: 0, left: 18, right: 18, bottom: 10),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          'Hallo, Max.',
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            color: Colors.grey,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                    EdgeInsets.only(left: 18, right: 18, bottom: 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        getSuchfeld(),
                      ],
                    ),
                  ),
                ],
              )
                  : Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 15, left: 18, right: 18, bottom: 5),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Standorte",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 25,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: 0, right: 50, bottom: 0),
                          child: getSuchfeld(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Stack(alignment: AlignmentDirectional.topCenter, children: test()),
            ],
          ),
        ),
      );


    }
    else{

      return SafeArea(

          child:

          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                Expanded(
                  child: Container(
                    // width: ,
                    color: Colors.red,
                  ),
                ),

              ],
            ),
          ),
      );

    }

  }




  List<Widget> test() {
    List<Widget> widgets = <Widget>[];

    widgets.add(Column(
      children: [
        SizedBox(
          height: (MediaQuery.of(context).orientation == Orientation.landscape)
              ? 5
              : 15,
        ),
        SizedBox(
          height: (MediaQuery.of(context).orientation == Orientation.landscape)
              ? MediaQuery.of(context).size.height * 0.58
              : MediaQuery.of(context).size.height * 0.65,
          child: Stack(
            alignment: AlignmentDirectional.topCenter,
            children: <Widget>[

              Positioned.fill(
                child: Image.asset(
                  'lib/images/maps_grid.png',
                  repeat: ImageRepeat.repeat,
                ),
              ),
              SfMaps(
                layers: <MapLayer>[
                  // getLayer(),

                  MapTileLayer(
                    /// URL to request the tiles from the providers.
                    ///
                    /// The [urlTemplate] accepts the URL in WMTS format i.e. {z} —
                    /// zoom level, {x} and {y} — tile coordinates.
                    ///
                    /// We will replace the {z}, {x}, {y} internally based on the
                    /// current center point and the zoom level.

                    urlTemplate:
                    'https://tile.openstreetmap.org/{z}/{x}/{y}.png',

                    zoomPanBehavior: _zoomPanBehavior,
                    initialZoomLevel: 10,
                    initialFocalLatLng: MapLatLng(
                        _orteAnzeigenAufKarte[_currentSelectedIndex].latitude,
                        _orteAnzeigenAufKarte[_currentSelectedIndex].longitude),
                    controller: _mapController,
                    initialMarkersCount: _orteAnzeigenAufKarte.length,
                    tooltipSettings: const MapTooltipSettings(
                      color: Colors.transparent,
                    ),

                    markerBuilder: (BuildContext context, int index) {
                      final double markerSize =
                      _currentSelectedIndex == index ? 40 : 25;
                      return MapMarker(
                        latitude: _orteAnzeigenAufKarte[index].latitude,
                        longitude: _orteAnzeigenAufKarte[index].longitude,
                        alignment: Alignment.bottomCenter,
                        child: GestureDetector(
                          onTap: () {
                            if (_currentSelectedIndex != index) {
                              print("auf anderen Marker geklickt");
                              _canUpdateFocalLatLng = false;
                              _tappedMarkerIndex = index;
                              _pageViewController.animateToPage(
                                index,
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.easeInOut,
                              );
                            } else {
                              print("auf ausgewählten Marker geklickt");
                            }

                            _zoomPanBehavior.focalLatLng = MapLatLng(
                                _orteAnzeigenAufKarte[index].latitude,
                                _orteAnzeigenAufKarte[index].longitude);
                            _zoomPanBehavior.zoomLevel = 13;
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 250),
                            height: markerSize,
                            width: markerSize,
                            child: FittedBox(
                              child: getMarkerIcon(markerSize, index),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  color: Colors.transparent,
                  height: _cardHeight,
                  padding: const EdgeInsets.only(bottom: 10),

                  /// PageView which shows the world wonder details at the bottom.
                  child: PageView.builder(
                    itemCount: _orteAnzeigenAufKarte.length,
                    onPageChanged: _handlePageChange,
                    controller:   _pageViewController ,
                    itemBuilder: (BuildContext context, int index) {

                      // int a=_orteAnzeigenAufKarte.length;
                      // print("itemcount: $a");

                      //   _pageViewController.jumpToPage(_currentSelectedIndex);
                      final _LocationDetails item =
                      _orteAnzeigenAufKarte[index];
                      return Transform.scale(
                        scale: index == _currentSelectedIndex ? 1 : 0.85,
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: const BorderRadius.all(
                                Radius.elliptical(10, 10)),
                            onTap: () {
                              if (_currentSelectedIndex != index) {
                                print("auf andere Infokarte geklickt!");
                                _pageViewController.animateToPage(
                                  index,
                                  duration: const Duration(milliseconds: 500),
                                  curve: Curves.easeInOut,
                                );
                              } else {
                                print("auf ausgewählte Infokarte geklickt!");
                              }
                              _zoomPanBehavior.focalLatLng = MapLatLng(
                                  _orteAnzeigenAufKarte[_currentSelectedIndex]
                                      .latitude,
                                  _orteAnzeigenAufKarte[_currentSelectedIndex]
                                      .longitude);
                              _zoomPanBehavior.zoomLevel = 10;
                            },
                            child: Container(
                              padding: const EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                color: Colors.greenAccent,
                                border: Border.all(
                                  color: const Color.fromRGBO(153, 153, 153, 1),
                                  width: 0.5,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(children: <Widget>[
                                // Adding title and description for card.
                                Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 0.0, right: 5.0),
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(item.name,
                                              softWrap: true,
                                              maxLines: 2,
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 12),
                                              textAlign: TextAlign.start),
                                          Text(
                                              "(${item.town}, ${item.state}, ${item.country})",
                                              // maxLines: 1,
                                              softWrap: true,
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.grey,
                                                  fontSize: 10),
                                              textAlign: TextAlign.start),
                                          const SizedBox(height: 3),
                                          Text(item.adress,
                                              softWrap: true,
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.grey,
                                                  fontSize: 10),
                                              textAlign: TextAlign.start),
                                          const SizedBox(height: 3),
                                          Expanded(
                                              child: Container(
                                                // color: Colors.red,
                                                child: SingleChildScrollView(
                                                  padding: const EdgeInsets.only(
                                                      top: 2.0, bottom: 2.0),
                                                  child: Text(
                                                    softWrap: true,
                                                    item.description,
                                                    style: TextStyle(fontSize: 10),
                                                  ),
                                                ),
                                              ))
                                        ],
                                      ),
                                    )),
                                // Adding Image for card.
                                ClipRRect(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(4)),
                                  child: Image.asset(
                                    item.imagePath,
                                    height: _cardHeight - 10,
                                    width: _cardHeight - 10,
                                    fit: BoxFit.fill,
                                  ),
                                )
                              ]),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            getPositionsmeldung(),

            ],
          ),
        ),
      ],
    ));

    if (karteOhneGesuchteOrte) {

      if (this.fieldText.value.text.trim().isEmpty) {
        print("Suchfeld leer!");
        this.fieldText.clear();
      } else {
        print("Suchfeld gefüllt!");
        getItemsListe();

        widgets.add(SizedBox(
             width: MediaQuery.of(context).size.width * 0.8,
             child: Card(
               color: Colors.white,
               shape: RoundedRectangleBorder(
                 side: BorderSide(color: Colors.black, width: 1.0),
                 borderRadius: BorderRadius.circular(10.0),
               ),
               margin: EdgeInsets.only(left: 0, right: 0, top: 0, bottom: 20),
               elevation: 3,
               child: Padding(
                 padding: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 0),
                 child: Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     getPositionsmeldung(),
                     const Padding(
                       padding: EdgeInsets.only(bottom: 2),
                       child: Text(
                         "RESULTS",
                         style: TextStyle(
                           fontWeight: FontWeight.w900,
                           color: Colors.black,
                           fontSize: 16,
                         ),
                       ),
                     ),
                     _orteAnzeigenInListe.isEmpty
                         ? const Padding(
                             padding: EdgeInsets.only(bottom: 5),
                             child: Text("Nichts gefunden!"),
                           )
                         : ListView.builder(
                             shrinkWrap: true,
                             physics: const NeverScrollableScrollPhysics(),
                             itemCount: _orteAnzeigenInListe.length,
                             itemBuilder: (context, index) {
                               return GestureDetector(
                                 onTap: () {
                                   print("Ausgewählter Ort: ${_orteAnzeigenInListe[index].name}");

                                   setState(() {

                                   if( isLocationavailable()  ){
                                     _currentSelectedIndex = index+1;
                                     print("klickindexcur: $_currentSelectedIndex");
                                   }
                                   else{
                                     _currentSelectedIndex = index;
                                     print("klickindexcur: $_currentSelectedIndex");
                                   }

                                   // mapLoaded=false;
                                   //   karteOhneGesuchteOrte = false;

                                   //  karteNeu=true;
                                   });
                                 },
                                 child: Container(
                                     //color: Colors.blue,
                                     margin:
                                         const EdgeInsets.only(top: 5, bottom: 5),
                                     child: Row(
                                       mainAxisAlignment:
                                           MainAxisAlignment.spaceBetween,
                                       crossAxisAlignment:
                                           CrossAxisAlignment.start,
                                       children: [
                                         Container(
                                           //color: Colors.blue,
                                           margin: const EdgeInsets.only(
                                               left: 0,
                                               right: 10,
                                               top: 0,
                                               bottom: 0),
                                           child: Container(
                                             padding: const EdgeInsets.only(
                                                 left: 10,
                                                 right: 10,
                                                 top: 10,
                                                 bottom: 10),
                                             decoration: BoxDecoration(
                                               borderRadius:
                                                   BorderRadius.circular(10),
                                               color: Colors.red,
                                             ),
                                             child: Text(
                                               getEntfernung(index) + " km",
                                               style: const TextStyle(
                                                 fontWeight: FontWeight.bold,
                                                 color: Colors.white,
                                                 fontSize: 13,
                                               ),
                                             ),
                                           ),
                                         ),
                                         Expanded(
                                           child: Column(
                                             crossAxisAlignment:
                                                 CrossAxisAlignment.start,
                                             children: [
                                               Text(
                                                 _orteAnzeigenInListe[index].name,
                                                 softWrap: true,
                                                 style: const TextStyle(
                                                   fontWeight: FontWeight.bold,
                                                   color: Colors.black,
                                                   fontSize: 16,
                                                 ),
                                               ),
                                               Text(
                                                 "(${_orteAnzeigenInListe[index]
                                                         .town}, ${_orteAnzeigenInListe[index]
                                                         .state}, ${_orteAnzeigenInListe[index]
                                                         .country})",
                                                 softWrap: true,
                                                 style: const TextStyle(
                                                   fontWeight: FontWeight.bold,
                                                   color: Colors.grey,
                                                   fontSize: 14,
                                                 ),
                                               ),
                                               const SizedBox(
                                                 height: 5,
                                               ),
                                               Text(
                                                 _orteAnzeigenInListe[index]
                                                     .adress,
                                                 softWrap: true,
                                                 style: const TextStyle(
                                                   fontWeight: FontWeight.normal,
                                                   color: Colors.grey,
                                                   fontSize: 14,
                                                 ),
                                               ),
                                             ],
                                           ),
                                         ),
                                       ],
                                     )),
                               );
                             }),
                     getAllResultsContainer(),
                     const SizedBox(height: 10),
                   ],
                 ),
               ),
             ),
           ));
      }
    }

    return widgets;
  }

  void _handlePageChange(int index) {
    /// While updating the page viewer through interaction, selected position's
    /// marker should be moved to the center of the maps. However, when the
    /// marker is directly clicked, only the respective card should be moved to
    /// center and the marker itself should not move to the center of the maps.
    ///
    ///
    print("page change!");
    if (!_canUpdateFocalLatLng) {
      if (_tappedMarkerIndex == index) {
        _updateSelectedCard(index);
      }
    } else if (_canUpdateFocalLatLng) {
      _updateSelectedCard(index);
    }
  }

  void _updateSelectedCard(int index) {
    print("update selected card!");
    setState(() {
      _previousSelectedIndex = _currentSelectedIndex;
      _currentSelectedIndex = index;
    });

    /// While updating the page viewer through interaction, selected position's
    /// marker should be moved to the center of the maps. However, when the
    /// marker is directly clicked, only the respective card should be moved to
    /// center and the marker itself should not move to the center of the maps.
    if (_canUpdateFocalLatLng) {
      _zoomPanBehavior.focalLatLng = MapLatLng(
          _orteAnzeigenAufKarte[_currentSelectedIndex].latitude,
          _orteAnzeigenAufKarte[_currentSelectedIndex].longitude);
      _zoomPanBehavior.zoomLevel = 10;
    }

    /// Updating the design of the selected marker. Please check the
    /// `markerBuilder` section in the build method to know how this is done.
    _mapController
        .updateMarkers(<int>[_currentSelectedIndex, _previousSelectedIndex]);
    _canUpdateFocalLatLng = true;
  }

  Widget getSuchfeld() {
    return SizedBox(
      height: (MediaQuery.of(context).orientation == Orientation.portrait)
          ? 50
          : 40,
      width: (MediaQuery.of(context).orientation == Orientation.portrait)
          ? MediaQuery.of(context).size.width * 0.8
          : MediaQuery.of(context).size.width * 0.6,
      child: TextField(
        controller: fieldText,
        style: TextStyle(
            color: Colors.black, fontSize: 18, decorationThickness: 0.0),
        textAlignVertical: TextAlignVertical.center,
        maxLength: 25,
        textInputAction: TextInputAction.search,
        onChanged: (value) {
          //starteSuche(value);
        },
        onSubmitted: (value) {
          // await _getCurrentPosition();
          starteSuche(value);
        },
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(),
          filled: true,
          fillColor: Colors.white,
          counterText: "",
          focusedBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(18.0)),
            borderSide: BorderSide(color: Colors.black, width: 2.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(18.0)),
            borderSide: BorderSide(color: Colors.black, width: 2.0),
          ),
          prefixIcon: GestureDetector(
            onTap: () {
              //await _getCurrentPosition();
              starteSuche(fieldText.text);
            },
            child: Icon(
              Icons.search_outlined,
              color: Colors.black,
              size: 25,
            ),
          ),
          suffixIcon: GestureDetector(
              onTap: () {
                print("Suchfeld gecleart!");
                //await _getCurrentPosition();
                setState(() {
                  karteOhneGesuchteOrte = true;
                  showAllResults = false;
                  karteNeu = true;
                  mapLoaded=false;
                  fieldText.clear();
                  _orteGefunden.clear();
                });
              },
              child: Icon(
                Icons.close_outlined,
                color: Colors.black,
                size: 20,
              )),
          hintText: 'Suche...',
        ),
      ),
    );
  }

  void starteSuche(String value) {
    print("Ortssuche gestartet! Value: $value");

    if (value.trim().isNotEmpty) {
       _orteGefunden.clear();

      for (_LocationDetails d in this._orte) {
        if (d.continent.toLowerCase().contains(value.toLowerCase().trim()) ||
            d.country.toLowerCase().contains(value.toLowerCase().trim()) ||
            d.state.toLowerCase().contains(value.toLowerCase().trim()) ||
            d.town.toLowerCase().contains(value.toLowerCase().trim()) ||
            d.adress.toLowerCase().contains(value.toLowerCase().trim()) ||
            d.name.toLowerCase().contains(value.toLowerCase().trim())) {
          print("Beschreibung " + d.name);

          _orteGefunden.add(d);
        }
      }
    }

    setState(() {
      karteOhneGesuchteOrte = true;
      showAllResults = false;
      karteNeu = true;
      mapLoaded=false;

    });
  }

  void getItemsListe() {
   _orteAnzeigenInListe.clear();
    if ((this.showAllResults) ||
        (this.showAllResults == false && _orteGefunden.length <= 3)) {
      for (_LocationDetails ort in _orteGefunden) {
        _orteAnzeigenInListe.add(ort);
      }
    } else {
      for (var i = 0; i < 3; i++) {
        _orteAnzeigenInListe.add(_orteGefunden.elementAt(i));
      }
    }
  }

  Widget getAllResultsContainer() {
    if (this.showAllResults == false && _orteGefunden.length > 3) {
      return GestureDetector(
        onTap: () {
          print("Show all Locations!");
          setState(() {
            this.showAllResults = true;
          });
        },
        child: Container(
          // width: 280,
          margin: const EdgeInsets.only(left: 0, right: 0, top: 15, bottom: 10),
          child: Container(
            alignment: Alignment.center,
            padding:
                const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.grey,
            ),
            child: Text(
              "All Results",
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 18,
              ),
            ),
          ),
        ),
      );
    } else {
      return Container();
    }
  }

  Future<void> _getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();
    print("permission fertig!");
    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high,forceAndroidLocationManager: true ,timeLimit: const Duration(seconds: 1))
        .then((Position position) {

      _currentPosition = position;
      print("positionsermittlung fertig");

    }).catchError((e) {
      print("Zeitüberschreitung bei der Positionsbestimmung!");
      //debugPrint(e);

      positionsMeldung =
      'Ihr Standort konnte nicht bestimmt werden...!';

    });
  }

  Future<bool> _handleLocationPermission() async {
    positionsMeldung = "";
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      positionsMeldung =
          'Location services are disabled. Please enable the services';
      print("Meldung: $positionsMeldung");

      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission()
          .onError((error, stackTrace) => LocationPermission.unableToDetermine);
      if (permission == LocationPermission.denied) {
        positionsMeldung = 'Location permissions are denied';
        print("Meldung: $positionsMeldung");
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      positionsMeldung =
          'Location permissions are permanently denied, we cannot request permissions.';
      print("Meldung: $positionsMeldung");

      return false;
    }

    if (positionsMeldung.isEmpty) {
      print('Positionsbestimmung hat funktioniert!');
    }
    return true;
  }

  Widget getPositionsmeldung() {
    if (positionsMeldung.isNotEmpty) {
      return Padding(
        padding: const EdgeInsets.only(top: 5, bottom: 5),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 0, right: 5, top: 0, bottom: 10),
              child: Icon(color: Colors.blue, size: 30, Icons.info_outlined),
            ),
            Expanded(
              child: Text(
                positionsMeldung,
                softWrap: true,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      );
    } else {
      return Container();
    }
  }

  String getEntfernung (int index) {
    double lat1 = _currentPosition?.latitude ?? 0;
    double lon1 = _currentPosition?.longitude ?? 0;

    double lat2 = _orteAnzeigenInListe[index].latitude;
    double lon2 = _orteAnzeigenInListe[index].longitude;

    double dx = 71.5 * (lon1 - lon2);
    double dy = 111.3 * (lat1 - lat2);

    double distance = sqrt(dx * dx + dy * dy);

    bool a = positionsMeldung.isEmpty;
    print("Meldung empty?: $a ");

    return positionsMeldung.isEmpty ? roundDouble(distance, 2).toString() : "?";
  }

  double berechneEntfernung(int index) {
    double lat1 = _currentPosition?.latitude ?? 0;
    double lon1 = _currentPosition?.longitude ?? 0;

    double lat2 = _orte[index].latitude;
    double lon2 = _orte[index].longitude;

    double dx = 71.5 * (lon1 - lon2);
    double dy = 111.3 * (lat1 - lat2);

    double distance = sqrt(dx * dx + dy * dy);

    return distance;
  }

  double roundDouble(double value, int places) {
    num mod = pow(10.0, places);
    return ((value * mod).round().toDouble() / mod);
  }

  bool isLocationavailable() {
    if (_currentPosition != null) {
      return true;
    } else {
      return false;
    }
  }

  _LocationDetails getkleinsteEntfernung() {
    double kleinsteentfernung = 0;
    _LocationDetails d = _LocationDetails(
        continent: "",
        country: "",
        state: "",
        town: "",
        adress: "",
        name: "",
        description: "",
        imagePath: "",
        latitude: 0,
        longitude: 0);

    for (var i = 0; i < _orte.length; i++) {
      double entfernung = berechneEntfernung(i);
      if (i == 0) {
        kleinsteentfernung = entfernung;
        d = _orte[i];
      } else {
        if (entfernung < kleinsteentfernung) {
          kleinsteentfernung = entfernung;
          d = _orte[i];
        }
      }
    }
    return d;
  }

  Widget getMarkerIcon(double markersize, index) {
    if (isLocationavailable() && index == 0) {
      return Icon(Icons.person,
          color: Colors.deepOrangeAccent,
          size: markersize);
    } else {
      return Icon(Icons.location_on,
          color: _currentSelectedIndex == index ? Colors.blue : Colors.red,
          size: markersize);
    }
  }
}

class _LocationDetails {
  const _LocationDetails({
    required this.continent,
    required this.country,
    required this.state,
    required this.town,
    required this.adress,
    required this.name,
    required this.description,
    required this.imagePath,
    required this.latitude,
    required this.longitude,
  });

  final String continent;
  final String country;
  final String state;
  final String town;
  final String adress;
  final String name;
  final String description;

  final String imagePath;
  final double latitude;
  final double longitude;
}
