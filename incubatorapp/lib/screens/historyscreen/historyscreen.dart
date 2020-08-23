import 'package:flutter/material.dart';

class HistoryScreen extends StatelessWidget {
  Widget displayText(String t){
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        child: Text(
          t,
          textAlign: TextAlign.justify,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    String t1 =
        'Incubators has started in year 1931 by a company called Special Care baby Unit (SCBU) in  Britain and was developed in many hospital after second world war.';
    String t2 =
        'This Incubator was successfully combines oxygen, Humidity, ease of accessibility, ease of nursing in one incubator, instruments for monitors the status of baby and handles all cases of baby.';
    String t3 =
        'Incubator Control System is a control system for an intensive care unit for newborn babies who may be premature or suffering from illness, breathing difficulties or other birth complications.';
    String t4 =
        'By creating a closed and controlled environment made by Acrylic Doubled Wall, the incubator protects the newborn from infection, air drafts and handling by nurses and others who may carry bacteria or viruses on their bodies or in their clothing.';
    String t5 =
        'Access to the incubator is restricted to nurses and doctors authorized to work within the neonatal intensive care units (NICU).';

    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          color: Colors.white,
        ),
        title: Text('History',style: TextStyle(color: Colors.white),),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              child: Image.asset(
                'assets/baby-infant-incubator.jpg',
                fit: BoxFit.fill,
              ),
            ),
            displayText(t1),
            displayText(t2),
            displayText(t3),
            displayText(t4),
            displayText(t5),
          ],
        ),
      ),
    );
  }
}
