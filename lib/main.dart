import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'screens/splash_screen.dart';
import 'theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');
  runApp(const GrammarCheckerApp());
}

class GrammarCheckerApp extends StatelessWidget {
  const GrammarCheckerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Grammix',
      debugShowCheckedModeBanner: false,
      theme: buildAppTheme(),
      home: const SplashScreen(),
    );
  }
}
