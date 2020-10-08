import 'package:flutter/material.dart';
import 'package:incubatorapp/widgets/menu/webmenuwidget.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print(MediaQuery.of(context).size.width.toString());
    print(MediaQuery.of(context).size.height.toString());
    double h = MediaQuery.of(context).size.height - 60;
    double w = MediaQuery.of(context).size.width;

    BoxDecoration boxDecoration = BoxDecoration(border: Border.all(width: 1));

    Widget panelWidget = Container(
      decoration: boxDecoration,
      child: WebMenuWidget(),
      height: h,
      width: 300,
    );

    Widget contentWidget = Expanded(
      child: Container(
        decoration: boxDecoration,
        child: Center(
          child: Text(
            'Content',
          ),
        ),
        height: h,
      ),
    );

    Widget frameRowWidget = Expanded(
      child: Container(
        child: Row(
          children: [
            panelWidget,
            contentWidget,
          ],
        ),
      ),
    );

    Widget frameColWidget = Column(
      children: [frameRowWidget],
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Incubator System',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: frameColWidget,
    );
  }
}
