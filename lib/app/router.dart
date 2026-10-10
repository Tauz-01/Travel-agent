import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../core/theme/app_theme.dart';
import '../features/concierge/presentation/conversational_landing_screen.dart';
import '../features/trip_review/presentation/review_trip_details_screen.dart';
import '../features/trip_options/presentation/trip_options_screen.dart';
import '../features/itinerary/presentation/itinerary_details_screen.dart';
import '../features/alerts/presentation/disruption_alert_screen.dart';
import '../features/recovery/presentation/recovery_options_screen.dart';
import '../features/approval/presentation/approval_confirmation_screen.dart';
import '../features/itinerary/presentation/updated_itinerary_screen.dart';
import '../features/pass/presentation/pass_screen.dart';
import '../app/providers.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/',
    routes: [
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return NavigationShellScaffold(navigationShell: navigationShell);
        },
        branches: [
          // Branch 0: Book
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/',
                builder: (context, state) => const ConversationalLandingScreen(),
              ),
            ],
          ),
          // Branch 1: Options
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/trip_options',
                builder: (context, state) => const TripOptionsScreen(),
              ),
            ],
          ),
          // Branch 2: Alerts
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/disruption_alert',
                builder: (context, state) => const DisruptionAlertScreen(),
              ),
            ],
          ),
          // Branch 3: Pass
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/pass',
                builder: (context, state) => const PassScreen(),
              ),
            ],
          ),
        ],
      ),
      // Standalone Full Screen Routes
      GoRoute(
        path: '/review_trip',
        builder: (context, state) => const ReviewTripDetailsScreen(),
      ),
      GoRoute(
        path: '/itinerary_details',
        builder: (context, state) => const ItineraryDetailsScreen(),
      ),
      GoRoute(
        path: '/recovery_options',
        builder: (context, state) => const RecoveryOptionsScreen(),
      ),
      GoRoute(
        path: '/approval_confirmation',
        builder: (context, state) => const ApprovalConfirmationScreen(),
      ),
      GoRoute(
        path: '/updated_itinerary',
        builder: (context, state) => const UpdatedItineraryScreen(),
      ),
    ],
  );
});

class NavigationShellScaffold extends ConsumerWidget {
  final StatefulNavigationShell navigationShell;

  const NavigationShellScaffold({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentLocale = ref.watch(currentLocaleProvider);

    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: AppColors.outline, width: 1)),
        ),
        child: BottomNavigationBar(
          currentIndex: navigationShell.currentIndex,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: AppColors.secondaryBlue,
          unselectedItemColor: AppColors.mutedText,
          selectedLabelStyle: AppTypography.labelSmall.copyWith(fontWeight: FontWeight.bold),
          unselectedLabelStyle: AppTypography.labelSmall,
          onTap: (index) {
            navigationShell.goBranch(
              index,
              initialLocation: index == navigationShell.currentIndex,
            );
          },
          items: [
            BottomNavigationBarItem(
              icon: const Icon(Icons.explore_outlined),
              activeIcon: const Icon(Icons.explore),
              label: currentLocale.languageCode == 'te' ? 'బుకింగ్' : 'Book',
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.directions_bus_outlined),
              activeIcon: const Icon(Icons.directions_bus),
              label: currentLocale.languageCode == 'te' ? 'ఎంపికలు' : 'Options',
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.warning_amber_rounded),
              activeIcon: const Icon(Icons.warning_rounded),
              label: currentLocale.languageCode == 'te' ? 'అలర్ట్లు' : 'Alerts',
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.confirmation_number_outlined),
              activeIcon: const Icon(Icons.confirmation_number),
              label: currentLocale.languageCode == 'te' ? 'పాస్' : 'Pass',
            ),
          ],
        ),
      ),
    );
  }
}
