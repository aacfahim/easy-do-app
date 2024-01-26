import 'dart:convert';

import 'package:easy_do_app/model/all_task_model.dart';
import 'package:easy_do_app/services/task_notifier.dart';

import 'package:flutter/material.dart';
import 'package:easy_do_app/services/auth_services.dart';
import 'package:easy_do_app/utils/urls.dart';
import 'package:http/http.dart' as http;

class TaskServices extends ChangeNotifier {
  bool isLoading = false;

  Future<List<AllTaskDataModel>> getAllTasks() async {
    List<AllTaskDataModel> tasks = [];

    String url = BASE_URL + TASK;

    AuthProvider authProvider = AuthProvider();
    await authProvider.init();

    String? token = authProvider.authToken;

    try {
      isLoading = true;
      notifyListeners();

      var response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      var data = jsonDecode(response.body);
      // print(data);

      if (response.statusCode == 200) {
        for (var i in data['data']) {
          tasks.add(AllTaskDataModel.fromJson(i));
        }

        print("task data: " + jsonEncode(data));
        return tasks;
      } else {
        print("Error");
        return [];
      }
    } catch (e) {
      print('Error: $e');
      return [];
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> addTask(String title, String date, String description) async {
    String url = BASE_URL + TASK;

    AuthProvider authProvider = AuthProvider();
    await authProvider.init();

    String? token = authProvider.authToken;

    print(title);
    print(date);
    print(description);

    var response = await http.post(Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(
          {
            "title": title,
            "description": description,
            "dueDate": date,
          },
        ));

    var data = jsonDecode(response.body);

    if (response.statusCode == 200 || response.statusCode == 201) {
      print(data);
      return data['success'];
    } else {
      print(data);

      return false;
    }
  }

  Future deleteTask(String id) async {
    String url = BASE_URL + TASK + "/$id";

    AuthProvider authProvider = AuthProvider();
    await authProvider.init();

    String? token = authProvider.authToken;

    var response = await http.delete(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    var data = jsonDecode(response.body);

    if (response.statusCode == 200 || response.statusCode == 201) {
      print(data);
      return data['success'];
    } else {
      print(data);

      return false;
    }
  }

  Future updateTask(String id, bool completed, String description) async {
    String url = BASE_URL + TASK + "/$id";

    AuthProvider authProvider = AuthProvider();
    await authProvider.init();

    String? token = authProvider.authToken;

    var response = await http.put(Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "completed": completed,
          "description": description,
        }));

    var data = jsonDecode(response.body);

    if (response.statusCode == 200 || response.statusCode == 201) {
      print(data);
      return data['success'];
    } else {
      print(data);

      return false;
    }
  }

  Future getTaskStatus(bool isCompleted) async {
    final baseUrl = BASE_URL + TASK;
    AuthProvider authProvider = AuthProvider();
    await authProvider.init();

    String? token = authProvider.authToken;

    String completionParam;

    if (isCompleted) {
      completionParam = 'true';
    } else {
      completionParam = 'false';
    }

    final Map<String, String> params = {
      'completed': completionParam,
    };

    final uri = Uri.parse(baseUrl).replace(queryParameters: params);

    final headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };

    final response = await http.get(uri, headers: headers);

    if (response.statusCode == 200) {
      // print("Response data: ${response.body}");
      var data = jsonDecode(response.body);
      // print(data['count']);
      return data['count'];
    } else {
      print("Error: ${response.statusCode}");
      return -1;
    }
  }
}
