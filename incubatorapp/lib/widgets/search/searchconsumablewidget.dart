import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:incubatorapp/main.dart';

class SearchConsumableWidget extends StatefulWidget {
  @override
  _SearchConsumableWidgetState createState() => _SearchConsumableWidgetState();
}

class _SearchConsumableWidgetState extends State<SearchConsumableWidget> {
  TextEditingController searchTEC = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    Widget searchTextField = Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        height: 70,
        child: Row(
          children: <Widget>[
            Expanded(
              child: TextFormField(
                controller: searchTEC,
                decoration: InputDecoration(labelText: 'Search here...'),
                onFieldSubmitted: (v) {},
                onChanged: (v) {
                  consumableModel.search(v);
                },
              ),
            )
          ],
        ),
      ),
    );

    Widget searchButton = Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.cyan,
                borderRadius: BorderRadius.all(
                  Radius.circular(
                    10.0,
                  ),
                ),
              ),
              height: 70,
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(
                      10.0,
                    ),
                  ),
                ),
                child: Text(
                  'Search',
                  style: TextStyle(color: Colors.white),
                ),
                color: Colors.cyan,
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          )
        ],
      ),
    );

    return Column(
      children: <Widget>[
        searchTextField,
        searchButton,
      ],
    );
  }
}
