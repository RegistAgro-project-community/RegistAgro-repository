import 'package:dio/dio.dart';
import 'package:projecto_registagro/config/api_config.dart';
import 'package:projecto_registagro/config/dio_client.dart';
import 'package:projecto_registagro/utils/logger.dart';

class GeoLocation {
  final Dio _dio = DioClient().dio;

  Future<List<double>> carrierCoordinates(String orderId) async {
    try {
      final res = await _dio.get(
        '${ApiConfig.carrierCoordinates}/$orderId',
      );

      final List<dynamic> origin = res.data['origin'] as List<dynamic>? ?? [];

      final dynamic latData = origin[0];
      final dynamic lngData = origin[1];

      if (latData == null || lngData == null) {
        throw Exception('Coordenadas não encontradas');
      }

      final double latitude = _parseCoordinate(latData);
      final double longitude = _parseCoordinate(lngData);

      final List<double> coordinates = [latitude, longitude];
      AppLogger.debug('Coordenadas obtidas: $coordinates');

      return coordinates;
    } on DioException catch (e) {
      String message = 'Não foi possível obter a localização';

      if (e.response?.statusCode == 401 || e.response?.statusCode == 403) {
        message = e.response?.data?['error'] ?? 'Sessão expirada';
      } else {
        message = e.response?.data?['error'] ??
            e.response?.data?['info'] ??
            e.message ??
            message;
      }

      AppLogger.dioError('Erro ao obter coordenadas', error: e);
      throw Exception(message);
    } catch (e, stackTrace) {
      AppLogger.error('Erro inesperado ao obter localização', error: e, stackTrace: stackTrace);
      throw Exception('Ocorreu um erro inesperado ao obter localização');
    }
  }

  double _parseCoordinate(dynamic value) {
    if (value is num) return value.toDouble();
    if (value is String) {
      return double.tryParse(value) ??
          (throw Exception('Coordenada inválida: $value'));
    }
    throw Exception('Tipo de coordenada inválido: ${value.runtimeType}');
  }
}
