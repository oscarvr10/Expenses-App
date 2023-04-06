import 'package:exp_app/pages/add_entries.dart';
import 'package:exp_app/pages/add_expenses.dart';
import 'package:exp_app/providers/expenses_provider.dart';
import 'package:exp_app/providers/ui_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'pages/home_page.dart';

void main() => runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => UIProvider()),
          ChangeNotifierProvider(create: (_) => ExpensesProvider()),
        ],
        child: const MyApp(),
      ),
    );

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('es'),
        Locale('en'),
      ],
      theme: ThemeData.dark().copyWith(
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.grey[900],
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          selectedItemColor: Colors.green,
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Colors.lightGreen,
          foregroundColor: Colors.white,
        ),
        colorScheme: const ColorScheme.dark(
          primary: Colors.green,
        ),
        scaffoldBackgroundColor: Colors.grey[900],
        primaryColorDark: Colors.grey[800],
        dividerColor: Colors.grey,
      ),
      initialRoute: 'home',
      routes: {
        'home': (_) => const HomePage(),
        'add_entries': (_) => const AddEntries(),
        'add_expenses': (_) => const AddExpenses(),
      },
    );
  }
}
