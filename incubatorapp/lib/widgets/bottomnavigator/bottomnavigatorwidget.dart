import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:incubatorapp/main.dart';
import 'package:incubatorapp/models/userpermission.dart';
class BottomNavigatorWidget extends StatefulWidget {
  final UserPermission userPermission;
  BottomNavigatorWidget(this.userPermission);
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


  Widget doctorBottomNavigatorBar(){
    return BottomNavigationBar(
      currentIndex: doctorModel.currentTab,
      selectedItemColor: Colors.blueAccent,
      showUnselectedLabels: true,
      unselectedItemColor: Colors.grey,
      onTap: (v) {
        doctorModel.setCurrentTab(v);
      },
      items: [
        bottomNavigatorItem(Icon(FontAwesomeIcons.hospitalUser),'Patients'),
        bottomNavigatorItem(Icon(FontAwesomeIcons.list),'Shift'),
        bottomNavigatorItem(Icon(Icons.person_pin),'Account')
      ],
    );
  }

  Widget nurseBottomNavigatorBar(){
    return BottomNavigationBar(
      currentIndex: nurseModel.currentTab,
      selectedItemColor: Colors.blueAccent,
      showUnselectedLabels: true,
      unselectedItemColor: Colors.grey,
      onTap: (v) {
        nurseModel.setCurrentTab(v);
      },
      items: [
        bottomNavigatorItem(Icon(FontAwesomeIcons.hospitalUser),'Patients'),
        bottomNavigatorItem(Icon(FontAwesomeIcons.list),'Shift'),
        bottomNavigatorItem(Icon(Icons.person_pin),'Account')
      ],
    );
  }

  Widget patientBottomNavigatorBar(){
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

  @override
  Widget build(BuildContext context) {

    Widget currentWidget;

    if(widget.userPermission.isPatient){
      currentWidget = patientBottomNavigatorBar();
    }else if(widget.userPermission.isDoctor){
      currentWidget = doctorBottomNavigatorBar();
    }else if(widget.userPermission.isNurse){
      currentWidget = nurseBottomNavigatorBar();
    }else {
      currentWidget = Container();
    }

    return currentWidget;
  }
}
