import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'screens/splash_screen.dart';
import 'screens/home_screen.dart';
import 'screens/add_transaction_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://kqgbsjubahzzwdnfgdjp.supabase.co',   // vendos URL të Supabase
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImtxZ2JzanViYWh6endkbmZnZGpwIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDg1OTUyMzcsImV4cCI6MjA2NDE3MTIzN30.aHLJZIfCGsm_idiTBimr9T9i9yk_sdj9OdAFzVh36j4',                     // vendos anon key të Supabase
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Accounting Demo',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/home': (context) => const HomeScreen(),
        '/add': (context) => const AddTransactionScreen(),
      },
    );
  }
}
