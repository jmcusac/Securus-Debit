import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:securus_debit/main.dart';
import 'package:securus_debit/view_model/contact_view_model.dart';
import 'package:securus_debit/service/contact_service.dart';

void main() {
  testWidgets('App loads and shows Securus Debit title',
      (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());
    expect(find.text('Securus Debit'), findsOneWidget);
    expect(find.byIcon(Icons.add), findsOneWidget);
  });

  testWidgets('Can open add contact dialog', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());
    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();

    expect(find.text('Add Contact'), findsOneWidget);
    expect(find.byType(TextField), findsNWidgets(2));
  });
}
