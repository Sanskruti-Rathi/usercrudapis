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

  static Future<void> adduser(String name, int age) async {
    final response = await http.post(
      Uri.parse(baseurl),
      headers: {"Content-Type": "application/json"},
      body: json.encode({"name": name, "age": age, "role": "user"}),
    );
    if (response.statusCode != 201) {
      throw Exception("Failed to add user");
    }
  }

  static Future<void> updateuser(String id,String name,int age)async{
    final response = await http.put(
      Uri.parse("$baseurl/$id"),
      headers: {"Content-Type": "application/json"},
      body: json.encode({"name": name, "age": age, "role": "user"}),
    );
    if (response.statusCode != 200) {
      throw Exception("Failed to update user");
    }
  }

  static Future<void> deleteuser(String id) async {
    final response = await http.delete(Uri.parse("$baseurl/$id"));
    if (response.statusCode != 200) {
      throw Exception("Failed to delete user");
    }
  }
  }

