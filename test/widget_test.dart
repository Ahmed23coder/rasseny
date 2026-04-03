import 'package:flutter_test/flutter_test.dart';

import 'package:rasseny/main.dart';

void main() {
  testWidgets('App boots and shows Home', (WidgetTester tester) async {
    await tester.pumpWidget(const RassenyApp());
    await tester.pumpAndSettle();
    expect(find.text('Rasseny'), findsOneWidget);
  });
}
