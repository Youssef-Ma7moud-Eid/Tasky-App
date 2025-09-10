import 'package:flutter/material.dart';
import 'package:tasky/core/utils/app_colors.dart';

Future<void> showConfirmationDialog({
  required BuildContext context,
  required String action, 
  required String message, 
  required VoidCallback onConfirm,
}) async {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      final isDelete = action.toLowerCase() == "delete";

      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: Row(
          children: [
            Icon(
              isDelete ? Icons.delete_forever : Icons.warning_amber_rounded,
              color: isDelete ? Colors.red : Colors.orange,
              size: 28,
            ),
            const SizedBox(width: 8),
            Text(
              "Confirm $action",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        content: Text(
          message,
          style: const TextStyle(fontSize: 16),
        ),
        actionsPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        actions: <Widget>[
          OutlinedButton(
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: Colors.grey),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: () => Navigator.of(context).pop(),
            child: const Text("Cancel"),
          ),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.of(context).pop();
              onConfirm();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: isDelete ? Colors.red : AppColors.primaryColor,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              elevation: 0,
            ),
            icon: Icon(
              isDelete ? Icons.delete : Icons.check,
              color: Colors.white,
            ),
            label: Text(
              action,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      );
    },
  );
}
