import 'package:flutter_test/flutter_test.dart';
import 'package:kidlingua/app.dart';
import 'package:kidlingua/navigation/app_router.dart';
import 'package:kidlingua/providers/kid_lingua_state.dart';
import 'package:provider/provider.dart';

void main() {
  testWidgets('KidLingua ana ekran yüklenir', (WidgetTester tester) async {
    final router = createAppRouter();
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider<KidLinguaState>(create: (_) => KidLinguaState()),
        ],
        child: KidLinguaApp(router: router),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.textContaining('KİDLİNGUA'), findsOneWidget);
  });
}
