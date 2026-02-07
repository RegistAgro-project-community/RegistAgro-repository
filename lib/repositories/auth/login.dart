import 'package:dio/dio.dart';
import 'package:projecto_registagro/repositories/storage.dart';

final dio = Dio(BaseOptions(headers: {'Content-Type': 'application/json'}));
final storeToken = TokenStorage();

Future<Map<String, String>> login(String email, String password) async {
  final data = {'email': email, 'password': password};

  try {
    final res = await dio.post(
      'http://192.168.18.4:5500/auth/login',
      data: data,
    );

    final authHeader = res.headers.value('authorization');
    final token = authHeader?.split(" ")[1];

    final stored = await storeToken.storeToken(token!);

    if (stored) {
      return {'message': res.data["message"]};
    }

    return {'error': "Não foi possível fazer login"};
  } on DioException catch (e) {
    return {"error": e.response?.data!["error"]};
  }
}
