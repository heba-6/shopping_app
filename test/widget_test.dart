import 'package:flutter_test/flutter_test.dart';
import 'package:shopping_app/main.dart';

void main() {
  testWidgets('MyApp builds successfully', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp(initialRoute: '/onboarding'));

    await tester.pump();

    expect(find.byType(MyApp), findsOneWidget);
  });
}
