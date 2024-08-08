import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'transaction_service.dart';
import 'task_detail_screen.dart';
import 'task.dart';

class NewTaskScreen extends StatefulWidget {
  @override
  _NewTaskScreenState createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  final _amountController = TextEditingController();
  final _nameController = TextEditingController();
  final _remarksController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Task'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Collection Name'),
            ),
            TextField(
              controller: _amountController,
              decoration: InputDecoration(labelText: 'Amount to Monitor'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _remarksController,
              decoration: InputDecoration(labelText: 'Remarks'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final newTask = Task(
                  name: _nameController.text,
                  amount: double.parse(_amountController.text),
                  remarks: _remarksController.text,
                  transactions: [],
                );
                Provider.of<TransactionService>(context, listen: false).addTask(newTask);

                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TaskDetailScreen(task: newTask),
                  ),
                );
              },
              child: Text('OK'),
            ),
          ],
        ),
      ),
    );
  }
}
