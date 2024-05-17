import 'package:flutter/material.dart';
import '../service/peminjaman_service.dart';
import 'peminjaman_page.dart';
import 'peminjaman_update_form.dart';
import '../model/peminjaman.dart';

class PeminjamanDetail extends StatefulWidget {
  final Peminjaman peminjaman;

  const PeminjamanDetail({Key? key, required this.peminjaman})
      : super(key: key);

  @override
  _PeminjamanDetailState createState() => _PeminjamanDetailState();
}

class _PeminjamanDetailState extends State<PeminjamanDetail> {
  late Stream<Peminjaman> _dataStream;

  @override
  void initState() {
    super.initState();
    _dataStream = getData();
  }

  Stream<Peminjaman> getData() async* {
    Peminjaman data =
        await PeminjamanService().getById(widget.peminjaman.id.toString());
    yield data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Detail Peminjaman")),
      body: StreamBuilder<Peminjaman>(
        stream: _dataStream,
        builder: (context, AsyncSnapshot<Peminjaman> snapshot) {
          if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          if (snapshot.connectionState != ConnectionState.done) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (!snapshot.hasData &&
              snapshot.connectionState == ConnectionState.done) {
            return Text('Data Tidak Ditemukan');
          }
          final peminjaman = snapshot.data!;

          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildDetailItem("Nama", peminjaman.nama),
                _buildDetailItem("Judul Buku", peminjaman.judulBuku),
                _buildDetailItem("Tanggal Pinjam", peminjaman.tanggalPinjam),
                _buildDetailItem("Tanggal Kembali", peminjaman.tanggalKembali),
                _buildDetailItem("No Telephone", peminjaman.noTelephone),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _tombolUbah(peminjaman),
                    _tombolHapus(peminjaman),
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildDetailItem(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(fontSize: 16),
        ),
        Divider(),
        SizedBox(height: 10),
      ],
    );
  }

  Widget _tombolUbah(Peminjaman peminjaman) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PeminjamanUpdateForm(peminjaman: peminjaman),
          ),
        );
      },
      style: ElevatedButton.styleFrom(primary: Colors.green),
      child: const Text("Ubah"),
    );
  }

  Widget _tombolHapus(Peminjaman peminjaman) {
    return ElevatedButton(
      onPressed: () {
        AlertDialog alertDialog = AlertDialog(
          content: const Text("Yakin ingin menghapus data ini?"),
          actions: [
            ElevatedButton(
              onPressed: () async {
                await PeminjamanService().hapus(peminjaman).then((value) {
                  Navigator.pop(context);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PeminjamanPage(),
                    ),
                  );
                });
              },
              child: const Text("YA"),
              style: ElevatedButton.styleFrom(primary: Colors.red),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Tidak"),
              style: ElevatedButton.styleFrom(primary: Colors.green),
            )
          ],
        );
        showDialog(context: context, builder: (context) => alertDialog);
      },
      style: ElevatedButton.styleFrom(primary: Colors.red),
      child: const Text("Hapus"),
    );
  }
}
