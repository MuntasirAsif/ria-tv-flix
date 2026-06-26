part of 'part_of.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final navigatorKey = ref.watch(navigatorKeyProvider);

  return GoRouter(
    navigatorKey: navigatorKey,
    initialLocation: RouteConst.splash,
    routes: <RouteBase>[
      GoRoute(
        path: RouteConst.splash,
        pageBuilder: (context, state) => buildTransitionPage(
          child: const SplashScreen(),
          key: state.pageKey,
          type: AppTransitionType.fade,
        ),
      ),
      GoRoute(
        path: RouteConst.login,
        pageBuilder: (context, state) => buildTransitionPage(
          child: const LoginScreen(),
          key: state.pageKey,
          type: AppTransitionType.fade,
        ),
      ),
      GoRoute(
        path: RouteConst.signUp,
        pageBuilder: (context, state) => buildTransitionPage(
          child: const SignUpScreen(),
          key: state.pageKey,
          type: AppTransitionType.rightToLeft,
        ),
      ),
      GoRoute(
        path: RouteConst.forgotPassword,
        pageBuilder: (context, state) => buildTransitionPage(
          child: const ForgotPasswordScreen(),
          key: state.pageKey,
          type: AppTransitionType.rightToLeft,
        ),
      ),
      GoRoute(
        path: RouteConst.otpScreen,
        pageBuilder: (context, state) => buildTransitionPage(
          child: const OtpScreen(),
          key: state.pageKey,
          type: AppTransitionType.rightToLeft,
        ),
      ),
      GoRoute(
        path: RouteConst.resetPassword,
        pageBuilder: (context, state) => buildTransitionPage(
          child: const ResetPasswordScreen(),
          key: state.pageKey,
          type: AppTransitionType.rightToLeft,
        ),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return Consumer(
            builder: (context, ref, _) {
              return AppBottomNavBar(
                key: GlobalObjectKey('bottom-nav-${state.hashCode}'),
                navigationShell: navigationShell,
              );
            },
          );
        },
        branches: bottomBranches,
      ),
    ],
  );
});

List<StatefulShellBranch> bottomBranches = [
  // Home
  StatefulShellBranch(
    routes: [
      GoRoute(
        path: RouteConst.homeScreen,
        builder: (context, state) => Scaffold(),
      ),
    ],
  ),
];
