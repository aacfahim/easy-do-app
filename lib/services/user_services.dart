import 'dart:convert';

import 'package:easy_do_app/services/auth_services.dart';
import 'package:easy_do_app/utils/urls.dart';

import 'package:http/http.dart' as http;

class UserServices {
  Future<Map<String, dynamic>> updateUser(
      String name, String email, int age) async {
    String url = BASE_URL + UPDATE_USER;

    AuthProvider authProvider = AuthProvider();
    await authProvider.init();

    String? token = authProvider.authToken;

    var response = await http.put(Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "name": name,
          "email": email,
          "age": age,
        }));

    var data = jsonDecode(response.body);

    if (response.statusCode == 200 || response.statusCode == 201) {
      print(data);

      // Update name and email in AuthProvider
      authProvider.userData?['name'] = name;
      authProvider.userData?['email'] = email;

      // Save updated data in SharedPreferences
      await authProvider.saveUserData(authProvider.userData!);

      return {'success': true, 'data': data};
    } else {
      print(data);

      return {'success': false, 'error': 'Failed to update. Please try again.'};
    }
  }
}
