import 'package:flutter/material.dart';
import '../widget/sidebar.dart';

class Beranda extends StatelessWidget {
  const Beranda({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Sidebar(),
      appBar: AppBar(
        title: Text("Beranda"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Selamat Datang di Aplikasi Perpustakaan Taruna Boys !",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            SizedBox(height: 20),
            Text(
              "Aplikasi ini memudahkan Anda dalam mengelola Data Buku dan Data Peminjaman.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            SizedBox(height: 10),
            Text(
              "Silakan pilih menu di sebelah kiri untuk memulai.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
