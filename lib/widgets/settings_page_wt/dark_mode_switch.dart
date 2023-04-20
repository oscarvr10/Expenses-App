import 'package:exp_app/providers/theme_provider.dart';
import 'package:exp_app/providers/user_prefs.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DarkModeSwitch extends StatefulWidget {
  const DarkModeSwitch({super.key});

  @override
  State<DarkModeSwitch> createState() => _DarkModeSwitchState();
}

class _DarkModeSwitchState extends State<DarkModeSwitch> {
  bool _darkMode = false;
  final prefs = UserPrefs();

  @override
  void initState() {
    _darkMode = prefs.darkMode;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      activeColor: Colors.green,
      value: _darkMode,
      title: const Text(
        'Modo Oscuro',
        style: TextStyle(fontSize: 14.0),
      ),
      subtitle: const Text('El modo oscuro ayuda a ahorrar batería'),
      onChanged: (value) {
        setState(() {
          _darkMode = value;
          prefs.darkMode = value;
          context.read<ThemeProvider>().swapTheme();
        });
      },
    );
  }
}
