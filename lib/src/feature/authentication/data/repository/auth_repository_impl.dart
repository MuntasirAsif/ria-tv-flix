import 'package:retrofit/retrofit.dart';

import '../../../../../core/service/network/rest_client.dart';
import '../../domain/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final RestClient _restClient;

  AuthRepositoryImpl(this._restClient);

  @override
  Future<HttpResponse<dynamic>> login(Map<String, dynamic> request) async {
    return await _restClient.login(request);
  }

  @override
  Future<HttpResponse<dynamic>> register(Map<String, dynamic> request) async {
    return await _restClient.register(request);
  }

  @override
  Future<HttpResponse<dynamic>> forgotPassword(
    Map<String, dynamic> request,
  ) async {
    return await _restClient.forgotPassword(request);
  }
}
