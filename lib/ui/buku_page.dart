import 'package:flutter/material.dart';
import '../model/buku.dart'; // Ganti dengan import yang benar
import '../service/buku_service.dart'; // Ganti dengan import yang benar
import 'buku_detail.dart'; // Ganti dengan import yang benar
import 'buku_form.dart'; // Ganti dengan import yang benar
import 'buku_item.dart'; // Ganti dengan import yang benar
import '../widget/sidebar.dart';

class BukuPage extends StatefulWidget {
  const BukuPage({Key? key}) : super(key: key);

  @override
  _BukuPageState createState() => _BukuPageState();
}

class _BukuPageState extends State<BukuPage> {
  late Stream<List<Buku>> _dataStream;

  @override
  void initState() {
    super.initState();
    _dataStream = getList();
  }

  Stream<List<Buku>> getList() async* {
    List<Buku> data = await BukuService().listData();
    yield data;
  }

  Future<void> _refreshData() async {
    setState(() {
      _dataStream = getList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Sidebar(),
      appBar: AppBar(
        title: const Text("Data Buku"),
        actions: [
          GestureDetector(
            child: const Icon(Icons.add),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => BukuForm()),
              );
            },
          )
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _refreshData,
        child: StreamBuilder<List<Buku>>(
          stream: _dataStream,
          builder: (context, AsyncSnapshot<List<Buku>> snapshot) {
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
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return BukuItem(buku: snapshot.data![index]);
              },
            );
          },
        ),
      ),
    );
  }
}
