import 'package:dadascanner/providers/scans_providers.dart';
import 'package:dadascanner/utils/url_utils.dart';
import 'package:dadascanner/widgets/scan_list_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class URLAddressContent extends StatelessWidget {
  const URLAddressContent({super.key});

  @override
  Widget build(BuildContext context) {
    final ScansProvider provider = Provider.of<ScansProvider>(context);

    return ScanListItem(
      icon: Icons.travel_explore_rounded,
      scans: provider.scans,
      onTap: (scan) {
        URLUtils.openURL(scan.value);
      },
    );
  }
}
