import 'package:exp_app/pages/add_entries.dart';
import 'package:exp_app/pages/add_expenses.dart';
import 'package:exp_app/pages/categories_details.dart';
import 'package:exp_app/pages/expenses_details.dart';
import 'package:exp_app/providers/expenses_provider.dart';
import 'package:exp_app/providers/local_notifications.dart';
import 'package:exp_app/providers/theme_provider.dart';
import 'package:exp_app/providers/ui_provider.dart';
import 'package:exp_app/providers/user_prefs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'pages/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  tz.initializeTimeZones();
  final prefs = UserPrefs();
  final notif = LocalNotifications();

  await prefs.initPrefs();
  await notif.initialize();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UIProvider()),
        ChangeNotifierProvider(create: (_) => ExpensesProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider(prefs.darkMode)),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(builder: (context, provider, child) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Material App',
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('es'),
          Locale('en'),
        ],
        theme: provider.getTheme(),
        initialRoute: 'home',
        routes: {
          'home': (_) => const HomePage(),
          'add_entries': (_) => const AddEntries(),
          'add_expenses': (_) => const AddExpenses(),
          'cat_details': (_) => const CategoriesDetails(),
          'exp_details': (_) => const ExpensesDetails(),
        },
      );
    });
  }
}
