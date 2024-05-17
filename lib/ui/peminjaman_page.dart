import 'package:flutter/material.dart';
import '../model/peminjaman.dart'; // Sesuaikan dengan import yang benar
import '../service/peminjaman_service.dart'; // Sesuaikan dengan import yang benar
import 'peminjaman_detail.dart'; // Sesuaikan dengan import yang benar
import 'peminjaman_form.dart'; // Sesuaikan dengan import yang benar
import 'peminjaman_item.dart'; // Sesuaikan dengan import yang benar
import '../widget/sidebar.dart';

class PeminjamanPage extends StatefulWidget {
  const PeminjamanPage({Key? key}) : super(key: key);
  _PeminjamanPageState createState() => _PeminjamanPageState();
}

class _PeminjamanPageState extends State<PeminjamanPage> {
  Stream<List<Peminjaman>> getList() async* {
    List<Peminjaman> data = await PeminjamanService().listData();
    yield data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Sidebar(),
      appBar: AppBar(
        title: const Text("Data Peminjam"),
        actions: [
          GestureDetector(
            child: const Icon(Icons.add),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PeminjamanForm()),
              );
            },
          )
        ],
      ),
      body: StreamBuilder(
        stream: getList(),
        builder: (context, AsyncSnapshot snapshot) {
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
            return Text('Data Kosong');
          }

          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (context, index) {
              return PeminjamanItem(peminjaman: snapshot.data[index]);
            },
          );
        },
      ),
    );
  }
}
