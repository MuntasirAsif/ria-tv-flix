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
        path: RouteConst.otpScreen,
        pageBuilder: (context, state) => buildTransitionPage(
          child: const OtpScreen(),
          key: state.pageKey,
          type: AppTransitionType.rightToLeft,
        ),
      ),
      GoRoute(
        path: RouteConst.videoPlayer,
        pageBuilder: (context, state) => buildTransitionPage(
          child: VideoPlayerScreen(content: state.extra as ContentModel),
          key: state.pageKey,
          type: AppTransitionType.bottomToTop,
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
  StatefulShellBranch(
    routes: [
      GoRoute(
        path: RouteConst.homeScreen,
        builder: (context, state) => const HomeScreen(),
      ),
    ],
  ),
  StatefulShellBranch(
    routes: [
      GoRoute(
        path: RouteConst.categoriesScreen,
        builder: (context, state) => const CategoriesScreen(),
      ),
    ],
  ),
  StatefulShellBranch(
    routes: [
      GoRoute(
        path: RouteConst.tvScreen,
        builder: (context, state) => const TvScreen(),
      ),
    ],
  ),
  StatefulShellBranch(
    routes: [
      GoRoute(
        path: RouteConst.premiumScreen,
        builder: (context, state) => const PremiumScreen(),
      ),
    ],
  ),
  StatefulShellBranch(
    routes: [
      GoRoute(
        path: RouteConst.profileScreen,
        builder: (context, state) => const ProfileScreen(),
      ),
    ],
  ),
];
