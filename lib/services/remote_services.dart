import 'dart:convert';

import 'package:flutter_application/models/data_model.dart';
import 'package:http/http.dart' as http;

class RemoteService {
  static Future<List<Model>?> getData() async {
    var uri = Uri.parse("https://reqres.in/api/users?page=2");

    final response = await http.get(uri);
    final body = jsonDecode(response.body);
    // print(body);

    List<Model> abc = [];
    for (int i = 0; i < body['data'].length; i++) {
      abc.add(Model(
        id: body['data'][i]['id'],
        mail: body['data'][i]['email'],
        first_name: body['data'][i]['first_name'],
        last_name: body['data'][i]['last_name'],
        avatar: body['data'][i]['avatar'],
      ));
    }
    return abc;
  }
}
