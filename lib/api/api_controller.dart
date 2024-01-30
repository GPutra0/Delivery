import 'package:dio/dio.dart';

class ApiController {
  Future<List<dynamic>> getDatas() async {
    final response = await Dio().get('http://192.168.1.103/api.php');

    final datas = response.data['data'];
    return datas;
  }

  Future<List<dynamic>> getProductById(String id) async {
    final response = await Dio().get('http://192.168.1.103/api.php?id=${id}');

    final datas = response.data['data'];
    return datas;
  }

  Future<void> insertDataProduct(
      String nama, String harga, String promo, String gambar) async {
    try {
      final response = await Dio().post(
        'http://192.168.1.103/api.php',
        data: {
          'nama': nama,
          'harga': harga,
          'promo': promo,
          'gambar': gambar,
        },
        options: Options(
          headers: {
            'Content-Type': 'application/x-www-form-urlencoded',
          },
        ),
      );

      if (response.statusCode == 200) {
        print('Data posted successfully');
      } else {
        print('Failed to post data. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error posting data: $error');
    }
  }

  Future<void> updateDataProduct(
      String id, String nama, String harga, String promo, String gambar) async {
    try {
      final response = await Dio().post(
        'http://192.168.1.103/api.php?id=$id',
        data: {
          'nama': nama,
          'harga': harga,
          'promo': promo,
          'gambar': gambar,
        },
        options: Options(
          headers: {
            'Content-Type': 'application/x-www-form-urlencoded',
          },
        ),
      );

      if (response.statusCode == 200) {
        print('Data update successfully');
      } else {
        print('Failed to update data. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error updating data: $error');
    }
  }

  Future<void> deleteDataProduct(String id) async {
    try {
      final response =
          await Dio().delete('http://192.168.1.103/api.php?id=$id');

      if (response.statusCode == 200) {
        print('Data deleted successfully');
      } else {
        print('Failed to delete data. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error deleting data: $error');
    }
  }

  Future<List<dynamic>> getProvinces() async {
    try {
      final response = await Dio().get(
        'https://api.rajaongkir.com/starter/province',
        queryParameters: {
          'key': '1cb43289cc10a06c629f1f1ddcd0c139',
        },
      );

      final data = response.data['rajaongkir']['results'];
      return data;
    } catch (error) {
      print('Error fetching provinces: $error');
      return List<dynamic>.empty();
    }
  }

  Future<List<dynamic>> getCities(String province_id) async {
    try {
      final response = await Dio().get(
        'https://api.rajaongkir.com/starter/city',
        queryParameters: {
          'key': '1cb43289cc10a06c629f1f1ddcd0c139',
          'province': province_id,
        },
      );

      final data = response.data['rajaongkir']['results'];
      return data;
    } catch (error) {
      print('Error fetching cities: $error');
      return List<dynamic>.empty();
    }
  }

  Future<List<dynamic>> getShippingCost(
      String originCityId, String destinationCityId, String weight) async {
    try {
      final response = await Dio().post(
        'https://api.rajaongkir.com/starter/cost',
        data: {
          'key': '1cb43289cc10a06c629f1f1ddcd0c139',
          'origin': originCityId,
          'destination': destinationCityId,
          'weight': weight,
          'courier': 'jne',
        },
      );

      final data = response.data['rajaongkir']['results'];
      return data;
    } catch (error) {
      print('Error fetching cost: $error');
      return List<dynamic>.empty();
    }
  }
}
