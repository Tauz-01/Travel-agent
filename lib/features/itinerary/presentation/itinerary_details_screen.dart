import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_theme.dart';
import '../../core/widgets/common_widgets.dart';
import '../../data/models/trip_models.dart';
import '../../app/providers.dart';

class ItineraryDetailsScreen extends ConsumerWidget {
  const ItineraryDetailsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final option = ref.watch(activeTripOptionProvider);

    if (option == null) {
      return const Scaffold(
        body: Center(child: Text('No option selected.')),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.mainLightCanvas,
      appBar: const RoamAppBar(title: 'Itinerary Details'),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.gutter),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: AppSpacing.sm),

                    // Top Banner Badge Header
                    Container(
                      padding: const EdgeInsets.all(AppSpacing.md),
                      decoration: BoxDecoration(
                        color: AppColors.blueContainerLight,
                        borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              StatusBadge.aiRecommended(),
                              const DemoDataBadge(),
                            ],
                          ),
                          const SizedBox(height: AppSpacing.md),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('₹${option.totalFare.toInt()}', style: AppTypography.displayLarge.copyWith(fontSize: 28)),
                                  Text('Total simulated fare', style: AppTypography.bodySmall),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Row(
                                    children: [
                                      const Icon(Icons.verified_outlined, color: AppColors.secondaryBlue, size: 16),
                                      const SizedBox(width: 4),
                                      Text('Arrives ${option.arrivalTimeStr}', style: AppTypography.labelLarge.copyWith(color: AppColors.secondaryBlue, fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                  Text('${option.transferCount} scheduled transfer', style: AppTypography.bodySmall),
                                ],
                              )
                            ],
                          ),
                          const SizedBox(height: AppSpacing.sm),
                          Container(
                            padding: const EdgeInsets.all(AppSpacing.sm),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              children: [
                                const Icon(Icons.access_time_filled, size: 16, color: AppColors.secondaryBlue),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    'Arrives 25 mins ahead of your 09:00 AM deadline.',
                                    style: AppTypography.labelSmall.copyWith(color: AppColors.textHighEmphasis),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),

                    const SizedBox(height: AppSpacing.lg),

                    // Map Overlay Thumbnail
                    ClipRRect(
                      borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
                      child: Stack(
                        children: [
                          Container(
                            height: 100,
                            width: double.infinity,
                            color: AppColors.primaryDarkSlate,
                            child: Image.network(
                              'https://images.unsplash.com/photo-1526778548025-fa2f459cd5c1?auto=format&fit=crop&q=80&w=600',
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) => const Center(
                                child: Icon(Icons.map_outlined, color: Colors.white, size: 40),
                              ),
                            ),
                          ),
                          Container(
                            height: 100,
                            width: double.infinity,
                            color: Colors.black.withOpacity(0.4),
                          ),
                          Positioned(
                            bottom: 12,
                            left: 12,
                            right: 12,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    const Icon(Icons.navigation_outlined, color: Colors.white, size: 16),
                                    const SizedBox(width: 6),
                                    Text('NH16 → NH65 Express Highway Corridor', style: AppTypography.labelSmall.copyWith(color: Colors.white, fontWeight: FontWeight.bold)),
                                  ],
                                ),
                                Text('12h 20m total transit', style: AppTypography.labelSmall.copyWith(color: Colors.white70)),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),

                    const SizedBox(height: AppSpacing.lg),

                    // Journey Route Timeline Section
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Journey Route', style: AppTypography.headlineMedium.copyWith(fontSize: 18)),
                        Chip(
                          label: Text('${option.legs.length} Legs Connected', style: const TextStyle(fontSize: 11, color: AppColors.secondaryBlue)),
                          backgroundColor: AppColors.blueContainerLight,
                          side: BorderSide.none,
                          visualDensity: VisualDensity.compact,
                        ),
                      ],
                    ),

                    const SizedBox(height: AppSpacing.md),

                    // Vertical Journey Timeline Legs
                    if (option.legs.isNotEmpty) ...[
                      _buildLegCard(
                        tag: 'ORIGIN LEG 1',
                        icon: Icons.directions_bus,
                        timeStr: '${option.legs[0].departureTimeStr} (${option.legs[0].departureDayLabel})',
                        title: option.legs[0].boardingLocation,
                        subtitle: option.legs[0].boardingDetails,
                        busInfo: '${option.legs[0].operatorName} ${option.legs[0].coachType}',
                        seatInfo: 'Coach #${option.legs[0].busNumber} • Seat ${option.legs[0].seatNumber}',
                        fare: option.legs[0].fare,
                      ),
                    ],

                    if (option.transferInfo != null) ...[
                      _buildTransferCard(option.transferInfo!),
                    ],

                    if (option.legs.length > 1) ...[
                      _buildLegCard(
                        tag: 'CONNECTING LEG 2',
                        icon: Icons.directions_bus,
                        timeStr: '${option.legs[1].departureTimeStr} (${option.legs[1].departureDayLabel})',
                        title: option.legs[1].boardingLocation,
                        subtitle: option.legs[1].boardingDetails,
                        busInfo: option.legs[1].operatorName,
                        seatInfo: '${option.legs[1].coachType} #${option.legs[1].busNumber} • ${option.legs[1].seatNumber}',
                        fare: option.legs[1].fare,
                      ),
                    ],

                    _buildFinalDestinationCard(option),

                    const SizedBox(height: AppSpacing.lg),

                    // Summary Fare Breakdown
                    Container(
                      padding: const EdgeInsets.all(AppSpacing.md),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
                        border: Border.all(color: AppColors.outline),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Summary Fare Breakdown', style: AppTypography.headlineSmall.copyWith(fontSize: 15)),
                          const SizedBox(height: AppSpacing.md),
                          if (option.legs.isNotEmpty) ...[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Leg 1: ${option.legs[0].operatorName} (#${option.legs[0].busNumber})', style: AppTypography.bodySmall),
                                Text('₹${option.legs[0].fare.toInt()}', style: AppTypography.labelMedium),
                              ],
                            ),
                            const SizedBox(height: AppSpacing.xs),
                          ],
                          if (option.legs.length > 1) ...[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Leg 2: ${option.legs[1].operatorName} (#${option.legs[1].busNumber})', style: AppTypography.bodySmall),
                                Text('₹${option.legs[1].fare.toInt()}', style: AppTypography.labelMedium),
                              ],
                            ),
                            const SizedBox(height: AppSpacing.xs),
                          ],
                          const Divider(height: 16, thickness: 1, color: AppColors.divider),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Total Simulated Fare', style: AppTypography.labelLarge.copyWith(fontWeight: FontWeight.bold)),
                              Text('₹${option.totalFare.toInt()}', style: AppTypography.dataMetric),
                            ],
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: AppSpacing.md),

                    // Transit Assumptions Card
                    Container(
                      padding: const EdgeInsets.all(AppSpacing.md),
                      decoration: BoxDecoration(
                        color: AppColors.blueContainerLight,
                        borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.analytics_outlined, size: 16, color: AppColors.secondaryBlue),
                              const SizedBox(width: 6),
                              Text('Transit Assumptions', style: AppTypography.labelMedium.copyWith(color: AppColors.secondaryBlue, fontWeight: FontWeight.bold)),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Transfer and last-mile times are simulated estimates based on historical highway traffic, toll patterns, and seasonal conditions on the NH16 & NH65 corridors.',
                            style: AppTypography.bodySmall.copyWith(fontSize: 11),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: AppSpacing.sm),
                    Container(
                      padding: const EdgeInsets.all(AppSpacing.sm),
                      decoration: BoxDecoration(
                        color: AppColors.blueContainerLight,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.info_outline, size: 14, color: AppColors.mutedText),
                          const SizedBox(width: 6),
                          Expanded(
                            child: Text(
                              'No real ticket purchased • Simulated prototype journey',
                              style: AppTypography.bodySmall.copyWith(fontSize: 11),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: AppSpacing.xl),

                    // Primary Bottom Actions
                    PrimaryButton(
                      label: 'Start demo trip',
                      icon: Icons.rocket_launch_outlined,
                      onPressed: () {
                        context.push('/disruption_alert');
                      },
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    SecondaryButton(
                      label: 'Choose another option',
                      icon: Icons.swap_horiz,
                      onPressed: () => context.pop(),
                    ),
                    const SizedBox(height: AppSpacing.xxl),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLegCard({
    required String tag,
    required IconData icon,
    required String timeStr,
    required String title,
    required String subtitle,
    required String busInfo,
    required String seatInfo,
    required double fare,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.md),
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
        border: Border.all(color: AppColors.outline),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(tag, style: AppTypography.labelSmall.copyWith(color: AppColors.secondaryBlue, fontWeight: FontWeight.bold)),
              Icon(icon, size: 18, color: AppColors.primaryDarkSlate),
            ],
          ),
          const SizedBox(height: 4),
          Text(timeStr, style: AppTypography.labelLarge.copyWith(fontWeight: FontWeight.bold)),
          Text(title, style: AppTypography.headlineSmall.copyWith(fontSize: 16)),
          Text(subtitle, style: AppTypography.bodySmall),
          const SizedBox(height: AppSpacing.md),
          Container(
            padding: const EdgeInsets.all(AppSpacing.sm),
            decoration: BoxDecoration(
              color: AppColors.blueContainerLight,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(busInfo, style: AppTypography.labelSmall.copyWith(fontWeight: FontWeight.bold)),
                    Text(seatInfo, style: AppTypography.bodySmall.copyWith(fontSize: 11)),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.blueContainerDark,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text('₹${fare.toInt()}', style: AppTypography.labelSmall.copyWith(fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildTransferCard(TransferInfo info) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.md),
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.blueContainerLight,
        borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
        border: Border.all(color: AppColors.secondaryBlue.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('SCHEDULED TRANSFER', style: AppTypography.labelSmall.copyWith(color: AppColors.secondaryBlue, fontWeight: FontWeight.bold)),
              const Icon(Icons.swap_calls, color: AppColors.secondaryBlue, size: 20),
            ],
          ),
          const SizedBox(height: 4),
          Text('${info.startTimeStr} - ${info.endTimeStr}', style: AppTypography.labelLarge.copyWith(fontWeight: FontWeight.bold)),
          Text(info.transferLocation, style: AppTypography.headlineSmall.copyWith(fontSize: 16)),
          const SizedBox(height: AppSpacing.sm),
          Container(
            padding: const EdgeInsets.all(AppSpacing.sm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                const Icon(Icons.hourglass_top, size: 16, color: AppColors.secondaryBlue),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${info.bufferMinutes}-min Scheduled Buffer', style: AppTypography.labelSmall.copyWith(fontWeight: FontWeight.bold)),
                      Text(info.transferDetails, style: AppTypography.bodySmall.copyWith(fontSize: 11)),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildFinalDestinationCard(TripOption option) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.md),
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
        border: Border.all(color: AppColors.outline),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('FINAL DESTINATION', style: AppTypography.labelSmall.copyWith(color: AppColors.secondaryBlue, fontWeight: FontWeight.bold)),
              const Icon(Icons.location_on, color: AppColors.secondaryBlue, size: 20),
            ],
          ),
          const SizedBox(height: 4),
          Text('${option.arrivalTimeStr} (Day 2)', style: AppTypography.labelLarge.copyWith(fontWeight: FontWeight.bold)),
          Text(option.destinationStop, style: AppTypography.headlineSmall.copyWith(fontSize: 16)),
          Row(
            children: [
              const Icon(Icons.check_circle, size: 12, color: AppColors.successGreen),
              const SizedBox(width: 4),
              Text('25 mins before 09:00 AM deadline', style: AppTypography.labelSmall.copyWith(color: AppColors.successGreen)),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Container(
            padding: const EdgeInsets.all(AppSpacing.sm),
            decoration: BoxDecoration(
              color: AppColors.blueContainerLight,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                const Icon(Icons.directions_car_outlined, size: 16, color: AppColors.mutedText),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Last-mile note: Estimated 15-min auto/metro to Hitec City / final work stop.',
                    style: AppTypography.bodySmall.copyWith(fontSize: 11),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
