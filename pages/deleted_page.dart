import 'package:flutter/material.dart';

class DeletedPage extends StatelessWidget {
  final List<List<dynamic>> deletedTasks;

  const DeletedPage({
    super.key,
    required this.deletedTasks,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Text("Deleted Tasks"),
        centerTitle: true,
      ),
      body: deletedTasks.isEmpty
          ? const Center(
        child: Text(
          'No deleted tasks',
        ),
      )
          : ListView.builder(
        itemCount: deletedTasks.length,
        itemBuilder: (context, index) {
          final task = deletedTasks[index];
          return ListTile(
            title: Text(task[0]),
            trailing: const Icon(Icons.delete, color: Colors.red),
          );
        },
      ),
    );
  }
}

