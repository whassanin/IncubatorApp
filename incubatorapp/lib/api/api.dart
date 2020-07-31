import 'dart:convert';

import 'package:http/http.dart' as http;

class Api {
  String name;
  String _url = 'http://192.168.1.8:8000';

  Api(this.name) {
    _url += '/' + this.name;
  }

  Future<List<dynamic>> get() async {
    final data = await http.get(
      _url,
      headers: {
        'content-type': 'application/json',
      },
    );

    List<dynamic> listMap = jsonDecode(data.body);

    return listMap;
  }

  Future<int> post(Map<String, dynamic> jsonBody) async {
    final data = await http.post(
      _url + '/',
      headers: {
        'content-type': 'application/json',
      },
      body: jsonEncode(jsonBody),
    );
    return data.statusCode;
  }

  Future<int> put(Map<String, dynamic> jsonBody,String columnId) async {
    final data = await http.put(
      _url + '/'+columnId,
      headers: {
        'content-type': 'application/json',
      },
      body: jsonEncode(jsonBody),
    );
    return data.statusCode;
  }

}
