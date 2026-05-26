import 'package:dio/dio.dart';
import 'package:projecto_registagro/repositories/storage.dart';

class GeoLocation {
  Future<List<double>> carrierCoordinates(String orderId) async {
    try {
      final token = await TokenStorage().readToken();

      if (token.containsKey("error") || token["token"] == null) {
        final message = token["error"] ?? "Faça login novamente";
        throw Exception(message);
      }

      final dio = Dio(
        BaseOptions(
          headers: {
            'Content-Type': 'application/json',
            'authorization': "Bearer ${token['token']}",
          },
        ),
      );

      final res = await dio.get(
        "https://api-registagro.onrender.com/location/get/coordinates/order/$orderId",
      );

      final List<dynamic> origin =
          res.data["origin"] as List<dynamic>? ?? [];

      final dynamic latData = origin[0];
      final dynamic lngData = origin[1];

      if (latData == null || lngData == null) {
        throw Exception("Coordenadas não encontradas");
      }

      final double latitude = _parseCoordinate(latData);
      final double longitude = _parseCoordinate(lngData);

      final List<double> coordinates = [latitude, longitude];

      return coordinates;
    } on DioException catch (e) {
      String message = "Não foi possível obter a localização";

      if (e.response?.statusCode == 401 || e.response?.statusCode == 403) {
        message = e.response?.data?['error'] ?? 'Sessão expirada';
      } else {
        message =
            e.response?.data?['error'] ??
            e.response?.data?['info'] ??
            e.message ??
            message;
      }

      throw Exception(message);
    } catch (e) {
      throw Exception("Ocorreu um erro inesperado ao obter localização");
    }
  }

  double _parseCoordinate(dynamic value) {
    if (value is num) return value.toDouble();
    if (value is String) {
      return double.tryParse(value) ??
          (throw Exception("Coordenada inválida: $value"));
    }
    throw Exception("Tipo de coordenada inválido: ${value.runtimeType}");
  }
}
