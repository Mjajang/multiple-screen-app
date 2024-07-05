import 'package:flutter/foundation.dart';
import 'package:multiple_screen_app/models/barang.dart';

class BarangProvider with ChangeNotifier {
  final List<Barang> _barangList = [];

  List<Barang> get barangList => _barangList;

  void tambahBarang(Barang barang) {
    _barangList.add(barang);
    notifyListeners();
  }

  void kurangiBarang(Barang barang) {
    _barangList.remove(barang);
    notifyListeners();
  }

  void updateKuantitas(Barang barang, int kuantitas) {
    int index = _barangList.indexOf(barang);
    if (index != -1) {
      _barangList[index].kuantitas = kuantitas;
      notifyListeners();
    }
  }
}
