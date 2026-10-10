import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_theme.dart';
import '../../core/widgets/common_widgets.dart';
import '../../app/providers.dart';
import '../../features/map/presentation/integrated_map_widget.dart';

class UpdatedItineraryScreen extends ConsumerWidget {
  const UpdatedItineraryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppColors.mainLightCanvas,
      appBar: const RoamAppBar(title: 'Updated Itinerary'),
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

                    // Top Banner Status Card
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(4),
                                    decoration: const BoxDecoration(color: AppColors.secondaryBlue, shape: BoxShape.circle),
                                    child: const Icon(Icons.check, size: 14, color: Colors.white),
                                  ),
                                  const SizedBox(width: 8),
                                  Text('Demo itinerary updated', style: AppTypography.labelLarge.copyWith(color: AppColors.secondaryBlue, fontWeight: FontWeight.bold)),
                                ],
                              ),
                              const DemoDataBadge(),
                            ],
                          ),
                          const SizedBox(height: AppSpacing.sm),
                          Text('Your revised journey is shown below with seamless transfers and on-time arrival.', style: AppTypography.bodySmall),
                          const SizedBox(height: AppSpacing.sm),

                          // Audit Log Badge
                          Container(
                            padding: const EdgeInsets.all(AppSpacing.sm),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              children: [
                                const Icon(Icons.history_edu, size: 16, color: AppColors.secondaryBlue),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text('Audit log: You approved this simulated change at 01:15 AM.', style: AppTypography.labelSmall.copyWith(color: AppColors.textHighEmphasis)),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),

                    const SizedBox(height: AppSpacing.lg),

                    // Final ETA & Total Revised Fare Grid
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.all(AppSpacing.md),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
                              border: Border.all(color: AppColors.outline),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Final Hyderabad ETA', style: AppTypography.labelSmall),
                                const SizedBox(height: 4),
                                Text('08:00 AM', style: AppTypography.dataMetric.copyWith(fontSize: 22)),
                                Row(
                                  children: [
                                    const Icon(Icons.access_time, size: 12, color: AppColors.secondaryBlue),
                                    const SizedBox(width: 4),
                                    Text('1h before 9:00 AM deadline', style: AppTypography.labelSmall.copyWith(color: AppColors.secondaryBlue, fontSize: 10)),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: AppSpacing.md),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.all(AppSpacing.md),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
                              border: Border.all(color: AppColors.outline),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Total Revised Fare', style: AppTypography.labelSmall),
                                const SizedBox(height: 4),
                                Text('₹1,500', style: AppTypography.dataMetric.copyWith(fontSize: 22)),
                                Row(
                                  children: [
                                    const Icon(Icons.check_circle_outline, size: 12, color: AppColors.successGreen),
                                    const SizedBox(width: 4),
                                    Text('Within original budget', style: AppTypography.labelSmall.copyWith(color: AppColors.successGreen, fontSize: 10)),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: AppSpacing.lg),

                    // Confirmed Route Plan Header
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.alt_route, color: AppColors.secondaryBlue, size: 20),
                            const SizedBox(width: 8),
                            Text('Confirmed Route Plan', style: AppTypography.headlineMedium.copyWith(fontSize: 18)),
                          ],
                        ),
                        Chip(
                          label: const Text('2 Legs • 1 Transfer', style: TextStyle(fontSize: 11, color: AppColors.secondaryBlue)),
                          backgroundColor: AppColors.blueContainerLight,
                          side: BorderSide.none,
                          visualDensity: VisualDensity.compact,
                        ),
                      ],
                    ),

                    const SizedBox(height: AppSpacing.md),

                    // Leg 1 Delayed Coach
                    Container(
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
                              Row(
                                children: [
                                  Container(width: 8, height: 8, decoration: const BoxDecoration(color: AppColors.disruptionOrange, shape: BoxShape.circle)),
                                  const SizedBox(width: 6),
                                  Text('Leg 1 • Delayed Coach', style: AppTypography.labelSmall.copyWith(fontWeight: FontWeight.bold)),
                                ],
                              ),
                              StatusBadge(label: 'Rescheduled', backgroundColor: AppColors.warningLightSurface, textColor: AppColors.disruptionOrange),
                            ],
                          ),
                          const SizedBox(height: AppSpacing.md),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Visakhapatnam (RTC Complex)', style: AppTypography.labelLarge.copyWith(fontWeight: FontWeight.bold)),
                                  Text('Multi-Axle Sleeper • Seat 12U', style: AppTypography.bodySmall),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text('New ETA 03:30 AM', style: AppTypography.labelLarge.copyWith(fontWeight: FontWeight.bold)),
                                  Text('Vijayawada Junction', style: AppTypography.bodySmall),
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                    ),

                    // Transfer Buffer
                    Container(
                      margin: const EdgeInsets.only(bottom: AppSpacing.md),
                      padding: const EdgeInsets.all(AppSpacing.md),
                      decoration: BoxDecoration(
                        color: AppColors.blueContainerLight,
                        borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  const Icon(Icons.swap_calls, color: AppColors.secondaryBlue, size: 18),
                                  const SizedBox(width: 6),
                                  Text('Safe Transfer Buffer', style: AppTypography.labelSmall.copyWith(color: AppColors.secondaryBlue, fontWeight: FontWeight.bold)),
                                ],
                              ),
                              Text('45 mins', style: AppTypography.labelSmall.copyWith(fontWeight: FontWeight.bold)),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text('03:30 AM - 04:15 AM  Vijayawada Bypass Bay 4', style: AppTypography.labelLarge.copyWith(fontWeight: FontWeight.bold, fontSize: 14)),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              const Icon(Icons.luggage, size: 14, color: AppColors.mutedText),
                              const SizedBox(width: 6),
                              Expanded(
                                child: Text('Luggage auto-transfer assist flagged to ground agent', style: AppTypography.bodySmall.copyWith(fontSize: 11)),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),

                    // Leg 2 Replacement Coach
                    Container(
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
                              Row(
                                children: [
                                  Container(width: 8, height: 8, decoration: const BoxDecoration(color: AppColors.secondaryBlue, shape: BoxShape.circle)),
                                  const SizedBox(width: 6),
                                  Text('Leg 2 • Replacement Coach', style: AppTypography.labelSmall.copyWith(fontWeight: FontWeight.bold)),
                                ],
                              ),
                              StatusBadge(label: 'Superfast AC', backgroundColor: AppColors.blueContainerLight, textColor: AppColors.secondaryBlue),
                            ],
                          ),
                          const SizedBox(height: AppSpacing.md),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('04:15 AM Departure', style: AppTypography.labelLarge.copyWith(fontWeight: FontWeight.bold)),
                                  Text('Garuda Plus Multi-Axle • Seat 04L', style: AppTypography.bodySmall),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text('Hyderabad MGBS', style: AppTypography.labelLarge.copyWith(fontWeight: FontWeight.bold)),
                                  Text('Platform 18', style: AppTypography.bodySmall),
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                    ),

                    // Final Arrival Card
                    Container(
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
                              Text('Final Arrival', style: AppTypography.labelSmall),
                              StatusBadge(label: 'On Schedule', backgroundColor: AppColors.successLightSurface, textColor: AppColors.successGreen),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Hyderabad MGBS Central', style: AppTypography.headlineSmall.copyWith(fontSize: 16)),
                              Text('08:00 AM', style: AppTypography.displayLarge.copyWith(fontSize: 24)),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              const Icon(Icons.check_circle, size: 14, color: AppColors.secondaryBlue),
                              const SizedBox(width: 4),
                              Text('Buffer preserved: 60 mins ahead of 9:00 AM morning check-in', style: AppTypography.labelSmall.copyWith(color: AppColors.secondaryBlue, fontSize: 11)),
                            ],
                          )
                        ],
                      ),
                    ),

                    const SizedBox(height: AppSpacing.lg),

                    // Map Transit Waypoint
                    Text('Transit Waypoint: Vijayawada Hub', style: AppTypography.labelLarge.copyWith(fontWeight: FontWeight.bold)),
                    const SizedBox(height: AppSpacing.sm),
                    const IntegratedMapWidget(
                      height: 140,
                      showDisruptionMarker: false,
                      label: 'Bypass Transfer Hub • Bay 4',
                    ),

                    const SizedBox(height: AppSpacing.xl),

                    // Actions
                    PrimaryButton(
                      label: 'Back to trip overview',
                      icon: Icons.dashboard_outlined,
                      onPressed: () {
                        context.go('/');
                      },
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    SecondaryButton(
                      label: 'Reset demo',
                      icon: Icons.refresh,
                      onPressed: () async {
                        final repo = ref.read(mockTripRepoProvider);
                        await repo.resetDemo();
                        ref.read(isDemoUpdatedProvider.notifier).state = false;
                        if (context.mounted) {
                          context.go('/');
                        }
                      },
                    ),
                    const SizedBox(height: AppSpacing.md),
                    Center(
                      child: Text('Demo • Simulated travel data • Prototype only', style: AppTypography.bodySmall.copyWith(fontSize: 11)),
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
}
