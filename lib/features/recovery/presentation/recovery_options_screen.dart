import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_theme.dart';
import '../../core/widgets/common_widgets.dart';
import '../../data/models/trip_models.dart';
import '../../data/fixtures/mock_fixtures.dart';
import '../../app/providers.dart';

class RecoveryOptionsScreen extends ConsumerWidget {
  const RecoveryOptionsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recoveryOptions = MockDataFixtures.getMockRecoveryOptions();

    return Scaffold(
      backgroundColor: AppColors.mainLightCanvas,
      appBar: const RoamAppBar(title: 'Recovery Options'),
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

                    // Header Status
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const DemoDataBadge(label: 'Simulated recovery data'),
                        Row(
                          children: [
                            const Icon(Icons.bolt, size: 14, color: AppColors.secondaryBlue),
                            const SizedBox(width: 4),
                            Text('${recoveryOptions.where((e) => e.isFeasible).length} viable paths', style: AppTypography.labelSmall.copyWith(color: AppColors.secondaryBlue, fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ],
                    ),

                    const SizedBox(height: AppSpacing.md),
                    Text('Updated journey options', style: AppTypography.headlineLarge.copyWith(fontSize: 22)),
                    Text('2 viable re-routing alternatives found', style: AppTypography.bodySmall),

                    const SizedBox(height: AppSpacing.md),

                    // Connection At High Risk Banner
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
                              const Icon(Icons.warning_amber_rounded, color: AppColors.disruptionOrange, size: 20),
                              const SizedBox(width: AppSpacing.sm),
                              Text('Connection At High Risk', style: AppTypography.labelLarge.copyWith(color: AppColors.disruptionOrange, fontWeight: FontWeight.bold)),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text('Current delayed plan will arrive past 10:15 AM if connection is missed at Eluru junction.', style: AppTypography.bodySmall),
                          const SizedBox(height: AppSpacing.sm),
                          Container(
                            padding: const EdgeInsets.all(AppSpacing.sm),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              children: [
                                const Icon(Icons.event_busy, size: 16, color: AppColors.disruptionOrange),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text('9:00 AM target arrival deadline breached by +1h 15m', style: AppTypography.labelSmall.copyWith(color: AppColors.disruptionOrange, fontWeight: FontWeight.bold)),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),

                    const SizedBox(height: AppSpacing.lg),

                    // Recovery Option Cards
                    ...recoveryOptions.map((opt) => _buildRecoveryCard(context, ref, opt)),

                    const SizedBox(height: AppSpacing.md),

                    // You are in full control Card
                    Container(
                      padding: const EdgeInsets.all(AppSpacing.md),
                      decoration: BoxDecoration(
                        color: AppColors.blueContainerLight,
                        borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: const BoxDecoration(
                              color: AppColors.secondaryBlue,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.published_with_changes, color: Colors.white, size: 20),
                          ),
                          const SizedBox(width: AppSpacing.md),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('You are in full control', style: AppTypography.labelLarge.copyWith(fontWeight: FontWeight.bold)),
                                const SizedBox(height: 2),
                                Text(
                                  'RoamAgent will never rebook automatically. You decide which option to take, or retain your existing itinerary at any time.',
                                  style: AppTypography.bodySmall.copyWith(fontSize: 11),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),

                    const SizedBox(height: AppSpacing.md),

                    // Call Dispatch Placeholder
                    Container(
                      padding: const EdgeInsets.all(AppSpacing.sm),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppColors.outline),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.support_agent, color: AppColors.secondaryBlue, size: 20),
                              const SizedBox(width: 8),
                              Text('Need agent assistance?', style: AppTypography.bodySmall),
                            ],
                          ),
                          OutlinedButton(
                            onPressed: () {},
                            child: const Text('Call Dispatch'),
                          )
                        ],
                      ),
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

