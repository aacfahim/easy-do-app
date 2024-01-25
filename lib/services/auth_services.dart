import 'dart:convert';

import 'package:easy_do_app/utils/urls.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  String? _authToken;
  Map<String, dynamic>? _userData;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  String? get authToken => _authToken;
  Map<String, dynamic>? get userData => _userData;

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future _saveAuthToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('authToken', token);
  }

  Future _saveUserData(Map<String, dynamic> userData) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('userData', json.encode(userData));
  }

  Future _loadSavedData() async {
    final prefs = await SharedPreferences.getInstance();
    _authToken = prefs.getString('authToken');
    final userDataString = prefs.getString('userData');
    if (userDataString != null) {
      _userData = json.decode(userDataString);
    }
  }

  Future<Map<String, dynamic>> signIn(String email, String password) async {
    String url = BASE_URL + LOGIN;
    print(url);

    print(email);
    print(password);

    try {
      var response = await http.post(Uri.parse(url),
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json',
          },
          body: jsonEncode(
            {
              "email": email,
              "password": password,
            },
          ));

      print("res " + response.statusCode.toString());

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        _authToken = responseData['token'];
        _userData = responseData['user'];

        await _saveAuthToken(_authToken!);
        await _saveUserData(_userData!);

        notifyListeners();

        print(responseData);

        return {'success': true, 'data': responseData};
      } else {
        // print(response.statusCode);
        throw Exception('Failed to sign in');
      }
    } catch (e) {
      print('Error: $e');

      return {
        'success': false,
        'error': 'Failed to sign in. Please try again.'
      };
    }
  }

  Future signOut() async {
    _authToken = null;
    _userData = null;

    final prefs = await SharedPreferences.getInstance();
    prefs.remove('authToken');
    prefs.remove('userData');

    notifyListeners();
  }

  Future init() async {
    await _loadSavedData();
  }
}
