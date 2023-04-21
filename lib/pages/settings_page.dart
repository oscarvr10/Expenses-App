import 'package:exp_app/widgets/settings_page_wt/dark_mode_switch.dart';
import 'package:exp_app/widgets/settings_page_wt/time_picker.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Configuración')),
      body: ListView(
        children: const [
          DarkModeSwitch(),
          Divider(thickness: 2),
          TimePicker(),
          Divider(thickness: 2),
        ],
      ),
    );
  }
}
