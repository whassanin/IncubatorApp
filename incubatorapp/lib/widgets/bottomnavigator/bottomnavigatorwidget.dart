import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
class BottomNavigatorWidget extends StatefulWidget {
  BottomNavigatorWidget();
  @override
  _BottomNavigatorWidgetState createState() => _BottomNavigatorWidgetState();
}

class _BottomNavigatorWidgetState extends State<BottomNavigatorWidget> {
  int index = 0;
  BottomNavigationBarItem bottomNavigatorItem(Icon icon,String title){
    return BottomNavigationBarItem(
     icon: icon,
     title: Text(title,softWrap: true,),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: index,
      selectedItemColor: Colors.blueAccent,
      showUnselectedLabels: true,
      unselectedItemColor: Colors.grey,
      onTap: (v) {
        setState(() {
          index = v;
        });
      },
      items: [
        bottomNavigatorItem(Icon(Icons.table_chart),'Status'),
        bottomNavigatorItem(Icon(FontAwesomeIcons.moneyBill),'My Bills'),
        bottomNavigatorItem(Icon(Icons.person_pin),'Account')
      ],
    );
  }
}
