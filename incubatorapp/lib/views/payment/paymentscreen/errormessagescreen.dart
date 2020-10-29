import 'package:flutter/material.dart';
import 'package:incubatorapp/main.dart';

class ErrorMessageScreen extends StatelessWidget {
  static const routeName = '/errormessagescreen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.red,
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.cancel,
                size: 150,
                color: Colors.white,
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  'Payment Error!',
                  style: TextStyle(fontSize: 30, color: Colors.white),
                ),
              ),
              GestureDetector(
                child: Container(
                  height: 50,
                  width: 150,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(
                        10.0,
                      ),
                    ),
                  ),
                  child: Center(child: Text('Back')),
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
