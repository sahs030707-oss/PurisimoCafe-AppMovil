import 'dart:convert';
import 'package:http/http.dart' as http;
import '../constants/api_constants.dart';
import '../errors/app_exception.dart';

class ApiClient {
  final _client = http.Client();

  // Aquí se guarda el token JWT después del login
  String? token;

  // Arma los encabezados de cada petición
  Map<String, String> _headers() {
    final headers = {'Content-Type': 'application/json'};
    if (token != null) {
      headers['Authorization'] = 'Bearer $token';
    }
    return headers;
  }

  // Petición GET (pedir datos)
  Future<dynamic> get(String path, {Map<String, String>? query}) async {
    final uri = Uri.parse('${ApiConstants.baseUrl}/$path')
        .replace(queryParameters: query);

    try {
      final http.Response response;
      response = await _client
          .get(uri, headers: _headers())
          .timeout(const Duration(seconds: 30));
      return _procesar(response);
    } on AppException {
      rethrow;
    } catch (e) {
      throw AppException('No se pudo conectar con el servidor.');
    }
  }

  // Petición POST (enviar datos nuevos)
  Future<dynamic> post(String path,
      {Map<String, dynamic>? body, Map<String, String>? query}) async {
    final uri = Uri.parse('${ApiConstants.baseUrl}/$path')
        .replace(queryParameters: query);

    try {
      final http.Response response;
      response = await _client
          .post(uri, headers: _headers(), body: jsonEncode(body))
          .timeout(const Duration(seconds: 30));
      return _procesar(response);
    } on AppException {
      rethrow;
    } catch (e) {
      throw AppException('No se pudo conectar con el servidor.');
    }
  }

  // Petición PUT (actualizar datos)
  Future<dynamic> put(String path,
      {Map<String, dynamic>? body, Map<String, String>? query}) async {
    final uri = Uri.parse('${ApiConstants.baseUrl}/$path')
        .replace(queryParameters: query);

    try {
      final http.Response response;
      response = await _client
          .put(uri, headers: _headers(), body: jsonEncode(body))
          .timeout(const Duration(seconds: 30));
      return _procesar(response);
    } on AppException {
      rethrow;
    } catch (e) {
      throw AppException('No se pudo conectar con el servidor.');
    }
  }

  // Revisa la respuesta de la API
  dynamic _procesar(http.Response response) {
    // Si todo salió bien (códigos 200 a 299)
    if (response.statusCode >= 200 && response.statusCode < 300) {
      if (response.body.isEmpty) {
        return null;
      }
      try {
        return jsonDecode(response.body);
      } catch (e) {
        // Algunas respuestas de tu API son solo texto, no JSON
        return response.body;
      }
    }

    // Si hubo un error
    if (response.statusCode == 401 && response.body.isEmpty) {
      throw AppException('Tu sesión venció. Inicia sesión de nuevo.');
    }
    if (response.body.isNotEmpty) {
      throw AppException(response.body);
    }
    throw AppException('Error del servidor (${response.statusCode}).');
  }
}
