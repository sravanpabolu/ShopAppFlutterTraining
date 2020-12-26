import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Auth with ChangeNotifier {
  String _token;
  DateTime _expiryDate;
  String _userId;

  Future<void> _authenticate(
      String email, String password, String urlSegment) async {
    final url =
        'https://identitytoolkit.googleapis.com/v1/accounts:$urlSegment?key=AIzaSyChf-lwLlMOqdRDi8ueYGBEj2Iy5PB5yIQ';

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
    print("AUTH RESPONSE: ");
    print(json.decode(response.body));
  }

  Future<void> signup(String email, String password) async {
    print("SIGN UP : email - $email, password - $password");

    return _authenticate(email, password, 'signUp');

    // const url =
    //     'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyChf-lwLlMOqdRDi8ueYGBEj2Iy5PB5yIQ';

    // final response = await http.post(
    //   url,
    //   body: json.encode(
    //     {
    //       'email': email,
    //       'password': password,
    //       'returnSecureToken': true,
    //     },
    //   ),
    // );
    // print("SIGNUP RESPONSE: ");
    // print(json.decode(response.body));
  }

  Future<void> login(String email, String password) async {
    print("SIGN IN : email - $email, password - $password");
    return _authenticate(email, password, 'signInWithPassword');
    // const url =
    //     'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyChf-lwLlMOqdRDi8ueYGBEj2Iy5PB5yIQ';

    // final response = await http.post(
    //   url,
    //   body: json.encode(
    //     {
    //       'email': email,
    //       'password': password,
    //       'returnSecureToken': true,
    //     },
    //   ),
    // );
    // print("SIGN IN RESPONSE: ");
    // print(json.decode(response.body));
  }
}
