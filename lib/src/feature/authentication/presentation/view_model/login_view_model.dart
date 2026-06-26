import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

import '../../../../../core/service/cache/cache_service.dart';
import '../../../../../core/service/network/api_handler.dart';
import '../../data/model/login_model.dart';
import '../../domain/repository/auth_repository.dart';
import '../../domain/provider/auth_repository_provider.dart';

class LoginViewModel extends StateNotifier<AsyncValue<void>> {
  final AuthRepository _authRepository;
  final CacheService _cacheService;
  final Ref ref;

  LoginViewModel(this._authRepository, this._cacheService, this.ref)
    : super(const AsyncValue.data(null));

  Future<void> login(LoginModel model, {bool rememberMe = false}) async {
    state = const AsyncValue.loading();

    await Api.call(
      // We pass the Future without `await` here so Api.call can await it internally
      action: _authRepository.login(model.toJson()),
      onSuccess: (responseData) async {
        // Extract and save tokens
        log(responseData.toString());
        if (responseData != null && responseData is Map<String, dynamic>) {
          final accessToken = responseData['accessToken']?.toString();
          final refreshToken = responseData['refreshToken']?.toString();
          final role = responseData['data']?['user']?['role']?.toString();

          log("role $accessToken");

          if (accessToken != null) {
            await _cacheService.save(CacheKey.accessToken, accessToken);
          }
          if (refreshToken != null) {
            await _cacheService.save(CacheKey.refreshToken, refreshToken);
          }

          await _cacheService.save(CacheKey.isLoggedIn, true);
          await _cacheService.save(CacheKey.rememberMe, rememberMe);
          await _cacheService.save(CacheKey.role, role);
        }

        // Success!
        state = const AsyncValue.data(null);
      },
      onError: (error) {
        state = AsyncValue.error(error, StackTrace.current);
      },
    );
  }
}

// Expose the ViewModel and inject the dependencies
final loginViewModelProvider =
    StateNotifierProvider<LoginViewModel, AsyncValue<void>>((ref) {
      final authRepository = ref.watch(authRepositoryProvider);
      final cacheService = ref.watch(cacheServiceProvider);
      return LoginViewModel(authRepository, cacheService, ref);
    });

// UI State Providers for Login Form
final loginObscurePasswordProvider = StateProvider.autoDispose<bool>(
  (ref) => true,
);
final loginRememberMeProvider = StateProvider.autoDispose<bool>((ref) => false);
