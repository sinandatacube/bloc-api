import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:simple_bloc_api/model/login_model.dart';
import 'package:simple_bloc_api/utils/utils.dart';

class HomeRepository {
  static Future fetchDataFromApi() async {
    try {
      final Response response = await http.get(
        Uri.parse(
            'https://employee-management-usz2.onrender.com/empl/get_notification'),
        headers: {"Content-Type": "application/json", 'Charset': 'utf-8'},
      );

      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        print(result);
        return result['message'];
      } else {
        return "Response Error";
      }
    } catch (e) {
      log(e.toString());
      return e.toString();
    }
  }

  static Future authentication(
      {required String psw, required String id, required String imei}) async {
    try {
      Map params = {"password": psw, "empcode": id, "imei": imei};
      final Response response = await http.post(
          Uri.parse(
              'https://employee-management-usz2.onrender.com/empl/check_login'),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(params));
      print(response.statusCode);
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        print(result);
        return result;
        // print(result);
        // if (result['success'] == 0) {
        //   return Future.error(result['message']);
        // } else {
        //   return Future.value(result);
        // }
        // AllLoginModel empDetails = AllLoginModel.fromJson(result);
        // return empDetails;
      } else {
        return Future.error("response error");
      }
    } catch (e) {
      log(e.toString());
      return Future.error(e.toString());
    }
  }

  Future getData(List prodIds) async {
    try {
      prodIds.sort((a, b) => int.parse(a['id']).compareTo(int.parse(b['id'])));
      List ids = prodIds.map((e) => e['id']).toList();

      Map params = {'products': jsonEncode(ids)};
      var response = await http.post(Uri.parse(cartUrllll), body: params);

      if (response.statusCode == 200) {
        var result = await jsonDecode(response.body);
        // print(result['product']);
        return result['product'];
      } else {
        return [];
      }
    } on SocketException {
      return Future.error("Socket error");
    } catch (e) {
      return Future.error(e);
    }
  }
}
