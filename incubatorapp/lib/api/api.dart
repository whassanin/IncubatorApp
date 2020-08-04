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

  Future<Map<String, dynamic>> getById(String docId) async {
    final data = await http.get(
      _url + '/' + docId,
      headers: {
        'content-type': 'application/json',
      },
    );

    Map<String, dynamic> listMap = jsonDecode(data.body);

    return listMap;
  }

  Future<List<dynamic>> filter(String columnId) async {
    final data = await http.get(
      _url + '/' + columnId,
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

  Future<int> postSubValue(
      Map<String, dynamic> jsonBody, String mainDocId) async {
    final data = await http.post(
      _url + '/' + mainDocId,
      headers: {
        'content-type': 'application/json',
      },
      body: jsonEncode(jsonBody),
    );
    return data.statusCode;
  }

  Future<int> put(Map<String, dynamic> jsonBody, String columnId) async {
    final data = await http.put(
      _url + '/' + columnId,
      headers: {
        'content-type': 'application/json',
      },
      body: jsonEncode(jsonBody),
    );
    return data.statusCode;
  }

  Future<int> putSubValue(
      Map<String, dynamic> jsonBody, String columnId) async {
    final data = await http.put(
      _url + '/edit/' + columnId,
      headers: {
        'content-type': 'application/json',
      },
      body: jsonEncode(jsonBody),
    );
    return data.statusCode;
  }

  Future<int> delete(String valueId) async {
    final data = await http.delete(
      _url + '/' + valueId,
      headers: {
        'content-type': 'application/json',
      },
    );
    return data.statusCode;
  }

  Future<int> deleteSubValue(String valueId) async {
    final data = await http.delete(
      _url + '/edit/' + valueId,
      headers: {
        'content-type': 'application/json',
      },
    );
    return data.statusCode;
  }
}
