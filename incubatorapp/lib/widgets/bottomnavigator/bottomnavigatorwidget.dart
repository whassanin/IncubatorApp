import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:incubatorapp/main.dart';
class BottomNavigatorWidget extends StatefulWidget {
  BottomNavigatorWidget();
  @override
  _BottomNavigatorWidgetState createState() => _BottomNavigatorWidgetState();
}

class _BottomNavigatorWidgetState extends State<BottomNavigatorWidget> {
  BottomNavigationBarItem bottomNavigatorItem(Icon icon,String title){
    return BottomNavigationBarItem(
     icon: icon,
     title: Text(title,softWrap: true,),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: patientModel.currentTab,
      selectedItemColor: Colors.blueAccent,
      showUnselectedLabels: true,
      unselectedItemColor: Colors.grey,
      onTap: (v) {
        patientModel.setCurrentTab(v);
      },
      items: [
        bottomNavigatorItem(Icon(Icons.table_chart),'Status'),
        bottomNavigatorItem(Icon(FontAwesomeIcons.moneyBill),'My Bills'),
        bottomNavigatorItem(Icon(Icons.person_pin),'Account')
      ],
    );
  }
}
