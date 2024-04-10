import 'package:flutter_test/flutter_test.dart';
import 'package:sample_android_ads_issue/app/app.dart';
import 'package:sample_android_ads_issue/main/main.dart';

void main() {
  group('App', () {
    testWidgets('renders CounterPage', (tester) async {
      await tester.pumpWidget(const App());
      expect(find.byType(MainPage), findsOneWidget);
    });
  });
}
