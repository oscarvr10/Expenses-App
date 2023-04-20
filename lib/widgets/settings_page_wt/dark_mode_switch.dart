import 'package:flutter/material.dart';

class DarkModeSwitch extends StatefulWidget {
  const DarkModeSwitch({super.key});

  @override
  State<DarkModeSwitch> createState() => _DarkModeSwitchState();
}

class _DarkModeSwitchState extends State<DarkModeSwitch> {
  bool _darkMode = false;

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      value: _darkMode,
      title: const Text(
        'Modo Oscuro',
        style: TextStyle(fontSize: 14.0),
      ),
      subtitle: const Text('El modo oscuro ayuda a ahorrar batería'),
      onChanged: (value) {
        setState(() {
          _darkMode = value;
        });
      },
    );
  }
}
