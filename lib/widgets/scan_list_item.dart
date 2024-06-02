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
      return const Center(child: Text('Scans no founded'));
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
            child:
                const Row(mainAxisAlignment: MainAxisAlignment.end, children: [
              Text('Rename', style: TextStyle(color: Colors.white)),
              Icon(Icons.note_alt, color: Colors.white),
              SizedBox(width: 20)
            ]),
          ),
          confirmDismiss: (direction) async {
            ScaffoldMessenger.of(context).clearSnackBars();
            if (direction == DismissDirection.startToEnd) {
              showDialog<bool>(
                  context: context,
                  builder: (_) => _getDeleteAlert(context, scan.id!));
            }
            if (direction == DismissDirection.endToStart) {
              showDialog<bool>(
                  context: context,
                  builder: (_) => _getRenameAlert(context, scan.id!));
              return false;
            }
          },
          child: ListTile(
            leading: Icon(this.icon, color: AppColors.primary),
            title: Text(title),
            subtitle:
                Text('ID: ${scan.id}', style: const TextStyle(fontSize: 12)),
            onTap: () => this.onTap(this.scans[i]),
            trailing: const Icon(Icons.keyboard_arrow_right_rounded),
          ),
        );
      },
    );
  }

  Widget _getDeleteAlert(BuildContext context, int scanId) => AlertDialog(
    title: const Text("Confirm that you want delete item"),
    actions: [
      TextButton( onPressed: () => Navigator.pop(context, false), child: const Text('Cancel')),
      TextButton(
        onPressed: () async {
          await Provider.of<ScansProvider>(context, listen: false)
              .removeById(scanId);
          Navigator.pop(context, true);
        },
        child: const Text( 'Confirm', style: TextStyle(color: Colors.red), )
      ),
    ],
  );

  Widget _getRenameAlert(BuildContext context, int scanId) {
    String enteredText = '';
    return AlertDialog(
      title: const Text("Insert description"),
      content: TextField(onChanged: (newText) {
        enteredText = newText;
      }),
      actions: [
        TextButton(
          onPressed: () async {
            await Provider.of<ScansProvider>(context, listen: false)
                .update(scanId.toString(), enteredText);
            Navigator.pop(context, false);
          },
          child: const Text('Save'),
        ),
      ],
    );
  }

  String _getTitle(Scan scan) {
    if (scan.description != '') return scan.description;

    return scan.value.length > 30 ? '${scan.value.substring(0, 30)}...' : scan.value;
  }
}
