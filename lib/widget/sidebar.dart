import 'package:flutter/material.dart';
import '../ui/beranda.dart';
import '../ui/login.dart'; // Sesuaikan dengan path yang benar
import '../ui/peminjaman_page.dart'; // Sesuaikan dengan path yang benar
import '../ui/buku_page.dart'; // Sesuaikan dengan path yang benar

class Sidebar extends StatelessWidget {
  const Sidebar({Key? key}) : super(key: key);

  Future<void> _showLogoutConfirmation(BuildContext context) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Konfirmasi Keluar"),
          content: Text("Apakah Anda yakin ingin keluar?"),
          actions: <Widget>[
            TextButton(
              child: Text("Tidak"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text("Ya"),
              onPressed: () {
                // Ganti dengan navigasi kembali ke halaman login
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                  (route) => false,
                );
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text("Admin"),
            accountEmail: Text("admin@admin.com"),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text("Beranda"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Beranda()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.bar_chart_rounded),
            title: Text("Peminjaman"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PeminjamanPage()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.account_balance_wallet_rounded),
            title: Text("Buku"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => BukuPage()),
              );
            },
          ),
          // Tambahkan ListTile lain yang diperlukan
          ListTile(
            leading: Icon(Icons.logout_rounded),
            title: Text("Keluar"),
            onTap: () {
              _showLogoutConfirmation(context);
            },
          ),
        ],
      ),
    );
  }
}
