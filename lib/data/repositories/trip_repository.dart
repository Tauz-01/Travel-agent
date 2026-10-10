import '../models/trip_models.dart';

abstract class TripIntentRepository {
  Future<TripIntent> parseNaturalPrompt(String prompt);
  Future<TripIntent> updateIntent(TripIntent intent);
  Future<TripIntent> getCurrentIntent();
}

abstract class RouteSearchRepository {
  Future<List<TripOption>> searchRoutes(TripIntent intent);
}

abstract class JourneyRepository {
  Future<TripOption?> getActiveItinerary();
  Future<DisruptionEvent?> getActiveDisruption();
  Future<List<RecoveryOption>> getRecoveryOptions();
  Future<bool> approveRecoveryProposal(RecoveryOption proposal);
  Future<void> resetDemo();
}
