import 'package:flutter/material.dart';
import '../model/buku.dart'; // Sesuaikan dengan import yang benar
import '../service/buku_service.dart'; // Sesuaikan dengan import yang benar
import 'buku_detail.dart'; // Sesuaikan dengan import yang benar

class BukuUpdateForm extends StatefulWidget {
  final Buku buku;

  const BukuUpdateForm({Key? key, required this.buku}) : super(key: key);

  @override
  _BukuUpdateFormState createState() => _BukuUpdateFormState();
}

class _BukuUpdateFormState extends State<BukuUpdateForm> {
  final _formKey = GlobalKey<FormState>();
  final _isbnCtrl = TextEditingController();
  final _judulCtrl = TextEditingController();
  final _penulisCtrl = TextEditingController();
  final _penerbitCtrl = TextEditingController();

  Future<Buku> getData() async {
    Buku data = await BukuService().getById(widget.buku.id!);
    setState(() {
      _isbnCtrl.text = data.isbn;
      _judulCtrl.text = data.judul;
      _penulisCtrl.text = data.penulis;
      _penerbitCtrl.text = data.penerbit;
    });
    return data;
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Ubah Buku")),
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
    );
  }

  Widget _fieldJudul() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Judul"),
      controller: _judulCtrl,
    );
  }

  Widget _fieldPenulis() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Penulis"),
      controller: _penulisCtrl,
    );
  }

  Widget _fieldPenerbit() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Penerbit"),
      controller: _penerbitCtrl,
    );
  }

  Widget _tombolSimpan() {
    return ElevatedButton(
      onPressed: () async {
        Buku buku = Buku(
          id: widget.buku.id,
          isbn: _isbnCtrl.text,
          judul: _judulCtrl.text,
          penulis: _penulisCtrl.text,
          penerbit: _penerbitCtrl.text,
        );

        await BukuService().ubah(buku, widget.buku.id!).then((value) {
          Navigator.pop(context);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => BukuDetail(buku: value),
            ),
          );
        });
      },
      child: const Text("Simpan Perubahan"),
    );
  }
}
