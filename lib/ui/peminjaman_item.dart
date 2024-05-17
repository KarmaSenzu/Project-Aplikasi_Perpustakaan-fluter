import 'package:flutter/material.dart';
import '../model/peminjaman.dart'; // Sesuaikan dengan import yang benar
import 'peminjaman_detail.dart'; // Sesuaikan dengan import yang benar

class PeminjamanItem extends StatelessWidget {
  final Peminjaman peminjaman;

  const PeminjamanItem({Key? key, required this.peminjaman}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Card(
        child: ListTile(
          title: Text(
              "${peminjaman.nama}"), // Sesuaikan dengan field yang sesuai di model Peminjaman
        ),
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PeminjamanDetail(
                peminjaman: peminjaman), // Sesuaikan dengan model yang benar
          ),
        );
      },
    );
  }
}
