import 'package:flutter_test/flutter_test.dart';

import 'package:rassenytest/main.dart';

void main() {
  testWidgets('RassenyApp builds without errors', (WidgetTester tester) async {
    await tester.pumpWidget(const RassenyApp());
    // Splash screen should display the brand name.
    expect(find.text('RASSENY'), findsOneWidget);
  });
}
