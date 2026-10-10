import 'package:flutter_test/flutter_test.dart';
import 'package:roam_agent/data/fixtures/mock_fixtures.dart';
import 'package:roam_agent/data/repositories/mock_trip_repository.dart';

void main() {
  group('MockTripRepository Tests', () {
    late MockTripRepository repo;

    setUp(() {
      repo = MockTripRepository();
    });

    test('Initial intent returns Vizag -> Hyderabad default fixture', () async {
      final intent = await repo.getCurrentIntent();
      expect(intent.origin, equals('Visakhapatnam'));
      expect(intent.destination, equals('Hyderabad'));
      expect(intent.targetBudget, equals(1500.0));
    });

    test('searchRoutes returns mock options with AI recommended option first', () async {
      final intent = await repo.getCurrentIntent();
      final options = await repo.searchRoutes(intent);
      expect(options.length, equals(3));
      expect(options.first.isAiRecommended, isTrue);
      expect(options.first.totalFare, equals(1250.0));
      expect(options.last.isFeasible, isFalse);
    });

    test('approveRecoveryProposal updates demo journey state correctly', () async {
      final recoveryOptions = await repo.getRecoveryOptions();
      final selectedProposal = recoveryOptions.first;

      final success = await repo.approveRecoveryProposal(selectedProposal);
      expect(success, isTrue);

      final updatedItinerary = await repo.getActiveItinerary();
      expect(updatedItinerary?.title, contains('Hyderabad MGBS Central'));
      expect(updatedItinerary?.totalFare, equals(1500.0));

      final activeDisruption = await repo.getActiveDisruption();
      expect(activeDisruption, isNull);
    });

    test('resetDemo restores default state', () async {
      final recoveryOptions = await repo.getRecoveryOptions();
      await repo.approveRecoveryProposal(recoveryOptions.first);

      await repo.resetDemo();

      final activeDisruption = await repo.getActiveDisruption();
      expect(activeDisruption, isNotNull);
      expect(activeDisruption?.delayMinutes, equals(50));
    });
  });
}
