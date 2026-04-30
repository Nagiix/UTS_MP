import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:aplikasiuts/dashboard_page.dart';
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
    expect(find.text('Cancel'), findsOneWidget);
  });

  testWidgets('creates activity and adds it to dashboard list',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: DashboardPage(username: "admin@gmail.com"),
      ),
    );

    await tester.tap(find.text('+ Aktivitas'));
    await tester.pumpAndSettle();

    await tester.enterText(
      find.widgetWithText(TextFormField, 'Judul Aktivitas'),
      'Upload laporan',
    );
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Deskripsi'),
      'Upload laporan bulanan',
    );
    await tester.tap(find.text('Create Aktivitas'));
    await tester.pumpAndSettle();

    expect(find.text('Upload laporan'), findsOneWidget);
    expect(
      find.textContaining('Upload laporan bulanan'),
      findsOneWidget,
    );
  });

  testWidgets('preset activities use full activity format',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: DashboardPage(username: "admin@gmail.com"),
      ),
    );

    expect(find.text('Login berhasil'), findsOneWidget);
    expect(
      find.text('Admin masuk ke aplikasi - 10 Apr 2026 - auth - Sedang'),
      findsOneWidget,
    );
  });

  testWidgets('opens detail and edits an activity',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: DashboardPage(username: "admin@gmail.com"),
      ),
    );

    await tester.tap(find.text('Login berhasil'));
    await tester.pumpAndSettle();

    expect(find.text('Detail Aktivitas'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.edit).first);
    await tester.pumpAndSettle();

    expect(find.text('Edit Aktivitas'), findsOneWidget);

    await tester.enterText(
      find.widgetWithText(TextFormField, 'Judul Aktivitas'),
      'Login admin berhasil',
    );
    await tester.tap(find.text('Update Aktivitas'));
    await tester.pumpAndSettle();

    expect(find.text('Login admin berhasil'), findsOneWidget);
    expect(find.text('Aktivitas berhasil diperbarui'), findsOneWidget);
  });

  testWidgets('filters by priority and shows empty state',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: DashboardPage(username: "admin@gmail.com"),
      ),
    );

    await tester.enterText(find.byType(TextField), 'Tidak ada data');
    await tester.tap(find.text('Tinggi'));
    await tester.pump();

    expect(find.text('Tidak ada aktivitas ditemukan'), findsOneWidget);
  });

  testWidgets('deletes activity after confirmation',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: DashboardPage(username: "admin@gmail.com"),
      ),
    );

    await tester.tap(find.byIcon(Icons.delete).first);
    await tester.pumpAndSettle();

    expect(find.text('Hapus aktivitas?'), findsOneWidget);

    await tester.tap(find.text('Delete'));
    await tester.pumpAndSettle();

    expect(find.text('Login berhasil'), findsNothing);
    expect(find.text('Aktivitas berhasil dihapus'), findsOneWidget);
  });

  testWidgets('cancel activity creation returns to dashboard',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: DashboardPage(username: "admin@gmail.com"),
      ),
    );

    await tester.tap(find.text('+ Aktivitas'));
    await tester.pumpAndSettle();

    expect(find.text('Cancel'), findsOneWidget);

    await tester.tap(find.text('Cancel'));
    await tester.pumpAndSettle();

    expect(find.text('Dashboard Interaktif'), findsOneWidget);
    expect(find.text('Tambah aktivitas'), findsNothing);
  });
}
