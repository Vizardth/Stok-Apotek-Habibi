class Produkobat {
  late String id;
  final String satuan;
  final String nama;
  final int stok;
  final double harga;

  Produkobat({
    this.id = '',
    required this.satuan,
    required this.nama,
    required this.stok,
    required this.harga,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'satuan_produk': satuan,
    'nama_produk': nama,
    'jumlah_produk': stok,
    'harga_produk': harga,
  };

  static Produkobat fromJson(Map<String, dynamic> json) => Produkobat(
    satuan: json['satuan_produk'],
    nama: json['nama_produk'],
    stok: json['jumlah_produk'],
    harga: json['harga_produk'],
  );
}