import 'dart:convert';

import 'package:incubatorapp/models/incubator.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;

class IncubatorModel extends Model {
  void readAll() async {
    final data = await http.get(
      'http://192.168.1.8:8000/incubator',
      headers: {
        'content-type': 'application/json',
      },
    );

    List<Incubator> incubatorList = [];
    List<dynamic> incubatorListMap = jsonDecode(data.body);
    incubatorList = incubatorListMap.map((e) => Incubator.fromJson(e)).toList();
    incubatorList.forEach((element) {
      print(element.id);
      print(element.name);
    });
  }

  void create() {}

  void update() {}

  void delete() {}
}
