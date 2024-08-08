import 'transaction.dart';

class Task {
  final String name;
  final double amount;
  final String remarks;
  final List<Transaction> transactions;

  Task({
    required this.name,
    required this.amount,
    required this.remarks,
    required this.transactions,
  });
}
