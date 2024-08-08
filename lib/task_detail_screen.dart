import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'transaction_service.dart';
import 'task.dart';
import 'transaction.dart';
import 'pdf_generator.dart';

class TaskDetailScreen extends StatefulWidget {
  final Task task;

  TaskDetailScreen({required this.task});

  @override
  _TaskDetailScreenState createState() => _TaskDetailScreenState();
}

class _TaskDetailScreenState extends State<TaskDetailScreen> {
  final _nameController = TextEditingController();
  final _amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.task.name),
        actions: [
          IconButton(
            icon: Icon(Icons.picture_as_pdf),
            onPressed: () {
              PdfGenerator.generatePdf(context, widget.task);
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Transactions'),
            Expanded(
              child: ListView.builder(
                itemCount: widget.task.transactions.length,
                itemBuilder: (context, index) {
                  final transaction = widget.task.transactions[index];
                  return ListTile(
                    title: Text(transaction.name),
                    subtitle: Text('${transaction.amount}'),
                    trailing: Text(transaction.date.toIso8601String()),
                  );
                },
              ),
            ),
            Divider(),
            Text('Add Transaction Manually'),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: _amountController,
              decoration: InputDecoration(labelText: 'Amount'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Prevent adding the transaction if the fields are empty
                if (_nameController.text.isEmpty || _amountController.text.isEmpty) return;

                final newTransaction = Transaction(
                  name: _nameController.text,
                  amount: double.parse(_amountController.text),
                  date: DateTime.now(),
                );

                // Add transaction to the task
                Provider.of<TransactionService>(context, listen: false)
                    .addTransactionToTask(widget.task, newTransaction);

                // Clear the input fields after adding the transaction
                _nameController.clear();
                _amountController.clear();
                
                // Update the local state
                setState(() {
                  widget.task.transactions.add(newTransaction);
                });
              },
              child: Text('Add Transaction'),
            ),
          ],
        ),
      ),
    );
  }
}
