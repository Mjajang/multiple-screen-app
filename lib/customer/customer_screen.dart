import 'package:flutter/material.dart';
import 'package:multiple_screen_app/models/barang.dart';
import 'package:presentation_displays/secondary_display.dart';

class CustomerScreen extends StatefulWidget {
  const CustomerScreen({super.key});

  @override
  State<CustomerScreen> createState() => _CustomerScreenState();
}

class _CustomerScreenState extends State<CustomerScreen> {
  List<Barang> barangList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Customer'),
      ),
      body: SecondaryDisplay(
        callback: (argument) {
          setState(() {
            if (argument is List) {
              barangList = argument.map((e) => Barang.fromJson(e)).toList();
            }
          });
        },
        child: ListView.builder(
          itemCount: barangList.length,
          itemBuilder: (context, index) {
            final barang = barangList[index];
            return ListTile(
              title: Text(barang.nama),
              subtitle: Text(
                  'Harga: ${barang.harga}, Kuantitas: ${barang.kuantitas}, Jumlah: ${barang.jumlah}'),
            );
          },
        ),
      ),
    );
  }
}
