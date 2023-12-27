

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'ActionsPage.dart';
import 'HomePage.dart';
import 'LocationsPage.dart';
import 'ProfilePage.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _currentIndex = 0;

  final List<Widget> _screens = const [
    HomePage(),
    LocationsPage(),
    ActionsPage(),
    ProfilePage(),
  ];

  List<BottomNavigationBarItem> getItems() {
    return [
   getStartIcon(_currentIndex == 0),
      getLocationsIcon(_currentIndex == 1),
      getActionsIcon(_currentIndex == 2),
      getProfileIcon(_currentIndex == 3),
    ];
  }

  Widget? main;

  @override
  Widget build(BuildContext context) {
    main = Scaffold(
      body: _screens.elementAt(_currentIndex),
      bottomNavigationBar:

      SizedBox(
        height: (MediaQuery.of(context).orientation == Orientation.landscape)
        ?
        MediaQuery.of(context).size.height * 0.16
        :
        MediaQuery.of(context).size.height * 0.09,

        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          items: getItems(),
          showSelectedLabels: true,
          showUnselectedLabels: true,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Color(0xFFFFFFFF),
          selectedItemColor: Color(0xFF7B1A33),
          unselectedItemColor:Color(0xFFCAB69E),
         // iconSize: 30,
          onTap: (value) {
            setState(() {
              _currentIndex = value;
            });
          },
        ),
      ),
    );

    if (main == null) {
      return Container();
    } else {
      return main!;
    }
  }

   BottomNavigationBarItem getStartIcon(bool selected){
     return BottomNavigationBarItem(
       icon: Container(
         child:


         const Icon(
           Icons.home,
           color: Colors.black,
           size: (MediaQuery.of(context).orientation == Orientation.landscape) ? MediaQuery.of(context).size.height * 0.06 : MediaQuery.of(context).size.height * 0.04,
         ),


       ),
       label: "Home",
     );
   }

  BottomNavigationBarItem getLocationsIcon(bool selected){
    return BottomNavigationBarItem(
      icon: Container(
          child:

          const Icon(
            Icons.map,
            color: Colors.black,
            size: (MediaQuery.of(context).orientation == Orientation.landscape) ? MediaQuery.of(context).size.height * 0.06 : MediaQuery.of(context).size.height * 0.04,
          ),


      ),
      label: "Standorte",
    );
  }

  BottomNavigationBarItem getActionsIcon(bool selected){
    return BottomNavigationBarItem(
      icon: Container(
          child:

          const Icon(
            Icons.add_call,
            color: Colors.black,
            size: (MediaQuery.of(context).orientation == Orientation.landscape) ? MediaQuery.of(context).size.height * 0.06 : MediaQuery.of(context).size.height * 0.04,
          ),

      ),
      label: "Aktionen",
    );
  }


  BottomNavigationBarItem getProfileIcon(bool selected){
    return BottomNavigationBarItem(
      icon: Container(
          child:

          const Icon(
            Icons.person,
            color: Colors.black,
            size: (MediaQuery.of(context).orientation == Orientation.landscape) ? MediaQuery.of(context).size.height * 0.06 : MediaQuery.of(context).size.height * 0.04,
          ),

      ),
      label: "Profil",
    );
  }
}
