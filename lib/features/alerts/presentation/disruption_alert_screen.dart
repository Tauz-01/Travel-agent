import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_theme.dart';
import '../../core/widgets/common_widgets.dart';
import '../../data/fixtures/mock_fixtures.dart';
import '../../features/map/presentation/integrated_map_widget.dart';

class DisruptionAlertScreen extends ConsumerWidget {
  const DisruptionAlertScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final disruption = MockDataFixtures.defaultDisruption;

    return Scaffold(
      backgroundColor: AppColors.mainLightCanvas,
      appBar: const RoamAppBar(title: 'Journey Monitoring'),
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

                    // Live feed banner header
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(width: 8, height: 8, decoration: const BoxDecoration(color: AppColors.disruptionOrange, shape: BoxShape.circle)),
                            const SizedBox(width: 6),
                            Text('Live GPS ping • Route NH16', style: AppTypography.labelSmall.copyWith(color: AppColors.disruptionOrange, fontWeight: FontWeight.bold)),
                          ],
                        ),
                        const DemoDataBadge(),
                      ],
                    ),

                    const SizedBox(height: AppSpacing.md),

                    // Orange Disruption Alert Header Card
                    Container(
                      padding: const EdgeInsets.all(AppSpacing.md),
                      decoration: BoxDecoration(
                        color: AppColors.warningLightSurface,
                        borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
                        border: Border.all(color: AppColors.warningBorder),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: AppColors.disruptionOrange,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const Icon(Icons.warning_amber_rounded, color: Colors.white, size: 22),
                              ),
                              const SizedBox(width: AppSpacing.md),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(disruption.title, style: AppTypography.labelLarge.copyWith(fontWeight: FontWeight.bold, fontSize: 16)),
                                  ],
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: AppColors.primaryDarkSlate,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text('+${disruption.delayMinutes}m delay', style: AppTypography.labelSmall.copyWith(color: Colors.white, fontWeight: FontWeight.bold)),
                              ),
                            ],
                          ),
                          const SizedBox(height: AppSpacing.md),
                          Text(
                            disruption.description,
                            style: AppTypography.bodyMedium,
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: AppSpacing.lg),

                    // Interactive Map Overlay Component
                    IntegratedMapWidget(
                      height: 150,
                      showDisruptionMarker: true,
                      label: disruption.highwayCondition,
                    ),

                    const SizedBox(height: AppSpacing.lg),

                    // What this affects section
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  const Icon(Icons.alt_route, color: AppColors.secondaryBlue, size: 20),
                                  const SizedBox(width: 8),
                                  Text('What this affects', style: AppTypography.headlineSmall.copyWith(fontSize: 16)),
                                ],
                              ),
                              Text('Transfer node', style: AppTypography.labelSmall),
                            ],
                          ),
                          const SizedBox(height: AppSpacing.md),

                          // Scheduled vs Projected Buffer comparison boxes
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  padding: const EdgeInsets.all(AppSpacing.md),
                                  decoration: BoxDecoration(
                                    color: AppColors.blueContainerLight,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Container(width: 8, height: 8, decoration: const BoxDecoration(color: AppColors.secondaryBlue, shape: BoxShape.circle)),
                                          const SizedBox(width: 4),
                                          Text('Scheduled buffer', style: AppTypography.labelSmall),
                                        ],
                                      ),
                                      const SizedBox(height: 4),
                                      Text('${disruption.scheduledBufferMinutes} min', style: AppTypography.dataMetric.copyWith(decoration: TextDecoration.lineThrough, color: AppColors.mutedText)),
                                      Row(
                                        children: [
                                          const Icon(Icons.check_circle_outline, size: 12, color: AppColors.secondaryBlue),
                                          const SizedBox(width: 4),
                                          Text('Safe buffer', style: AppTypography.labelSmall.copyWith(color: AppColors.secondaryBlue)),
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
                                    color: AppColors.warningLightSurface,
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(color: AppColors.warningBorder),
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Container(width: 8, height: 8, decoration: const BoxDecoration(color: AppColors.disruptionOrange, shape: BoxShape.circle)),
                                          const SizedBox(width: 4),
                                          Text('Projected window', style: AppTypography.labelSmall),
                                        ],
                                      ),
                                      const SizedBox(height: 4),
                                      Text('${disruption.projectedWindowMinutes} min', style: AppTypography.dataMetric.copyWith(color: AppColors.disruptionOrange)),
                                      Row(
                                        children: [
                                          const Icon(Icons.error_outline, size: 12, color: AppColors.disruptionOrange),
                                          const SizedBox(width: 4),
                                          Text('Critical risk!', style: AppTypography.labelSmall.copyWith(color: AppColors.disruptionOrange, fontWeight: FontWeight.bold)),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: AppSpacing.md),

                          // Missed Connection Alert Card
                          Container(
                            padding: const EdgeInsets.all(AppSpacing.md),
                            decoration: BoxDecoration(
                              color: AppColors.warningLightSurface,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              children: [
                                const Icon(Icons.warning_amber_rounded, color: AppColors.disruptionOrange, size: 20),
                                const SizedBox(width: AppSpacing.md),
                                Expanded(
                                  child: Text(
                                    'Your connection (Leg 2 at 03:35 AM) will likely be missed. The original itinerary no longer meets your minimum 45-min transfer buffer.',
                                    style: AppTypography.bodySmall.copyWith(color: AppColors.disruptionOrange, fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: AppSpacing.md),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('🚌 Leg 1: VSKP → BZA', style: AppTypography.labelMedium),
                              Text('Arr ~03:30 AM', style: AppTypography.labelMedium.copyWith(color: AppColors.disruptionOrange, fontWeight: FontWeight.bold)),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('➔ Leg 2: BZA → BLR Dep', style: AppTypography.labelMedium),
                              Text('Fixed at 03:35 AM', style: AppTypography.labelMedium.copyWith(fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: AppSpacing.md),

                    Container(
                      padding: const EdgeInsets.all(AppSpacing.sm),
                      decoration: BoxDecoration(
                        color: AppColors.blueContainerLight,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.smart_toy_outlined, size: 14, color: AppColors.secondaryBlue),
                          const SizedBox(width: 6),
                          Text('Simulated event • Not a live operator update.', style: AppTypography.bodySmall.copyWith(fontSize: 11)),
                        ],
                      ),
                    ),

                    const SizedBox(height: AppSpacing.xl),

                    // Primary Orange Action Button
                    PrimaryButton(
                      label: 'Find alternatives',
                      icon: Icons.swap_calls,
                      backgroundColor: AppColors.disruptionOrange,
                      onPressed: () {
                        context.push('/recovery_options');
                      },
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    SecondaryButton(
                      label: 'Dismiss alert (Keep current route)',
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
}
