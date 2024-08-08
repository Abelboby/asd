import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'transaction_service.dart';
import 'transaction.dart';
import 'pdf_generator.dart';

class PaymentSectionScreen extends StatefulWidget {
  @override
  _PaymentSectionScreenState createState() => _PaymentSectionScreenState();
}

class _PaymentSectionScreenState extends State<PaymentSectionScreen> {
  final _amountController = TextEditingController();
  final _nameController = TextEditingController();
  final _remarksController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment Section'),
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
                // Start monitoring for notifications
              },
              child: Text('OK'),
            ),
            SizedBox(height: 20),
            Expanded(
              child: Consumer<TransactionService>(
                builder: (context, transactionService, child) {
                  return ListView.builder(
                    itemCount: transactionService.transactions.length,
                    itemBuilder: (context, index) {
                      final transaction = transactionService.transactions[index];
                      return ListTile(
                        title: Text(transaction.name),
                        subtitle: Text('${transaction.amount}'),
                        trailing: Text(transaction.date.toIso8601String()),
                      );
                    },
                  );
                },
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Export to PDF
                PdfGenerator.generatePdf(context);
              },
              child: Text('Export as PDF'),
            ),
          ],
        ),
      ),
    );
  }
}
