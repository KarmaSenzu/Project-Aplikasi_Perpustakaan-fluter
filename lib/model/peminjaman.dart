class Peminjaman {
  String? id;
  String nama;
  String judulBuku;
  String tanggalPinjam;
  String tanggalKembali;
  String noTelephone;

  Peminjaman({
    this.id,
    required this.nama,
    required this.judulBuku,
    required this.tanggalPinjam,
    required this.tanggalKembali,
    required this.noTelephone,
  });

  factory Peminjaman.fromJson(Map<String, dynamic> json) {
    return Peminjaman(
      id: json['id'] as String?,
      nama: json['nama'] as String,
      judulBuku: json['judul_buku'] as String,
      tanggalPinjam: json['tanggal_pinjam'] as String,
      tanggalKembali: json['tanggal_kembali'] as String,
      noTelephone: json['no_telephone'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'nama': this.nama,
      'judul_buku': this.judulBuku,
      'tanggal_pinjam': this.tanggalPinjam,
      'tanggal_kembali': this.tanggalKembali,
      'no_telephone': this.noTelephone,
    };
    if (this.id != null) {
      data['id'] = this.id;
    }
    return data;
  }
}