  Widget _buildRecoveryCard(BuildContext context, WidgetRef ref, RecoveryOption option) {
    if (!option.isFeasible) {
      return Container(
        margin: const EdgeInsets.only(bottom: AppSpacing.lg),
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: AppColors.blueContainerLight.withOpacity(0.5),
          borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
          border: Border.all(color: AppColors.outline),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Chip(
                  avatar: const Icon(Icons.block, size: 12, color: AppColors.errorRed),
                  label: const Text('Infeasible', style: TextStyle(fontSize: 10, color: AppColors.errorRed, fontWeight: FontWeight.bold)),
                  backgroundColor: AppColors.errorLightSurface,
                  side: BorderSide.none,
                  visualDensity: VisualDensity.compact,
                ),
                const Spacer(),
                Text('₹${option.fare.toInt()}', style: AppTypography.dataMetric.copyWith(decoration: TextDecoration.lineThrough, color: AppColors.mutedText)),
              ],
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(option.title, style: AppTypography.headlineSmall.copyWith(fontSize: 16)),
            Text(option.infeasibleReason, style: AppTypography.labelSmall.copyWith(color: AppColors.errorRed)),
            const SizedBox(height: AppSpacing.sm),
            Text(option.explanation, style: AppTypography.bodySmall.copyWith(fontSize: 11)),
            const SizedBox(height: AppSpacing.sm),
            Center(child: Text('Unavailable for automated recovery', style: AppTypography.labelSmall.copyWith(color: AppColors.mutedText))),
          ],
        ),
      );
    }

    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.lg),
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
            children: [
              Chip(
                label: Text('• ${option.badgeTag1}', style: const TextStyle(fontSize: 10, color: AppColors.secondaryBlue, fontWeight: FontWeight.bold)),
                backgroundColor: AppColors.blueContainerLight,
                side: BorderSide.none,
                visualDensity: VisualDensity.compact,
              ),
              const SizedBox(width: AppSpacing.xs),
              Chip(
                label: Text('✓ ${option.badgeTag2}', style: const TextStyle(fontSize: 10, color: AppColors.secondaryBlue, fontWeight: FontWeight.bold)),
                backgroundColor: AppColors.blueContainerLight,
                side: BorderSide.none,
                visualDensity: VisualDensity.compact,
              ),
              const Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text('₹${option.fare.toInt()}', style: AppTypography.dataMetric.copyWith(fontSize: 22)),
                  Text(
                    option.fareDiff > 0 ? '+₹${option.fareDiff.toInt()} diff' : '-₹${option.fareDiff.abs().toInt()} saving',
                    style: AppTypography.labelSmall.copyWith(color: option.fareDiff > 0 ? AppColors.mutedText : AppColors.successGreen, fontWeight: FontWeight.bold),
                  ),
                ],
              )
            ],
          ),
          const SizedBox(height: AppSpacing.sm),

          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  width: 50,
                  height: 50,
                  color: AppColors.primaryDarkSlate,
                  child: Image.network(
                    'https://images.unsplash.com/photo-1544620347-c4fd4a3d5957?auto=format&fit=crop&q=80&w=200',
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => const Icon(Icons.directions_bus, color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(option.title, style: AppTypography.labelLarge.copyWith(fontWeight: FontWeight.bold)),
                    Text('${option.coachType} • Fleet ${option.fleetNumber}', style: AppTypography.bodySmall.copyWith(fontSize: 11)),
                    Row(
                      children: [
                        const Icon(Icons.verified_user_outlined, size: 12, color: AppColors.secondaryBlue),
                        const SizedBox(width: 4),
                        Text(option.safeBufferText, style: AppTypography.labelSmall.copyWith(color: AppColors.secondaryBlue)),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),

          const SizedBox(height: AppSpacing.md),

          // Schedule comparison box
          Container(
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              color: AppColors.blueContainerLight,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Schedule comparison', style: AppTypography.labelSmall.copyWith(color: AppColors.mutedText)),
                    Text(option.scheduleDiffText, style: AppTypography.labelSmall.copyWith(color: AppColors.secondaryBlue, fontWeight: FontWeight.bold)),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('ORIGINAL PLAN', style: AppTypography.labelSmall.copyWith(fontSize: 9)),
                        Text(option.originalArrivalStr, style: AppTypography.bodySmall.copyWith(decoration: TextDecoration.lineThrough, color: AppColors.errorRed)),
                        Text('Eluru Transfer', style: AppTypography.labelSmall.copyWith(fontSize: 10)),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text('NEW ARRIVAL', style: AppTypography.labelSmall.copyWith(fontSize: 9, color: AppColors.secondaryBlue)),
                        Text(option.newArrivalStr, style: AppTypography.headlineMedium.copyWith(fontSize: 20, color: AppColors.textHighEmphasis)),
                        Text('Vijayawada Bypass', style: AppTypography.labelSmall.copyWith(fontSize: 10)),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: AppSpacing.md),
          Text(option.explanation, style: AppTypography.bodySmall),

          const SizedBox(height: AppSpacing.md),

          PrimaryButton(
            label: 'Review this change',
            icon: Icons.arrow_forward,
            onPressed: () {
              ref.read(activeRecoveryOptionProvider.notifier).state = option;
              context.push('/approval_confirmation');
            },
          )
        ],
      ),
    );
  }
}
