import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:tasky/features/add-task/presentation/widgets/show_dialog_ontap.dart';

class ShowDateDialog extends StatefulWidget {
  const ShowDateDialog({super.key, required this.dayNotifier});
  final ValueNotifier<DateTime> dayNotifier;
  @override
  State<ShowDateDialog> createState() => _ShowDateDialogState();
}

class _ShowDateDialogState extends State<ShowDateDialog> {
  late DateTime _focusedDay;
  late DateTime? _selectedDay;
  late DateTime firstDayOfMonth;
  late DateTime lastDayOfMonth;
  @override
  void initState() {
    super.initState();
    _focusedDay = widget.dayNotifier.value;
    _selectedDay = _focusedDay;
    firstDayOfMonth = DateTime(DateTime.now().year, DateTime.now().month, 1);
    lastDayOfMonth = DateTime(DateTime.now().year, DateTime.now().month + 1, 0);
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      insetPadding: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TableCalendar(
              firstDay: firstDayOfMonth,
              lastDay: lastDayOfMonth,
              focusedDay: _focusedDay,
              selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = selectedDay;
                });
              },
              availableGestures: AvailableGestures.all,
              headerStyle: const HeaderStyle(
                formatButtonVisible: false,
                titleCentered: true,
              ),
            ),
            const SizedBox(height: 10),
            ShowDialogOnTap(
              onTap: () {
                widget.dayNotifier.value = _selectedDay!;
                Navigator.pop(context);
              },
              selectedPriority: _selectedDay!.day,
            ),
          ],
        ),
      ),
    );
  }
}

void pickDate(BuildContext context, ValueNotifier<DateTime> dayNotifier) async {
  await showGeneralDialog<DateTime>(
    context: context,
    barrierDismissible: true,
    barrierLabel: '',
    barrierColor: Colors.black54,
    transitionDuration: const Duration(milliseconds: 400),
    pageBuilder: (_, __, ___) => const SizedBox.shrink(),
    transitionBuilder: (_, anim, __, ___) {
      final curvedValue = Curves.easeInOutBack.transform(anim.value);
      return Transform.scale(
        scale: curvedValue,
        child: ShowDateDialog(dayNotifier: dayNotifier),
      );
    },
  );
}
