import 'package:flutter/material.dart';
import '../model/peminjaman.dart';
import '../service/peminjaman_service.dart';
import 'peminjaman_detail.dart';

class PeminjamanForm extends StatefulWidget {
  const PeminjamanForm({Key? key}) : super(key: key);
  @override
  _PeminjamanFormState createState() => _PeminjamanFormState();
}

class _PeminjamanFormState extends State<PeminjamanForm> {
  final _formKey = GlobalKey<FormState>();
  final _namaCtrl = TextEditingController();
  final _judulBukuCtrl = TextEditingController();
  final _tanggalPinjamCtrl = TextEditingController();
  final _tanggalKembaliCtrl = TextEditingController();
  final _noTelephoneCtrl = TextEditingController();

  Future<void> _selectDate(
      BuildContext context, TextEditingController controller) async {
    final DateTime picked = (await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    ))!;
    if (picked != null && picked != DateTime.now()) {
      setState(() {
        controller.text =
            picked.toString().split(' ')[0]; // Format tanggal dapat disesuaikan
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Tambah Peminjaman")),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _fieldNama(),
              _fieldJudulBuku(),
              _buildDateField(_tanggalPinjamCtrl, "Tanggal Pinjam"),
              _buildDateField(_tanggalKembaliCtrl, "Tanggal Kembali"),
              _fieldNoTelephone(),
              SizedBox(height: 20),
              _tombolSimpan(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _fieldNama() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Nama"),
      controller: _namaCtrl,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Masukkan Nama';
        }
        return null;
      },
    );
  }

  Widget _fieldJudulBuku() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Judul Buku"),
      controller: _judulBukuCtrl,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Masukkan Judul Buku';
        }
        return null;
      },
    );
  }

  Widget _fieldNoTelephone() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "No Telephone"),
      controller: _noTelephoneCtrl,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Masukkan No Telephone';
        }
        return null;
      },
    );
  }

  Widget _buildDateField(TextEditingController controller, String labelText) {
    return GestureDetector(
      onTap: () => _selectDate(context, controller),
      child: AbsorbPointer(
        child: TextFormField(
          decoration: InputDecoration(
            labelText: labelText,
            suffixIcon: Icon(Icons.calendar_today),
          ),
          controller: controller,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Masukkan $labelText';
            }
            return null;
          },
        ),
      ),
    );
  }

  Widget _tombolSimpan() {
    return ElevatedButton(
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          Peminjaman peminjaman = Peminjaman(
            nama: _namaCtrl.text,
            judulBuku: _judulBukuCtrl.text,
            tanggalPinjam: _tanggalPinjamCtrl.text,
            tanggalKembali: _tanggalKembaliCtrl.text,
            noTelephone: _noTelephoneCtrl.text,
          );
          PeminjamanService().simpan(peminjaman).then((value) {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text('Sukses'),
                  content: const Text('Data peminjaman berhasil ditambahkan!'),
                  actions: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                PeminjamanDetail(peminjaman: value),
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
