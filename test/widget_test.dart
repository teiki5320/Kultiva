import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('MaterialApp avec Scaffold se monte', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(body: Center(child: Text('Kultiva'))),
      ),
    );
    expect(find.text('Kultiva'), findsOneWidget);
  });
}
