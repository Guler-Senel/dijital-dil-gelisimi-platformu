import 'package:flutter/material.dart';
import 'package:kidlingua/app.dart';
import 'package:kidlingua/navigation/app_router.dart';
import 'package:kidlingua/providers/kid_lingua_state.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final router = createAppRouter();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<KidLinguaState>(create: (_) => KidLinguaState()),
      ],
      child: KidLinguaApp(router: router),
    ),
  );
}
