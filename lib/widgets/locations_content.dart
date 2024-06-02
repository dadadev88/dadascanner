import 'package:dadascanner/providers/scans_providers.dart';
import 'package:dadascanner/screens/map_screen.dart';
import 'package:dadascanner/widgets/scan_list_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LocationsContent extends StatelessWidget {
  const LocationsContent({super.key});

  @override
  Widget build(BuildContext context) {
    final ScansProvider provider = Provider.of<ScansProvider>(context);

    return ScanListItem(
      scans: provider.scans,
      icon: Icons.gps_fixed,
      onTap: (scan) {
        Navigator.pushNamed(context, MapScreen.routeName, arguments: scan);
      },
    );
  }
}
