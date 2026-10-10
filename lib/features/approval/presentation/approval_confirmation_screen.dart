import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_theme.dart';
import '../../core/widgets/common_widgets.dart';
import '../../data/models/trip_models.dart';
import '../../app/providers.dart';

class ApprovalConfirmationScreen extends ConsumerWidget {
  const ApprovalConfirmationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recovery = ref.watch(activeRecoveryOptionProvider);

    if (recovery == null) {
      return const Scaffold(
        body: Center(child: Text('No recovery proposal selected.')),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.mainLightCanvas,
      appBar: const RoamAppBar(title: 'Approval Confirmation'),
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

                    // Step progress header
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: 8),
                      decoration: BoxDecoration(
                        color: AppColors.blueContainerLight,
                        borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.check_circle_outline, size: 16, color: AppColors.secondaryBlue),
                              const SizedBox(width: 6),
                              Text('Step 4 of 4 • Itinerary Revision Review', style: AppTypography.labelSmall.copyWith(color: AppColors.secondaryBlue, fontWeight: FontWeight.bold)),
                            ],
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text('Ready', style: AppTypography.labelSmall.copyWith(color: AppColors.secondaryBlue)),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: AppSpacing.md),
                    Text('Confirm your itinerary switch', style: AppTypography.headlineLarge.copyWith(fontSize: 22)),
                    Text('Carefully review the proposed transfer adjustments before applying them to your active travel dashboard.', style: AppTypography.bodySmall),

                    const SizedBox(height: AppSpacing.lg),

                    // Proposed Route Reassignment Image Card
                    ClipRRect(
                      borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
                      child: Stack(
                        children: [
                          Container(
                            height: 120,
                            width: double.infinity,
                            color: AppColors.primaryDarkSlate,
                            child: Image.network(
                              'https://images.unsplash.com/photo-1570125909232-eb263c188f7e?auto=format&fit=crop&q=80&w=600',
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) => const Center(
                                child: Icon(Icons.directions_bus, color: Colors.white, size: 48),
                              ),
                            ),
                          ),
                          Container(
                            height: 120,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [Colors.black.withOpacity(0.3), Colors.black.withOpacity(0.8)],
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 12,
                            left: 12,
                            child: Row(
                              children: [
                                const Icon(Icons.alt_route, color: Colors.white, size: 20),
                                const SizedBox(width: 8),
                                Text('Proposed Route Reassignment', style: AppTypography.headlineSmall.copyWith(color: Colors.white, fontSize: 18)),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),

                    const SizedBox(height: AppSpacing.lg),

                    // Selected Option Details Card
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
                              Text('OPTION 1 SELECTED', style: AppTypography.labelSmall.copyWith(color: AppColors.secondaryBlue, fontWeight: FontWeight.bold)),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                decoration: BoxDecoration(
                                  color: AppColors.blueContainerLight,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Row(
                                  children: [
                                    Container(width: 6, height: 6, decoration: const BoxDecoration(color: AppColors.secondaryBlue, shape: BoxShape.circle)),
                                    const SizedBox(width: 4),
                                    Text('Live Tracked', style: AppTypography.labelSmall.copyWith(color: AppColors.secondaryBlue)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(recovery.title, style: AppTypography.headlineSmall.copyWith(fontSize: 18)),
                          Text(recovery.coachType, style: AppTypography.bodySmall),

                          const SizedBox(height: AppSpacing.md),

                          // Original vs New Arrival comparison
                          Container(
                            padding: const EdgeInsets.all(AppSpacing.md),
                            decoration: BoxDecoration(
                              color: AppColors.blueContainerLight,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('ORIGINAL ARRIVAL', style: AppTypography.labelSmall.copyWith(fontSize: 9)),
                                    Row(
                                      children: [
                                        const Icon(Icons.access_time, size: 14, color: AppColors.errorRed),
                                        const SizedBox(width: 4),
                                        Text('10:45 AM', style: AppTypography.headlineMedium.copyWith(fontSize: 18, decoration: TextDecoration.lineThrough, color: AppColors.mutedText)),
                                      ],
                                    ),
                                    Text('Delayed by roadwork', style: AppTypography.labelSmall.copyWith(color: AppColors.errorRed, fontSize: 10)),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text('NEW ARRIVAL', style: AppTypography.labelSmall.copyWith(fontSize: 9, color: AppColors.secondaryBlue)),
                                    Row(
                                      children: [
                                        const Icon(Icons.verified, size: 16, color: AppColors.secondaryBlue),
                                        const SizedBox(width: 4),
                                        Text('08:00 AM', style: AppTypography.headlineMedium.copyWith(fontSize: 22, color: AppColors.textHighEmphasis)),
                                      ],
                                    ),
                                    Text('Ahead of 09:00 AM deadline', style: AppTypography.labelSmall.copyWith(color: AppColors.secondaryBlue, fontSize: 10, fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: AppSpacing.md),

                          // Updated Transfer Stop
                          Container(
                            padding: const EdgeInsets.all(AppSpacing.md),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: AppColors.outline),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    const Icon(Icons.transfer_within_a_station, color: AppColors.secondaryBlue, size: 18),
                                    const SizedBox(width: 8),
                                    Text('Updated Transfer Stop', style: AppTypography.labelSmall),
                                    const Spacer(),
                                    StatusBadge(label: 'Safe Buffer', backgroundColor: AppColors.blueContainerLight, textColor: AppColors.secondaryBlue),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Text(recovery.newTransferLocation, style: AppTypography.labelLarge.copyWith(fontWeight: FontWeight.bold)),
                                Text('45-min transit window for relaxed coach switch', style: AppTypography.bodySmall.copyWith(fontSize: 11)),
                              ],
                            ),
                          ),

                          const SizedBox(height: AppSpacing.md),

                          // Fare Breakdown Box
                          Container(
                            padding: const EdgeInsets.all(AppSpacing.md),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: AppColors.outline),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        const Icon(Icons.account_balance_wallet_outlined, size: 16, color: AppColors.secondaryBlue),
                                        const SizedBox(width: 6),
                                        Text('Fare Breakdown', style: AppTypography.labelSmall),
                                      ],
                                    ),
                                    const SizedBox(height: 4),
                                    Text('₹1,250 → ₹1,500 Total Fare', style: AppTypography.labelLarge.copyWith(fontWeight: FontWeight.bold)),
                                    Text('✓ Perfectly fits your configured max ₹1,500 budget limit', style: AppTypography.bodySmall.copyWith(fontSize: 11, color: AppColors.secondaryBlue)),
                                  ],
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: AppColors.blueContainerLight,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Text('+₹250 Diff', style: AppTypography.labelSmall.copyWith(color: AppColors.secondaryBlue, fontWeight: FontWeight.bold)),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: AppSpacing.lg),

                    // Simulation & Safety Guarantee Card
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
                              const Icon(Icons.security, size: 20, color: AppColors.primaryDarkSlate),
                              const SizedBox(width: 8),
                              Text('Simulation & Safety Guarantee', style: AppTypography.labelLarge.copyWith(fontWeight: FontWeight.bold)),
                            ],
                          ),
                          const SizedBox(height: AppSpacing.sm),
                          Text(
                            'This is an interactive simulated rebooking. No actual ticket cancellation, seat reservation, or real payment deduction will occur.',
                            style: AppTypography.bodySmall,
                          ),
                          const SizedBox(height: AppSpacing.sm),
                          Row(
                            children: [
                              const Icon(Icons.touch_app_outlined, size: 16, color: AppColors.secondaryBlue),
                              const SizedBox(width: 6),
                              Expanded(
                                child: Text(
                                  'RoamAgent mandates explicit traveller approval before modifying any live itinerary or boarding passes.',
                                  style: AppTypography.bodySmall.copyWith(fontSize: 11, fontWeight: FontWeight.w600),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: AppSpacing.xl),

                    // Actions
                    PrimaryButton(
                      label: 'Approve simulated change',
                      icon: Icons.check,
                      onPressed: () async {
                        ref.read(isDemoUpdatedProvider.notifier).state = true;
                        final repo = ref.read(mockTripRepoProvider);
                        await repo.approveRecoveryProposal(recovery);
                        if (context.mounted) {
                          context.go('/updated_itinerary');
                        }
                      },
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    SecondaryButton(
                      label: 'Keep my original plan',
                      icon: Icons.close,
                      onPressed: () => context.pop(),
                    ),
                    const SizedBox(height: AppSpacing.md),
                    Center(
                      child: Text(
                        'You can inspect alternative connecting lines at any time from your journey timeline.',
                        style: AppTypography.bodySmall.copyWith(fontSize: 11),
                        textAlign: TextAlign.center,
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
}
