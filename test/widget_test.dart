import 'package:da_field_app/main.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Login screen renders required controls', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('AgriStat Magdalena'), findsOneWidget);
    expect(find.text('Field Worker Login'), findsOneWidget);
    expect(find.text('Username or Email'), findsOneWidget);
    expect(find.text('Password'), findsOneWidget);
    expect(find.text('SIGN IN'), findsOneWidget);
  });
}
