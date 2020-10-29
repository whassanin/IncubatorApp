import 'package:flutter/material.dart';

class LiveScreen extends StatelessWidget {
  static const routeName = '/livescreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Live Screen',style: TextStyle(color: Colors.white),),
        leading: BackButton(
          color: Colors.white,
        ),
      ),
      body: Center(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Text(
                'This live will be open starting from 6:00 PM to 8:00 PM',softWrap: true,),
          ),
        ),
      ),
    );
  }
}
