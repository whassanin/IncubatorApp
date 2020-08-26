import 'package:flutter/material.dart';

class ContactUsScreen extends StatelessWidget {
  static const routeName = '/contactusscreen';

  Widget displayText(String t,bool isBold){
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        child: Text(
          t,
          textAlign: TextAlign.justify,
          style: (isBold?TextStyle(fontWeight: FontWeight.bold):null),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    String t1 = 'This app is developed by:';
    String t2 = 'Waleed Abdel-Aziz Ibrahim Mahmoud Hassanin';
    String t3 = 'Master from:';
    String t4 = 'Computer Science at Arab Academy for Science,';
    String t5 = 'Technology and Maritime Transport';
    String t6 = 'Job';
    String t7 = 'Assistant Lecture at MTI University From 2012 till now';
    String t8 = 'Computer and Information Department';
    String t9 = 'Email:';
    String t10 = 'w.hassanin@gmail.com';
    String t11 = 'Phone Numbers:';
    String t12 = '+201019340608';
    String t13 = '+201050095460';

    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          color: Colors.white,
        ),
        title: Text('Contact Us',style: TextStyle(color: Colors.white),),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              displayText(t1,true),
              displayText(t2,false),
              displayText(t3,true),
              displayText(t4,false),
              displayText(t5,false),
              displayText(t6,true),
              displayText(t7,false),
              displayText(t8,false),
              displayText(t9,true),
              displayText(t10,false),
              displayText(t11,true),
              displayText(t12,false),
              displayText(t13,false),
            ],
          ),
        ),
      ),
    );
  }
}
