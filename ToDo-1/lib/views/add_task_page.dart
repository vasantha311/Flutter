import 'package:flutter/material.dart';
import 'package:my_app/controllers/auth_controller';
import 'package:my_app/controllers/task_controller';
import 'package:provider/provider.dart';
import '../models/task_model.dart';

class AddTaskPage extends StatelessWidget {
  const AddTaskPage({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthController>(context);
    final taskController = TaskController();
    final taskTextController = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: const Text('Add Task')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
                controller: taskTextController,
                decoration: const InputDecoration(labelText: 'Task')),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final task =
                    Task(id: '', title: taskTextController.text, isDone: false);
                taskController.addTask(auth.user!.uid, task);
                Navigator.pop(context);
              },
              child: const Text('Add'),
            ),
          ],
        ),
      ),
    );
  }
}
