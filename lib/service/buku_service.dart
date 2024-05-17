import 'package:dio/dio.dart';
import '../helpers/api_client.dart';
import '../model/buku.dart';

class BukuService {
  Future<List<Buku>> listData() async {
    try {
      final Response response = await ApiClient().get('buku');
      final List data = response.data as List;
      List<Buku> result = data.map((json) => Buku.fromJson(json)).toList();
      return result;
    } catch (e) {
      throw Exception('Failed to fetch data: $e');
    }
  }

  Future<Buku> simpan(Buku buku) async {
    try {
      var data = buku.toJson();
      final Response response = await ApiClient().post('buku', data);
      Buku result = Buku.fromJson(response.data);
      return result;
    } catch (e) {
      throw Exception('Failed to save data: $e');
    }
  }

  Future<Buku> ubah(Buku buku, String id) async {
    try {
      var data = buku.toJson();
      final Response response = await ApiClient().put('buku/$id', data);
      Buku result = Buku.fromJson(response.data);
      return result;
    } catch (e) {
      throw Exception('Failed to update data: $e');
    }
  }

  Future<Buku> getById(String id) async {
    try {
      final Response response = await ApiClient().get('buku/$id');
      Buku result = Buku.fromJson(response.data);
      return result;
    } catch (e) {
      throw Exception('Failed to fetch data: $e');
    }
  }

  Future<Buku> hapus(Buku buku) async {
    try {
      final Response response = await ApiClient().delete('buku/${buku.id}');
      Buku result = Buku.fromJson(response.data);
      return result;
    } catch (e) {
      throw Exception('Failed to delete data: $e');
    }
  }
}
