
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../models/task_model.dart';

class TaskProvider with ChangeNotifier {
  List<Task> _tasks = [];

  List<Task> get tasks => _tasks;

  Future<void> loadTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final storedData = prefs.getString('tasks');

    if (storedData != null) {
      final List decoded = jsonDecode(storedData);
      _tasks = decoded.map((e) => Task.fromJson(e)).toList();
      notifyListeners();
      return;
    }

    await fetchTasksFromApi();
  }

  Future<void> fetchTasksFromApi() async {
    try {
      final url = Uri.parse('https://jsonplaceholder.typicode.com/todos?_limit=20');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List decoded = jsonDecode(response.body);
        _tasks = decoded.map((e) => Task.fromJson(e)).toList();
        await saveTasks();
        notifyListeners();
      }
    } catch (e) {
      debugPrint('API error: $e');
    }
  }

  Future<void> saveTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = jsonEncode(_tasks.map((e) => e.toJson()).toList());
    await prefs.setString('tasks', jsonString);
  }

  void addTask(String title) {
    final newTask = Task(
      userId: 1,
      id: DateTime.now().millisecondsSinceEpoch,
      title: title,
      completed: false,
    );
    _tasks.insert(0, newTask);
    saveTasks();
    notifyListeners();
  }

  void toggleComplete(int id) {
    final index = _tasks.indexWhere((task) => task.id == id);
    if (index != -1) {
      _tasks[index].completed = !_tasks[index].completed;
      saveTasks();
      notifyListeners();
    }
  }

  void deleteTask(int id) {
    _tasks.removeWhere((task) => task.id == id);
    saveTasks();
    notifyListeners();
  }

  Future<void> clearTasks() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('tasks');
    _tasks = [];
    notifyListeners();
  }
}
