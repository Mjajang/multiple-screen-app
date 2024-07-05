class Barang {
  String nama;
  double harga;
  int kuantitas;

  Barang({required this.nama, required this.harga, this.kuantitas = 1});

  double get jumlah => harga * kuantitas;

  factory Barang.fromJson(Map<String, dynamic> json) {
    return Barang(
      nama: json['nama'],
      harga: json['harga'],
      kuantitas: json['kuantitas'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nama': nama,
      'harga': harga,
      'kuantitas': kuantitas,
    };
  }
}
