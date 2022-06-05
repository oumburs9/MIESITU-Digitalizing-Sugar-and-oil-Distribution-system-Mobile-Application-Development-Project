import 'package:flutter_test/flutter_test.dart';

import 'package:integration_test/integration_test.dart';

import '../../lib/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('end-to-end test', () {
    testWidgets('tap on the login button', (WidgetTester tester) async {
      app.main();

      await tester.pumpAndSettle();

      expect(find.text('textformarea'), findsOneWidget);

      final Finder fab = find.byTooltip('signin');

      await tester.tap(fab);

      await tester.pumpAndSettle();

      expect(find.text('textformarea'), findsOneWidget);
    });
  });
}
