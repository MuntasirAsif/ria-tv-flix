import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

import '../../../../../core/service/cache/cache_service.dart';
import '../../../../../core/service/network/api_handler.dart';
import '../../domain/repository/auth_repository.dart';
import '../../domain/provider/auth_repository_provider.dart';

class LoginViewModel extends StateNotifier<AsyncValue<void>> {
  final AuthRepository _authRepository;
  final CacheService _cacheService;
  final Ref ref;

  LoginViewModel(this._authRepository, this._cacheService, this.ref)
    : super(const AsyncValue.data(null));

  Future<void> sendOtp(String phone) async {
    state = const AsyncValue.loading();

    await Api.call(
      action: _authRepository.sendOtp({'phone': phone}),
      onSuccess: (responseData) {
        state = const AsyncValue.data(null);
      },
      onError: (error) {
        state = AsyncValue.error(error, StackTrace.current);
      },
    );
  }

  Future<void> verifyOtp(String phone, String otp) async {
    state = const AsyncValue.loading();

    await Api.call(
      action: _authRepository.verifyOtp({'phone': phone, 'otp': otp}),
      onSuccess: (responseData) async {
        log(responseData.toString());
        if (responseData != null && responseData is Map<String, dynamic>) {
          final accessToken = responseData['accessToken']?.toString();
          final refreshToken = responseData['refreshToken']?.toString();
          final role = responseData['data']?['user']?['role']?.toString();

          if (accessToken != null) {
            await _cacheService.save(CacheKey.accessToken, accessToken);
          }
          if (refreshToken != null) {
            await _cacheService.save(CacheKey.refreshToken, refreshToken);
          }

          await _cacheService.save(CacheKey.isLoggedIn, true);
          await _cacheService.save(CacheKey.role, role);
        }

        state = const AsyncValue.data(null);
      },
      onError: (error) {
        state = AsyncValue.error(error, StackTrace.current);
      },
    );
  }
}

final loginViewModelProvider =
    StateNotifierProvider<LoginViewModel, AsyncValue<void>>((ref) {
      final authRepository = ref.watch(authRepositoryProvider);
      final cacheService = ref.watch(cacheServiceProvider);
      return LoginViewModel(authRepository, cacheService, ref);
    });
