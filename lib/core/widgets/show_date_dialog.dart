import 'package:flutter/material.dart';

Future<void> pickDateTime(
  BuildContext context,
  ValueNotifier<DateTime> dayNotifier,
) async {
  final date = await showDatePicker(
    context: context,
    initialDate: dayNotifier.value,
    firstDate: DateTime.now(),
    lastDate: DateTime.now().add(const Duration(days: 365 * 5)),
  );

  if (date == null) return;

  final time = await showTimePicker(
    context: context,
    initialTime: TimeOfDay.fromDateTime(dayNotifier.value),
  );

  if (time == null) return;

  final selectedDateTime = DateTime(
    date.year,
    date.month,
    date.day,
    time.hour,
    time.minute,
  );

  dayNotifier.value = selectedDateTime;
}
