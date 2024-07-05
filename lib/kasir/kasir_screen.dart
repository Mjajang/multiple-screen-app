import 'package:flutter/material.dart';
import 'package:presentation_displays/displays_manager.dart';
import 'package:provider/provider.dart';

import '../models/barang.dart';
import '../provider/barang.dart';

class KasirScreen extends StatefulWidget {
  const KasirScreen({super.key});

  @override
  State<KasirScreen> createState() => _KasirScreenState();
}

class _KasirScreenState extends State<KasirScreen> {
  DisplayManager displayManager = DisplayManager();

  @override
  void initState() {
    displayManager.connectedDisplaysChangedStream?.listen(
      (event) {
        debugPrint("connected displays changed: $event");
      },
    );

    showDisplayCustomer();

    super.initState();
  }

  Future<void> showDisplayCustomer() async {
    final values = await displayManager.getDisplays();
    // print("id display: ${values![1].displayId}");
    if (values != null && values.length > 1) {
      displayManager.showSecondaryDisplay(
        displayId: values[1].displayId!,
        routerName: "customer",
      );
    }
  }

  Future<void> transferDataToCustomer(List<Barang> barangList) async {
    await displayManager.transferDataToPresentation(
      barangList.map((barang) => barang.toJson()).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final barangProvider = Provider.of<BarangProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Kasir'),
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () async {
              barangProvider.tambahBarang(
                Barang(nama: 'Barang Baru', harga: 10000),
              );
              await transferDataToCustomer(barangProvider.barangList);
            },
            child: const Text('Tambah Barang'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: barangProvider.barangList.length,
              itemBuilder: (context, index) {
                final barang = barangProvider.barangList[index];
                return ListTile(
                  title: Text(barang.nama),
                  subtitle: Text(
                      'Harga: ${barang.harga}, Kuantitas: ${barang.kuantitas}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.remove),
                        onPressed: () async {
                          if (barang.kuantitas > 1) {
                            barangProvider.updateKuantitas(
                                barang, barang.kuantitas - 1);
                          } else {
                            barangProvider.kurangiBarang(barang);
                          }
                          await transferDataToCustomer(
                              barangProvider.barangList);
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: () async {
                          barangProvider.updateKuantitas(
                              barang, barang.kuantitas + 1);

                          await transferDataToCustomer(
                              barangProvider.barangList);
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
