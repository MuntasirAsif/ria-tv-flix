import 'package:retrofit/retrofit.dart';

abstract class AuthRepository {
  Future<HttpResponse<dynamic>> sendOtp(Map<String, dynamic> request);
  Future<HttpResponse<dynamic>> verifyOtp(Map<String, dynamic> request);
  Future<HttpResponse<dynamic>> login(Map<String, dynamic> request);
  Future<HttpResponse<dynamic>> register(Map<String, dynamic> request);
}
