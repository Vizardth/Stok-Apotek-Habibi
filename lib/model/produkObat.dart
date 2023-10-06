class Produkobat {
  late String id;
  final String satuan;
  final String nama;
  final int stok;
  final double hargabeli;
  final double hargajual;

  Produkobat({
    this.id = '',
    required this.satuan,
    required this.nama,
    required this.stok,
    required this.hargabeli,
    required this.hargajual,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'satuan_produk': satuan,
    'nama_produk': nama,
    'jumlah_produk': stok,
    'hargabeli_produk': hargabeli,
    'hargajual_produk' : hargajual,
  };

  static Produkobat fromJson(Map<String, dynamic> json) => Produkobat(
    satuan: json['satuan_produk'],
    nama: json['nama_produk'],
    stok: json['jumlah_produk'],
    hargabeli: json['hargabeli_produk'],
    hargajual: json['hargajual_produk'],
  );
}

class KeranjangProduk {
  final String nama;
  int? stok;
  String? satuan;
  double? hargajual;
  double? hargabeli;
  int? jumlahproduksementara;

  KeranjangProduk({
    required this.nama,
    this.stok,
    this.hargajual,
    this.hargabeli,
    this.satuan,
    this.jumlahproduksementara,
  });

  Map<String, dynamic> toJson() => {
    'nama_produk': nama,
    'jumlah_produk': stok,
    'hargajual_produk': hargajual,
    'hargabeli_produk': hargabeli,
  };

  static KeranjangProduk fromJson(Map<String, dynamic> json) => KeranjangProduk(
    nama: json['nama_produk'],
    stok: json['jumlah_produk'],
    hargajual: json['hargajual_produk'],
    hargabeli: json['hargabeli_produk'],
  );
}