import 'package:flutter_riverpod/flutter_riverpod.dart';



import '../../../../../core/service/network/dio_client.dart';
import '../../../../../core/service/network/rest_client.dart';
import '../../data/repository/auth_repository_impl.dart';
import '../repository/auth_repository.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final dio = ref.watch(dioProvider);
  return AuthRepositoryImpl(RestClient(dio));
});
