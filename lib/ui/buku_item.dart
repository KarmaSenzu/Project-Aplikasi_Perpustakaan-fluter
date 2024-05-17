import 'package:flutter/material.dart';
import '../model/buku.dart'; // Sesuaikan dengan import yang benar
import 'buku_detail.dart'; // Sesuaikan dengan import yang benar

class BukuItem extends StatelessWidget {
  final Buku buku;

  const BukuItem({Key? key, required this.buku}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Card(
        child: ListTile(
          title: Text(
              "${buku.judul}"), // Sesuaikan dengan field yang sesuai di model Buku
        ),
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                BukuDetail(buku: buku), // Sesuaikan dengan model yang benar
          ),
        );
      },
    );
  }
}
