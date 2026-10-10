import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/theme/app_theme.dart';
import '../../core/widgets/common_widgets.dart';

class PassScreen extends ConsumerWidget {
  const PassScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppColors.mainLightCanvas,
      appBar: const RoamAppBar(title: 'Digital Boarding Pass', showBackButton: false),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.gutter),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: AppSpacing.sm),
              const Center(child: DemoDataBadge(label: 'Simulated Boarding Pass')),
              const SizedBox(height: AppSpacing.lg),

              // Boarding Pass Ticket Container
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
                  border: Border.all(color: AppColors.outline),
                  boxShadow: [
                    BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4)),
                  ],
                ),
                child: Column(
                  children: [
                    // Top Pass Header
                    Container(
                      padding: const EdgeInsets.all(AppSpacing.md),
                      decoration: const BoxDecoration(
                        color: AppColors.primaryDarkSlate,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(AppSpacing.cardRadius),
                          topRight: Radius.circular(AppSpacing.cardRadius),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.directions_bus, color: Colors.white, size: 20),
                              const SizedBox(width: 8),
                              Text('Kaveri Travels Express', style: AppTypography.labelLarge.copyWith(color: Colors.white, fontWeight: FontWeight.bold)),
                            ],
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              color: AppColors.secondaryBlue,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text('CONFIRMED', style: AppTypography.labelSmall.copyWith(color: Colors.white, fontWeight: FontWeight.bold)),
                          )
                        ],
                      ),
                    ),

                    // Body
                    Padding(
                      padding: const EdgeInsets.all(AppSpacing.md),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('ORIGIN', style: AppTypography.labelSmall),
                                  Text('Visakhapatnam', style: AppTypography.headlineMedium.copyWith(fontSize: 18)),
                                  Text('Dwaraka Nagar (08:15 PM)', style: AppTypography.bodySmall),
                                ],
                              ),
                              const Icon(Icons.arrow_forward, color: AppColors.secondaryBlue),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text('TRANSFER HUB', style: AppTypography.labelSmall),
                                  Text('Vijayawada', style: AppTypography.headlineMedium.copyWith(fontSize: 18)),
                                  Text('Bypass Bay 4 (03:30 AM)', style: AppTypography.bodySmall),
                                ],
                              ),
                            ],
                          ),

                          const SizedBox(height: AppSpacing.md),
                          const Divider(height: 1, thickness: 1, color: AppColors.divider),
                          const SizedBox(height: AppSpacing.md),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('PASSENGER', style: AppTypography.labelSmall),
                                  Text('1 Adult (Single Berth)', style: AppTypography.labelMedium.copyWith(fontWeight: FontWeight.bold)),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text('SEAT / BERTH', style: AppTypography.labelSmall),
                                  Text('Berth U4 / Seat 12U', style: AppTypography.labelMedium.copyWith(fontWeight: FontWeight.bold, color: AppColors.secondaryBlue)),
                                ],
                              ),
                            ],
                          ),

                          const SizedBox(height: AppSpacing.lg),

                          // Mock Barcode
                          Center(
                            child: Column(
                              children: [
                                Container(
                                  height: 60,
                                  width: double.infinity,
                                  color: Colors.black12,
                                  child: const Center(
                                    child: Icon(Icons.qr_code_2, size: 50, color: AppColors.primaryDarkSlate),
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text('PASS ID: ROAM-2026-VSKP-HYD-8821', style: AppTypography.labelSmall.copyWith(letterSpacing: 1.0)),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: AppSpacing.xl),

              Container(
                padding: const EdgeInsets.all(AppSpacing.md),
                decoration: BoxDecoration(
                  color: AppColors.blueContainerLight,
                  borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.info_outline, color: AppColors.secondaryBlue, size: 20),
                    const SizedBox(width: AppSpacing.md),
                    Expanded(
                      child: Text(
                        'This pass is an interactive MVP prototype for simulation purposes. No live bus seat or real ticket is issued.',
                        style: AppTypography.bodySmall.copyWith(fontSize: 12),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: AppSpacing.xxl),
            ],
          ),
        ),
      ),
    );
  }
}
