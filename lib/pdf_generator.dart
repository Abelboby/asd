import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'task.dart';

class PdfGenerator {
  static Future<void> generatePdf(BuildContext context, Task task) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text('Task: ${task.name}', style: pw.TextStyle(fontSize: 24)),
              pw.Text('Amount to Monitor: ${task.amount}'),
              pw.Text('Remarks: ${task.remarks}'),
              pw.SizedBox(height: 20),
              pw.Text('Transactions:', style: pw.TextStyle(fontSize: 18)),
              pw.Table.fromTextArray(
                context: context,
                data: <List<String>>[
                  <String>['Name', 'Amount', 'Date'],
                  ...task.transactions.map((transaction) => [
                    transaction.name,
                    transaction.amount.toString(),
                    transaction.date.toIso8601String()
                  ])
                ],
              ),
            ],
          );
        },
      ),
    );

    final output = await getExternalStorageDirectory();
    final file = File("${output?.path}/${task.name}_transactions.pdf");
    await file.writeAsBytes(await pdf.save());
  }
}
