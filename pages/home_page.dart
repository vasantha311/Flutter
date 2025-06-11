import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:practice_1/pages/deleted_page.dart';
import 'package:practice_1/util/todo_tile.dart';
import 'package:practice_1/util/dialog_box.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController finalController = TextEditingController();

  List<List<dynamic>> toDoList = [];
  List<List<dynamic>> deletedList = [];

  @override
  void initState() {
    super.initState();
    loadData();
  }


  void loadData() async {
    final prefs = await SharedPreferences.getInstance();
    String? todoString = prefs.getString('todoList');
    String? deletedString = prefs.getString('deletedList');

    if (todoString != null && todoString != null) {
      toDoList = List<List<dynamic>>.from(
        json.decode(todoString).map((e) => List.from(e)),
      );
    } else {
      toDoList = [
        ["welcome to todo", false],
        ["add content", false],
        ["thank you todo", false],
      ];
      await prefs.setString('todoList', json.encode(toDoList));
    }

    if (deletedString != null) {
      deletedList = List<List<dynamic>>.from(
        json.decode(deletedString).map((e) => List.from(e)),
      );
    }

    setState(() {});
  }


  void saveData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('todoList', json.encode(toDoList));
    await prefs.setString('deletedList', json.encode(deletedList));
  }

  void checkBoxChanged(bool value, int index) {
    setState(() {
      toDoList[index][1] = value;
    });
    saveData();
  }

  void saveNewTask() {
    String newTask = finalController.text.trim();

    if (newTask.isEmpty) {
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Task cannot be empty"),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 3),
        ),
      );
      return;
    }

    setState(() {
      toDoList.add([newTask, false]);
      finalController.clear();
    });
    saveData();
    Navigator.of(context).pop();
  }

  void createNewTask() {
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          controller: finalController,
          onSave: saveNewTask,
          onCancel: () {
            finalController.clear();
            Navigator.of(context).pop();
          },
        );
      },
    );
  }

  void deleteTask(int index) {
    String deletedTask = toDoList[index][0];
    bool wasCompleted = toDoList[index][1];

    setState(() {
      deletedList.add([deletedTask, wasCompleted]);
      toDoList.removeAt(index);
    });
    saveData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[200],
      appBar: AppBar(
        title: const Text('To Do'),
        centerTitle: true,
        backgroundColor: Colors.blue,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_outline),
            tooltip: 'Deleted Items',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      DeletedPage(deletedTasks: deletedList),
                ),
              );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask,
        child: const Icon(Icons.add),
        backgroundColor: Colors.red,
      ),
      body: ListView.builder(
        itemCount: toDoList.length,
        itemBuilder: (context, index) {
          return TodoTile(
            taskName: toDoList[index][0],
            taskCompleted: toDoList[index][1],
            onChanged: (value) => checkBoxChanged(value!, index),
            deleteFunction: (context) => deleteTask(index),
          );
        },
      ),
    );
  }
}
