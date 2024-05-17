import 'package:flutter/material.dart';
import '../service/buku_service.dart';
import 'buku_page.dart';
import 'buku_update_form.dart';
import '../model/buku.dart';

class BukuDetail extends StatefulWidget {
  final Buku buku;

  const BukuDetail({Key? key, required this.buku}) : super(key: key);

  @override
  _BukuDetailState createState() => _BukuDetailState();
}

class _BukuDetailState extends State<BukuDetail> {
  late Stream<Buku> _dataStream;

  @override
  void initState() {
    super.initState();
    _dataStream = getData();
  }

  Stream<Buku> getData() async* {
    Buku data = await BukuService().getById(widget.buku.id.toString());
    yield data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Detail Buku")),
      body: StreamBuilder<Buku>(
        stream: _dataStream,
        builder: (context, AsyncSnapshot<Buku> snapshot) {
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
          final buku = snapshot.data!;

          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildDetailItem("ISBN", buku.isbn),
                _buildDetailItem("Judul Buku", buku.judul),
                _buildDetailItem("Penulis", buku.penulis),
                _buildDetailItem("Penerbit", buku.penerbit),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _tombolUbah(buku),
                    _tombolHapus(buku),
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

  Widget _tombolUbah(Buku buku) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BukuUpdateForm(buku: buku),
          ),
        );
      },
      style: ElevatedButton.styleFrom(primary: Colors.green),
      child: const Text("Ubah"),
    );
  }

  Widget _tombolHapus(Buku buku) {
    return ElevatedButton(
      onPressed: () {
        AlertDialog alertDialog = AlertDialog(
          content: const Text("Yakin ingin menghapus data ini?"),
          actions: [
            ElevatedButton(
              onPressed: () async {
                await BukuService().hapus(buku).then((value) {
                  Navigator.pop(context);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BukuPage(),
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
