import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:tugas_tiga/main.dart';

void main() {
  testWidgets('Screen 1 and Screen 2 navigation and state test',
      (WidgetTester tester) async {
    // 1. Build widget and render Screen 1 (Beranda)
    await tester.pumpWidget(const MyApp());

    // Verify Screen 1 AppBar and 3 items in ListView
    expect(find.text('Katalog Layanan Digital'), findsOneWidget);
    expect(find.text('Desain UI/UX Mobile App'), findsOneWidget);
    expect(find.text('Pengembangan Web Fullstack'), findsOneWidget);
    expect(find.text('Optimasi SEO & Digital Ads'), findsOneWidget);

    // 2. Tap on first item to trigger Navigator.push to Screen 2
    await tester.tap(find.text('Desain UI/UX Mobile App'));
    await tester.pumpAndSettle();

    // Verify Screen 2 elements
    expect(find.text('Detail Katalog'), findsOneWidget);
    expect(find.text('Deskripsi Singkat Layanan'), findsOneWidget);
    expect(find.text('Pesan Sekarang'), findsOneWidget);

    // 3. Test Event and State on Screen 2 (StatefulWidget)
    // Tap + button to increment counter
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();
    expect(find.text('2'), findsOneWidget);

    // Tap Favorite icon to toggle favorite state
    await tester.tap(find.byTooltip('Tambah Favorit'));
    await tester.pumpAndSettle();
    expect(find.byIcon(Icons.favorite), findsOneWidget);

    // 4. Test back navigation via leading Icon back to return to Screen 1
    await tester.tap(find.byTooltip('Kembali ke Screen 1'));
    await tester.pumpAndSettle();

    // Verify back on Screen 1
    expect(find.text('Katalog Layanan Digital'), findsOneWidget);
  });
}
