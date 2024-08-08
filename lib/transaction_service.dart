import 'package:flutter/material.dart';
import 'task.dart';
import 'transaction.dart';

class TransactionService with ChangeNotifier {
  List<Task> _tasks = [];

  List<Task> get tasks => _tasks;

  void addTask(Task task) {
    _tasks.add(task);
    notifyListeners();
  }

  void addTransactionToTask(Task task, Transaction transaction) {
    task.transactions.add(transaction);
    notifyListeners();
  }
}
