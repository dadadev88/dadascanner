import 'package:dadascanner/screens/map_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:provider/provider.dart';

import 'package:dadascanner/widgets/widgets.dart';
import 'package:dadascanner/providers/providers.dart';
import 'package:dadascanner/utils/url_utils.dart';
import 'package:dadascanner/models/scan_model.dart';

class HomeScreen extends StatelessWidget {
  static String routeName = 'Home';
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    UIProvider uiProvider = Provider.of<UIProvider>(context);
    ScansProvider scansProvider = Provider.of<ScansProvider>(
      context,
      listen: false,
    );

    return Scaffold(
      drawer: const Sidebar(),
      appBar: AppBar(title: const Text('DADA Scanner'), actions: [
        IconButton(
          onPressed: () => scansProvider.removeByType(),
          icon: const Icon(Icons.delete_forever),
        )
      ]),
      body: _HomeBody(uiProvider: uiProvider),
      bottomNavigationBar: _CustomNavigationBar(
        uiProvider: uiProvider,
        scansProvider: scansProvider,
      ),
      floatingActionButton: _CustomFloatingButton(uiProvider: uiProvider),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

class _CustomFloatingButton extends StatelessWidget {
  final UIProvider uiProvider;

  const _CustomFloatingButton({required this.uiProvider});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      elevation: 0,
      child: const Icon(Icons.qr_code_rounded),
      onPressed: () async {
        String scanData = await FlutterBarcodeScanner.scanBarcode(
            '#fff', 'Cancelar', true, ScanMode.BARCODE);
        // String scanData = '-12.121510,-77.028047';

        if (scanData != '-1') {
          this.handleNewScan(scanData, context);
        }
      },
    );
  }

  void handleNewScan(String scanData, BuildContext context) async {
    ScansProvider scanProvider =
        Provider.of<ScansProvider>(context, listen: false);

    Scan newScan = Scan(value: scanData);
    await scanProvider.create(newScan);
    uiProvider.setCurrentFromScan = newScan.type!;

    if (newScan.type == 'URL') {
      URLUtils.openURL(newScan.value);
    } else {
      Navigator.pushNamed(context, MapScreen.routeName, arguments: newScan);
    }
  }
}

class _CustomNavigationBar extends StatelessWidget {
  final UIProvider uiProvider;
  final ScansProvider scansProvider;

  const _CustomNavigationBar({
    required this.scansProvider,
    required this.uiProvider,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: uiProvider.currentNavBarIndex,
      onTap: (int index) {
        uiProvider.setCurrentNavBarIndex = index;
        scansProvider.changeCurrentType =
            uiProvider.currentNavBarIndex == 0 ? 'LOCATION' : 'URL';
      },
      items: const [
        BottomNavigationBarItem(
          label: 'Locations',
          icon: Icon(Icons.my_location_sharp),
        ),
        BottomNavigationBarItem(
          label: 'URLs',
          icon: Icon(Icons.travel_explore_rounded),
        )
      ],
    );
  }
}

class _HomeBody extends StatelessWidget {
  final int locationsButtonIndex = 0;
  final UIProvider uiProvider;

  const _HomeBody({required this.uiProvider});

  @override
  Widget build(BuildContext context) {
    ScansProvider provider = Provider.of<ScansProvider>(context, listen: false);

    if (uiProvider.currentNavBarIndex == locationsButtonIndex) {
      provider.getScansByType('LOCATION');
      return const LocationsContent();
    }

    provider.getScansByType('URL');
    return const URLAddressContent();
  }
}
