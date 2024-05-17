import 'package:flutter/material.dart';
import '../model/buku.dart';
import '../service/buku_service.dart';
import 'buku_detail.dart';

class BukuForm extends StatefulWidget {
  const BukuForm({Key? key}) : super(key: key);
  @override
  _BukuFormState createState() => _BukuFormState();
}

class _BukuFormState extends State<BukuForm> {
  final _formKey = GlobalKey<FormState>();
  final _isbnCtrl = TextEditingController();
  final _judulCtrl = TextEditingController();
  final _penulisCtrl = TextEditingController();
  final _penerbitCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Tambah Buku")),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _fieldISBN(),
              _fieldJudul(),
              _fieldPenulis(),
              _fieldPenerbit(),
              SizedBox(height: 20),
              _tombolSimpan(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _fieldISBN() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "ISBN"),
      controller: _isbnCtrl,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Masukkan ISBN';
        }
        return null;
      },
    );
  }

  Widget _fieldJudul() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Judul"),
      controller: _judulCtrl,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Masukkan Judul';
        }
        return null;
      },
    );
  }

  Widget _fieldPenulis() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Penulis"),
      controller: _penulisCtrl,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Masukkan Penulis';
        }
        return null;
      },
    );
  }

  Widget _fieldPenerbit() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Penerbit"),
      controller: _penerbitCtrl,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Masukkan Penerbit';
        }
        return null;
      },
    );
  }

  Widget _tombolSimpan() {
    return ElevatedButton(
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          Buku buku = Buku(
            isbn: _isbnCtrl.text,
            judul: _judulCtrl.text,
            penulis: _penulisCtrl.text,
            penerbit: _penerbitCtrl.text,
          );
          BukuService().simpan(buku).then((value) {
            // Menampilkan pesan sukses jika berhasil menyimpan
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text('Sukses'),
                  content: const Text('Data buku berhasil ditambahkan!'),
                  actions: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BukuDetail(buku: value),
                          ),
                        );
                      },
                      child: const Text('OK'),
                    ),
                  ],
                );
              },
            );
          });
        }
      },
      child: const Text("Simpan"),
    );
  }
}
