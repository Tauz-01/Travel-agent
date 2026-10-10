import '../models/trip_models.dart';
import '../fixtures/mock_fixtures.dart';
import 'trip_repository.dart';

class MockTripRepository implements TripIntentRepository, RouteSearchRepository, JourneyRepository {
  TripIntent _currentIntent = MockDataFixtures.defaultIntent;
  TripOption? _selectedItinerary = MockDataFixtures.getMockTripOptions().first;
  DisruptionEvent? _currentDisruption = MockDataFixtures.defaultDisruption;
  bool _isDisruptionActive = true;
  bool _isUpdatedItineraryActive = false;

  @override
  Future<TripIntent> getCurrentIntent() async {
    return _currentIntent;
  }

  @override
  Future<TripIntent> parseNaturalPrompt(String prompt) async {
    await Future.delayed(const Duration(milliseconds: 300));
    _currentIntent = _currentIntent.copyWith(rawPrompt: prompt);
    return _currentIntent;
  }

  @override
  Future<TripIntent> updateIntent(TripIntent intent) async {
    _currentIntent = intent;
    return _currentIntent;
  }

  @override
  Future<List<TripOption>> searchRoutes(TripIntent intent) async {
    await Future.delayed(const Duration(milliseconds: 400));
    return MockDataFixtures.getMockTripOptions();
  }

  @override
  Future<TripOption?> getActiveItinerary() async {
    if (_isUpdatedItineraryActive) {
      return TripOption(
        id: 'opt_updated',
        optionLabel: 'Option A Updated',
        title: 'Vizag RTC Complex → Hyderabad MGBS Central',
        isAiRecommended: true,
        isLowestFare: false,
        isOnTime: true,
        isFeasible: true,
        departureTimeStr: '08:15 PM',
        originStop: 'Visakhapatnam (RTC Complex)',
        arrivalTimeStr: '08:00 AM',
        destinationStop: 'Hyderabad MGBS Central',
        totalDurationStr: '11h 45m',
        transferCount: 1,
        transferBufferStr: '45m buffer',
        routeCorridor: 'Via Vijayawada Bypass',
        operatorInfo: 'Multi-Axle Sleeper + Garuda Plus',
        totalFare: 1500.0,
        arrivalBufferText: '1h before 9:00 AM deadline',
        whyThisOptionExplanation: 'Updated itinerary using Vijayawada Superfast Bypass Express connection.',
        legs: [
          const ItineraryLeg(
            id: 'up_leg_1',
            legIndex: 1,
            operatorName: 'Multi-Axle Sleeper',
            coachType: 'Delayed Coach (Rescheduled)',
            busNumber: 'KA-402',
            seatNumber: 'Seat 12U',
            boardingLocation: 'Visakhapatnam (RTC Complex)',
            boardingDetails: 'Gate 2 Boarding',
            departureTimeStr: '08:15 PM',
            departureDayLabel: 'Day 1',
            dropoffLocation: 'Vijayawada Junction',
            dropoffDetails: 'New ETA 03:30 AM',
            arrivalTimeStr: '03:30 AM',
            arrivalDayLabel: 'Day 2',
            fare: 720.0,
          ),
          const ItineraryLeg(
            id: 'up_leg_2',
            legIndex: 2,
            operatorName: 'Garuda Plus Multi-Axle',
            coachType: 'Replacement Coach (Superfast AC)',
            busNumber: 'OR-911',
            seatNumber: 'Seat 04L',
            boardingLocation: 'Vijayawada Bypass Bay 4',
            boardingDetails: 'Luggage auto-transfer assist flagged to ground agent',
            departureTimeStr: '04:15 AM',
            departureDayLabel: 'Day 2',
            dropoffLocation: 'Hyderabad MGBS Central',
            dropoffDetails: 'Platform 18 • On Schedule',
            arrivalTimeStr: '08:00 AM',
            arrivalDayLabel: 'Day 2',
            fare: 780.0,
          )
        ],
        transferInfo: const TransferInfo(
          transferLocation: 'Vijayawada Bypass Bay 4',
          transferDetails: 'Safe Transfer Buffer (03:30 AM - 04:15 AM)',
          platform: 'Bay 4',
          startTimeStr: '03:30 AM',
          endTimeStr: '04:15 AM',
          bufferMinutes: 45,
        ),
      );
    }
    return _selectedItinerary;
  }

  @override
  Future<DisruptionEvent?> getActiveDisruption() async {
    if (!_isDisruptionActive) return null;
    return _currentDisruption;
  }

  @override
  Future<List<RecoveryOption>> getRecoveryOptions() async {
    return MockDataFixtures.getMockRecoveryOptions();
  }

  @override
  Future<bool> approveRecoveryProposal(RecoveryOption proposal) async {
    await Future.delayed(const Duration(milliseconds: 300));
    _isDisruptionActive = false;
    _isUpdatedItineraryActive = true;
    return true;
  }

  @override
  Future<void> resetDemo() async {
    _currentIntent = MockDataFixtures.defaultIntent;
    _selectedItinerary = MockDataFixtures.getMockTripOptions().first;
    _currentDisruption = MockDataFixtures.defaultDisruption;
    _isDisruptionActive = true;
    _isUpdatedItineraryActive = false;
  }
}
