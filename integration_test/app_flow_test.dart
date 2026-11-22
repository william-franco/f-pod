import 'package:cupertino_ui/cupertino_ui.dart';
import 'package:f_pod/main.dart' as app;
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('music player home screen is shown', (tester) async {
    app.main();
    await tester.pumpAndSettle(const Duration(seconds: 5));

    expect(find.byType(CupertinoPageScaffold), findsOneWidget);
  });
}