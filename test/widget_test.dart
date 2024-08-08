// import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:gpaid/main.dart';
import 'package:gpaid/transaction_service.dart';

void main() {
  testWidgets('GPay Payment Tracker app loads', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (context) => TransactionService(),
        child: MyApp(),
      ),
    );

    // Verify that our app loads and displays the AppBar title.
    expect(find.text('GPay Payment Tracker'), findsOneWidget);

    // Verify that the "Create Collection" button is present.
    expect(find.text('Create Collection'), findsOneWidget);
  });
}
