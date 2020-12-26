import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Auth with ChangeNotifier {
  String _token;
  DateTime _expiryDate;
  String _userId;

  Future<void> signup(String email, String password) async {
    print("SIGN UP : email - $email, password - $password");

    const url =
        'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyChf-lwLlMOqdRDi8ueYGBEj2Iy5PB5yIQ';

    final response = await http.post(
      url,
      body: json.encode(
        {
          'email': email,
          'password': password,
          'returnSecureToken': true,
        },
      ),
    );
    print("SIGNUP RESPONSE: ");
    print(json.decode(response.body));
  }
}
