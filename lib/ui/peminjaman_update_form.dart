import 'package:flutter/material.dart';
import '../model/peminjaman.dart'; // Sesuaikan dengan import yang benar
import '../service/peminjaman_service.dart'; // Sesuaikan dengan import yang benar
import 'peminjaman_detail.dart'; // Sesuaikan dengan import yang benar

class PeminjamanUpdateForm extends StatefulWidget {
  final Peminjaman peminjaman;

  const PeminjamanUpdateForm({Key? key, required this.peminjaman})
      : super(key: key);

  @override
  _PeminjamanUpdateFormState createState() => _PeminjamanUpdateFormState();
}

class _PeminjamanUpdateFormState extends State<PeminjamanUpdateForm> {
  final _formKey = GlobalKey<FormState>();
  final _namaCtrl = TextEditingController();
  final _judulBukuCtrl = TextEditingController();
  final _tanggalPinjamCtrl = TextEditingController();
  final _tanggalKembaliCtrl = TextEditingController();
  final _noTelephoneCtrl = TextEditingController();

  Future<Peminjaman> getData() async {
    Peminjaman data = await PeminjamanService().getById(widget.peminjaman.id!);
    setState(() {
      _namaCtrl.text = data.nama;
      _judulBukuCtrl.text = data.judulBuku;
      _tanggalPinjamCtrl.text = data.tanggalPinjam;
      _tanggalKembaliCtrl.text = data.tanggalKembali;
      _noTelephoneCtrl.text = data.noTelephone;
    });
    return data;
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> _selectDate(
      BuildContext context, TextEditingController controller) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      initialDatePickerMode: DatePickerMode.day, // Hanya tampilkan tanggal
    );
    if (picked != null) {
      setState(() {
        controller.text = picked.toString().substring(0, 10);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Ubah Peminjaman")),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _fieldNama(),
              _fieldJudulBuku(),
              _fieldTanggalPinjam(),
              _fieldTanggalKembali(),
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
    );
  }

  Widget _fieldJudulBuku() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Judul Buku"),
      controller: _judulBukuCtrl,
    );
  }

  Widget _fieldTanggalPinjam() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: "Tanggal Pinjam",
        suffixIcon: InkWell(
          onTap: () => _selectDate(context, _tanggalPinjamCtrl),
          child: Icon(Icons.calendar_today), // Icon kalender di sebelah kanan
        ),
      ),
      controller: _tanggalPinjamCtrl,
      onTap: () => _selectDate(context, _tanggalPinjamCtrl),
      readOnly: true, // Membuat input tidak bisa diedit
    );
  }

  Widget _fieldTanggalKembali() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: "Tanggal Kembali",
        suffixIcon: InkWell(
          onTap: () => _selectDate(context, _tanggalKembaliCtrl),
          child: Icon(Icons.calendar_today), // Icon kalender di sebelah kanan
        ),
      ),
      controller: _tanggalKembaliCtrl,
      onTap: () => _selectDate(context, _tanggalKembaliCtrl),
      readOnly: true, // Membuat input tidak bisa diedit
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

  Widget _tombolSimpan() {
    return ElevatedButton(
      onPressed: () async {
        Peminjaman peminjaman = Peminjaman(
          id: widget.peminjaman.id,
          nama: _namaCtrl.text,
          judulBuku: _judulBukuCtrl.text,
          tanggalPinjam: _tanggalPinjamCtrl.text,
          tanggalKembali: _tanggalKembaliCtrl.text,
          noTelephone: _noTelephoneCtrl.text,
        );

        await PeminjamanService()
            .ubah(peminjaman, widget.peminjaman.id!)
            .then((value) {
          Navigator.pop(context);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => PeminjamanDetail(peminjaman: value),
            ),
          );
        });
      },
      child: const Text("Simpan Perubahan"),
    );
  }
}
