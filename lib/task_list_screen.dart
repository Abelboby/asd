import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'transaction_service.dart';
import 'new_task_screen.dart';
import 'task_detail_screen.dart';

class TaskListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tasks List'),
      ),
      drawer: Drawer(
        child: Consumer<TransactionService>(
          builder: (context, transactionService, child) {
            return ListView.builder(
              itemCount: transactionService.tasks.length,
              itemBuilder: (context, index) {
                final task = transactionService.tasks[index];
                return ListTile(
                  title: Text(task.name),
                  subtitle: Text('${task.amount} - ${task.remarks}'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TaskDetailScreen(task: task),
                      ),
                    );
                  },
                );
              },
            );
          },
        ),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => NewTaskScreen(),
              ),
            );
          },
          child: Text('Create New Task'),
        ),
      ),
    );
  }
}
