import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/models/trip_models.dart';
import '../data/repositories/mock_trip_repository.dart';
import '../data/fixtures/mock_fixtures.dart';

final mockTripRepoProvider = Provider<MockTripRepository>((ref) {
  return MockTripRepository();
});

final currentLocaleProvider = StateProvider<Locale>((ref) => const Locale('en'));

final tripIntentProvider = StateNotifierProvider<TripIntentNotifier, TripIntent>((ref) {
  final repo = ref.watch(mockTripRepoProvider);
  return TripIntentNotifier(repo);
});

class TripIntentNotifier extends StateNotifier<TripIntent> {
  final MockTripRepository _repo;

  TripIntentNotifier(this._repo) : super(MockDataFixtures.defaultIntent);

  void updateIntent(TripIntent newIntent) {
    state = newIntent;
    _repo.updateIntent(newIntent);
  }

  void updatePrompt(String prompt) async {
    final updated = await _repo.parseNaturalPrompt(prompt);
    state = updated;
  }
}

final activeTripOptionProvider = StateProvider<TripOption?>((ref) {
  return MockDataFixtures.getMockTripOptions().first;
});

final activeRecoveryOptionProvider = StateProvider<RecoveryOption?>((ref) {
  return MockDataFixtures.getMockRecoveryOptions().first;
});

final isDemoUpdatedProvider = StateProvider<bool>((ref) => false);
