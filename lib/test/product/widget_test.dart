import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('contains padding of EdgeInsets.all',
      (WidgetTester tester) async {
    const childWidget = Padding(padding: EdgeInsets.all(0));
    await tester.pumpWidget(Container(child: childWidget));
    // final circularProgressIndicatorCount =
    //     find.byType(CircularProgressIndicator);
    expect(find.byWidget(childWidget), findsOneWidget);
  });
}
