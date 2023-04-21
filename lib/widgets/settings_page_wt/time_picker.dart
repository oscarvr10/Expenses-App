import 'package:exp_app/providers/user_prefs.dart';
import 'package:exp_app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import 'package:intl/intl.dart';

class TimePicker extends StatefulWidget {
  const TimePicker({super.key});

  @override
  State<TimePicker> createState() => _TimePickerState();
}

class _TimePickerState extends State<TimePicker> {
  final _prefs = UserPrefs();
  bool isEnabled = false;
  String title = 'Activar Notificaciones';

  @override
  Widget build(BuildContext context) {
    final DateTime getDate = DateTime.now();
    String currentTime;

    if (_prefs.hour != 99) {
      final DateTime getTime = DateTime(
        getDate.year,
        getDate.month,
        getDate.day,
        _prefs.hour,
        _prefs.minute,
      );
      currentTime = DateFormat.jm().format(getTime);
      title = 'Desactivar Notificaciones';
      isEnabled = true;
    } else {
      currentTime = 'Desactivado';
      title = 'Activar Notificaciones';
      isEnabled = false;
    }

    return Column(
      children: [
        SwitchListTile(
          activeColor: Colors.green,
          value: isEnabled,
          title: Text(title),
          onChanged: (value) {
            setState(() {
              isEnabled = value;
              cancelNotification(value);
            });
          },
        ),
        ListTile(
          enabled: isEnabled,
          leading: isEnabled
              ? const Icon(
                  Icons.notifications_active_outlined,
                  size: 35.0,
                )
              : const Icon(
                  Icons.notifications_off_outlined,
                  size: 35.0,
                ),
          title: const Text('Recordatorio diario'),
          subtitle: Text(currentTime),
          trailing: const Icon(Icons.arrow_forward_ios_outlined),
          onTap: () {
            _selectedTime();
          },
        ),
      ],
    );
  }

  _selectedTime() {
    int? hour;
    int? minute;
    showModalBottomSheet(
      shape: Constants.bottomSheetBorder(),
      isScrollControlled: true,
      isDismissible: true,
      enableDrag: false,
      context: context,
      builder: (context) {
        return SizedBox(
          height: 350.0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TimePickerSpinner(
                time: DateTime.now(),
                is24HourMode: false,
                spacing: 40,
                itemWidth: 60.0,
                itemHeight: 60.0,
                isForce2Digits: true,
                normalTextStyle: const TextStyle(
                  fontSize: 30.0,
                ),
                highlightedTextStyle: const TextStyle(
                  fontSize: 38.0,
                  color: Colors.green,
                  letterSpacing: 1.5,
                  fontWeight: FontWeight.bold,
                ),
                onTimeChange: (time) {
                  setState(() {
                    hour = time.hour;
                    minute = time.minute;
                  });
                },
              ),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      child: Constants.customButton(
                        Colors.transparent,
                        Colors.red,
                        'CANCELAR',
                      ),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      child: Constants.customButton(
                        Colors.green,
                        Colors.transparent,
                        'ACEPTAR',
                      ),
                      onTap: () {
                        setState(() {
                          _prefs.hour = hour!;
                          _prefs.minute = minute!;
                        });
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }

  cancelNotification(bool value) {
    if (value) {
      _prefs.hour = 21;
      _prefs.minute = 0;
    } else {
      _prefs.deleteTime();
    }
  }
}
