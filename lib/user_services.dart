import 'dart:convert';
import 'package:usercrudapis/models/user.dart';
import 'package:http/http.dart' as http;


class UserServices {
  static const String baseurl = "http://localhost:2000/users";

  static Future<List<User>> fetchusers() async {
    final response = await http.get(Uri.parse(baseurl));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((userjson) => User.fromJson(userjson)).toList();
    } else {
      throw Exception("Failed to load data");
    }
  }
}
