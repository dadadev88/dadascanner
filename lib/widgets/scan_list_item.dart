import 'dart:async';

import 'package:dadascanner/models/scan_model.dart';
import 'package:dadascanner/providers/scans_providers.dart';
import 'package:dadascanner/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ScanListItem extends StatelessWidget {
  final List<Scan> scans;
  final IconData icon;
  final Function(Scan) onTap;

  const ScanListItem({
    super.key,
    required this.scans,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    if (this.scans.isEmpty) {
      return const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Scans no founded'),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.qr_code_rounded, color: AppColors.primary, size: 16),
              SizedBox(width: 4),
              Text('Push QR button to new scan'),
            ],
          ),
        ],
      );
    }

    return ListView.builder(
      itemCount: this.scans.length,
      itemBuilder: (_, i) {
        Scan scan = this.scans[i];
        String title = _getTitle(scan);

        return Dismissible(
          key: UniqueKey(),
          direction: DismissDirection.horizontal,
          movementDuration: const Duration(milliseconds: 100),
          background: Container(
            width: MediaQuery.of(context).size.width * 0.5,
            height: 100,
            padding: EdgeInsets.zero,
            color: Colors.red,
            child: const Row(children: [
              SizedBox(width: 20),
              Icon(Icons.delete, color: Colors.white),
              Text('Remove', style: TextStyle(color: Colors.white))
            ]),
          ),
          secondaryBackground: Container(
            width: MediaQuery.of(context).size.width * 0.5,
            height: 100,
            color: Colors.amber,
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text('Rename', style: TextStyle(color: Colors.white)),
                Icon(Icons.note_alt, color: Colors.white),
                SizedBox(width: 20)
              ],
            ),
          ),
          confirmDismiss: (direction) =>
              _handleConfirmDismiss(direction, scan, context),
          child: ListTile(
            leading: Icon(this.icon, color: AppColors.primary),
            title: Text(title),
            subtitle: Text(
              'ID: ${scan.id}',
              style: const TextStyle(fontSize: 12),
            ),
            onTap: () => this.onTap(scan),
            trailing: const Icon(Icons.keyboard_arrow_right_rounded),
          ),
        );
      },
    );
  }

  Future<bool?> _handleConfirmDismiss(
    DismissDirection direction,
    Scan scan,
    BuildContext context,
  ) async {
    ScaffoldMessenger.of(context).clearSnackBars();
    if (direction == DismissDirection.startToEnd) {
      return showDialog<bool>(
        context: context,
        builder: (_) => _getDeleteAlert(context, scan.id!),
      );
    }

    if (direction == DismissDirection.endToStart) {
      showDialog<bool>(
        context: context,
        builder: (_) => _getRenameAlert(context, scan),
      );
      return false;
    }

    return false;
  }

  Widget _getDeleteAlert(BuildContext context, int scanId) {
    return AlertDialog(
      title: const Text("Confirm that you want delete item"),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () async {
            await Provider.of<ScansProvider>(context, listen: false)
                .removeById(scanId);
            Navigator.pop(context, true);
          },
          child: const Text(
            'Confirm',
            style: TextStyle(color: Colors.red),
          ),
        ),
      ],
    );
  }

  Widget _getRenameAlert(BuildContext context, Scan scan) {
    String enteredText = '';
    TextEditingController controller =
        TextEditingController(text: scan.description);

    return AlertDialog(
      title: const Text("Rename description"),
      content: TextField(
        controller: controller,
        onChanged: (description) => enteredText = description,
      ),
      actions: [
        TextButton(
          onPressed: () async {
            await Provider.of<ScansProvider>(context, listen: false)
                .update(scan.id.toString(), enteredText);
            Navigator.pop(context, false);
          },
          child: const Text('Save'),
        ),
      ],
    );
  }

  String _getTitle(Scan scan) {
    if (scan.description != '') return scan.description;

    return scan.value.length > 30
        ? '${scan.value.substring(0, 30)}...'
        : scan.value;
  }
}
