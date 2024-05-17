import 'package:dio/dio.dart';
import '../helpers/api_client.dart';
import '../model/peminjaman.dart';

class PeminjamanService {
  Future<List<Peminjaman>> listData() async {
    final Response response = await ApiClient().get('peminjaman');
    final List data = response.data as List;
    List<Peminjaman> result =
        data.map((json) => Peminjaman.fromJson(json)).toList();
    return result;
  }

  Future<Peminjaman> simpan(Peminjaman peminjaman) async {
    var data = peminjaman.toJson();
    final Response response = await ApiClient().post('peminjaman', data);
    Peminjaman result = Peminjaman.fromJson(response.data);
    return result;
  }

  Future<Peminjaman> ubah(Peminjaman peminjaman, String id) async {
    var data = peminjaman.toJson();
    final Response response = await ApiClient().put('peminjaman/$id', data);
    Peminjaman result = Peminjaman.fromJson(response.data);
    return result;
  }

  Future<Peminjaman> getById(String id) async {
    final Response response = await ApiClient().get('peminjaman/$id');
    Peminjaman result = Peminjaman.fromJson(response.data);
    return result;
  }

  Future<Peminjaman> hapus(Peminjaman peminjaman) async {
    final Response response =
        await ApiClient().delete('peminjaman/${peminjaman.id}');
    Peminjaman result = Peminjaman.fromJson(response.data);
    return result;
  }
}
