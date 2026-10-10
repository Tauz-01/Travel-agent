class TripIntent {
  final String id;
  final String origin;
  final String originBoardingPoint;
  final String destination;
  final String destinationDropoffPoint;
  final DateTime arrivalDeadline;
  final String deadlineDisplay;
  final int travelers;
  final String berthPreference;
  final double targetBudget;
  final String coachFormat;
  final int minTransferBufferMinutes;
  final List<String> parsedTags;
  final String rawPrompt;

  const TripIntent({
    required this.id,
    required this.origin,
    required this.originBoardingPoint,
    required this.destination,
    required this.destinationDropoffPoint,
    required this.arrivalDeadline,
    required this.deadlineDisplay,
    required this.travelers,
    required this.berthPreference,
    required this.targetBudget,
    required this.coachFormat,
    required this.minTransferBufferMinutes,
    required this.parsedTags,
    required this.rawPrompt,
  });

  TripIntent copyWith({
    String? origin,
    String? originBoardingPoint,
    String? destination,
    String? destinationDropoffPoint,
    DateTime? arrivalDeadline,
    String? deadlineDisplay,
    int? travelers,
    String? berthPreference,
    double? targetBudget,
    String? coachFormat,
    int? minTransferBufferMinutes,
    List<String>? parsedTags,
    String? rawPrompt,
  }) {
    return TripIntent(
      id: id,
      origin: origin ?? this.origin,
      originBoardingPoint: originBoardingPoint ?? this.originBoardingPoint,
      destination: destination ?? this.destination,
      destinationDropoffPoint: destinationDropoffPoint ?? this.destinationDropoffPoint,
      arrivalDeadline: arrivalDeadline ?? this.arrivalDeadline,
      deadlineDisplay: deadlineDisplay ?? this.deadlineDisplay,
      travelers: travelers ?? this.travelers,
      berthPreference: berthPreference ?? this.berthPreference,
      targetBudget: targetBudget ?? this.targetBudget,
      coachFormat: coachFormat ?? this.coachFormat,
      minTransferBufferMinutes: minTransferBufferMinutes ?? this.minTransferBufferMinutes,
      parsedTags: parsedTags ?? this.parsedTags,
      rawPrompt: rawPrompt ?? this.rawPrompt,
    );
  }
}

class ItineraryLeg {
  final String id;
  final int legIndex;
  final String operatorName;
  final String coachType;
  final String busNumber;
  final String seatNumber;
  final String boardingLocation;
  final String boardingDetails;
  final String departureTimeStr;
  final String departureDayLabel;
  final String dropoffLocation;
  final String dropoffDetails;
  final String arrivalTimeStr;
  final String arrivalDayLabel;
  final double fare;

  const ItineraryLeg({
    required this.id,
    required this.legIndex,
    required this.operatorName,
    required this.coachType,
    required this.busNumber,
    required this.seatNumber,
    required this.boardingLocation,
    required this.boardingDetails,
    required this.departureTimeStr,
    required this.departureDayLabel,
    required this.dropoffLocation,
    required this.dropoffDetails,
    required this.arrivalTimeStr,
    required this.arrivalDayLabel,
    required this.fare,
  });
}

class TransferInfo {
  final String transferLocation;
  final String transferDetails;
  final String platform;
  final String startTimeStr;
  final String endTimeStr;
  final int bufferMinutes;

  const TransferInfo({
    required this.transferLocation,
    required this.transferDetails,
    required this.platform,
    required this.startTimeStr,
    required this.endTimeStr,
    required this.bufferMinutes,
  });
}

class TripOption {
  final String id;
  final String optionLabel; // e.g., 'Option A', 'Option B'
  final String title;
  final bool isAiRecommended;
  final bool isLowestFare;
  final bool isOnTime;
  final bool isFeasible;
  final String feasibilityWarning;
  final String departureTimeStr;
  final String originStop;
  final String arrivalTimeStr;
  final String destinationStop;
  final String totalDurationStr;
  final int transferCount;
  final String transferBufferStr;
  final String routeCorridor;
  final String operatorInfo;
  final double totalFare;
  final double? originalFare;
  final String arrivalBufferText;
  final String whyThisOptionExplanation;
  final List<ItineraryLeg> legs;
  final TransferInfo? transferInfo;

  const TripOption({
    required this.id,
    required this.optionLabel,
    required this.title,
    this.isAiRecommended = false,
    this.isLowestFare = false,
    this.isOnTime = true,
    this.isFeasible = true,
    this.feasibilityWarning = '',
    required this.departureTimeStr,
    required this.originStop,
    required this.arrivalTimeStr,
    required this.destinationStop,
    required this.totalDurationStr,
    required this.transferCount,
    required this.transferBufferStr,
    required this.routeCorridor,
    required this.operatorInfo,
    required this.totalFare,
    this.originalFare,
    required this.arrivalBufferText,
    required this.whyThisOptionExplanation,
    required this.legs,
    this.transferInfo,
  });
}

class DisruptionEvent {
  final String id;
  final String title;
  final String description;
  final int delayMinutes;
  final String affectedCorridor;
  final String highwayCondition;
  final int scheduledBufferMinutes;
  final int projectedWindowMinutes;
  final String leg1DepartureToArrivalStr;
  final String leg2DepartureStr;
  final bool isCriticalRisk;

  const DisruptionEvent({
    required this.id,
    required this.title,
    required this.description,
    required this.delayMinutes,
    required this.affectedCorridor,
    required this.highwayCondition,
    required this.scheduledBufferMinutes,
    required this.projectedWindowMinutes,
    required this.leg1DepartureToArrivalStr,
    required this.leg2DepartureStr,
    required this.isCriticalRisk,
  });
}

class RecoveryOption {
  final String id;
  final String title;
  final String operatorName;
  final String coachType;
  final String fleetNumber;
  final String safeBufferText;
  final String originalArrivalStr;
  final String newArrivalStr;
  final String newTransferLocation;
  final String scheduleDiffText;
  final double fare;
  final double fareDiff;
  final String explanation;
  final String badgeTag1;
  final String badgeTag2;
  final bool isFeasible;
  final String infeasibleReason;

  const RecoveryOption({
    required this.id,
    required this.title,
    required this.operatorName,
    required this.coachType,
    required this.fleetNumber,
    required this.safeBufferText,
    required this.originalArrivalStr,
    required this.newArrivalStr,
    required this.newTransferLocation,
    required this.scheduleDiffText,
    required this.fare,
    required this.fareDiff,
    required this.explanation,
    required this.badgeTag1,
    required this.badgeTag2,
    this.isFeasible = true,
    this.infeasibleReason = '',
  });
}
