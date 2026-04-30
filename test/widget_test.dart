import 'package:flutter_test/flutter_test.dart';

import 'package:aplikasiuts/main.dart';

void main() {
  testWidgets('opens create user page from login',
      (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());

    expect(find.text('Login'), findsOneWidget);

    await tester.tap(find.text('Buat user baru'));
    await tester.pumpAndSettle();

    expect(find.text('Create User'), findsWidgets);
    expect(find.text('Nama Lengkap'), findsOneWidget);
    expect(find.text('Konfirmasi Password'), findsOneWidget);
  });
}
