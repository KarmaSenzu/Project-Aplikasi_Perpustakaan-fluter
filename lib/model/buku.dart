class Buku {
  String? id;
  String isbn;
  String judul;
  String penulis;
  String penerbit;

  Buku({
    this.id,
    required this.isbn,
    required this.judul,
    required this.penulis,
    required this.penerbit,
  });

  factory Buku.fromJson(Map<String, dynamic> json) {
    return Buku(
      id: json['id'] as String?,
      isbn: json['isbn'] as String,
      judul: json['judul'] as String,
      penulis: json['penulis'] as String,
      penerbit: json['penerbit'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'isbn': this.isbn,
      'judul': this.judul,
      'penulis': this.penulis,
      'penerbit': this.penerbit,
    };
    if (this.id != null) {
      data['id'] = this.id;
    }
    return data;
  }
}
