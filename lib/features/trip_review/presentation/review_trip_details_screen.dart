import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_theme.dart';
import '../../core/widgets/common_widgets.dart';
import '../../app/providers.dart';

class ReviewTripDetailsScreen extends ConsumerStatefulWidget {
  const ReviewTripDetailsScreen({super.key});

  @override
  ConsumerState<ReviewTripDetailsScreen> createState() => _ReviewTripDetailsScreenState();
}

class _ReviewTripDetailsScreenState extends ConsumerState<ReviewTripDetailsScreen> {
  late TextEditingController _originController;
  late TextEditingController _originBoardingController;
  late TextEditingController _destinationController;
  late TextEditingController _destinationDropoffController;
  late TextEditingController _budgetController;

  @override
  void initState() {
    super.initState();
    final intent = ref.read(tripIntentProvider);
    _originController = TextEditingController(text: intent.origin);
    _originBoardingController = TextEditingController(text: intent.originBoardingPoint);
    _destinationController = TextEditingController(text: intent.destination);
    _destinationDropoffController = TextEditingController(text: intent.destinationDropoffPoint);
    _budgetController = TextEditingController(text: intent.targetBudget.toInt().toString());
  }

  @override
  void dispose() {
    _originController.dispose();
    _originBoardingController.dispose();
    _destinationController.dispose();
    _destinationDropoffController.dispose();
    _budgetController.dispose();
    super.dispose();
  }

  void _onFindTripsPressed() {
    final currentIntent = ref.read(tripIntentProvider);
    final updatedIntent = currentIntent.copyWith(
      origin: _originController.text,
      originBoardingPoint: _originBoardingController.text,
      destination: _destinationController.text,
      destinationDropoffPoint: _destinationDropoffController.text,
      targetBudget: double.tryParse(_budgetController.text) ?? currentIntent.targetBudget,
    );

    ref.read(tripIntentProvider.notifier).updateIntent(updatedIntent);
    context.push('/trip_options');
  }

  @override
  Widget build(BuildContext context) {
    final intent = ref.watch(tripIntentProvider);

    return Scaffold(
      backgroundColor: AppColors.mainLightCanvas,
      appBar: const RoamAppBar(title: 'Review Trip Details'),
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

                    // Extraction Info Banner
                    Container(
                      padding: const EdgeInsets.all(AppSpacing.md),
                      decoration: BoxDecoration(
                        color: AppColors.blueContainerLight,
                        borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: const BoxDecoration(
                              color: AppColors.secondaryBlue,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.auto_awesome, color: Colors.white, size: 18),
                          ),
                          const SizedBox(width: AppSpacing.md),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('AI Concierge Extraction', style: AppTypography.labelLarge.copyWith(color: AppColors.secondaryBlue, fontWeight: FontWeight.bold)),
                                const SizedBox(height: 2),
                                Text(
                                  'We extracted these details from your request. Edit anything that\'s wrong before searching.',
                                  style: AppTypography.bodySmall,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),

                    const SizedBox(height: AppSpacing.lg),

                    // Origin & Destination Card
                    Container(
                      padding: const EdgeInsets.all(AppSpacing.md),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
                        border: Border.all(color: AppColors.outline),
                      ),
                      child: Column(
                        children: [
                          // Origin
                          Row(
                            children: [
                              Container(
                                width: 12,
                                height: 12,
                                decoration: const BoxDecoration(
                                  color: AppColors.primaryDarkSlate,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const SizedBox(width: AppSpacing.md),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('ORIGIN BOARDING', style: AppTypography.labelSmall),
                                    Text(intent.origin, style: AppTypography.headlineMedium.copyWith(fontSize: 18)),
                                    Text(intent.originBoardingPoint, style: AppTypography.bodySmall),
                                  ],
                                ),
                              ),
                              IconButton(
                                icon: const Icon(Icons.edit_outlined, size: 20, color: AppColors.mutedText),
                                onPressed: () {},
                              ),
                            ],
                          ),

                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: AppSpacing.xs),
                            child: Row(
                              children: [
                                SizedBox(width: 5),
                                SizedBox(height: 20, child: VerticalDivider(thickness: 1, color: AppColors.outline)),
                                Spacer(),
                                Chip(
                                  label: Text('⇅ NH16 • Overnight', style: TextStyle(fontSize: 10, color: AppColors.mutedText)),
                                  backgroundColor: AppColors.blueContainerLight,
                                  side: BorderSide.none,
                                  visualDensity: VisualDensity.compact,
                                ),
                                Spacer(),
                              ],
                            ),
                          ),

                          // Destination
                          Row(
                            children: [
                              Container(
                                width: 12,
                                height: 12,
                                decoration: const BoxDecoration(
                                  color: AppColors.secondaryBlue,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const SizedBox(width: AppSpacing.md),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('FINAL DROPOFF', style: AppTypography.labelSmall),
                                    Text(intent.destination, style: AppTypography.headlineMedium.copyWith(fontSize: 18)),
                                    Text(intent.destinationDropoffPoint, style: AppTypography.bodySmall),
                                  ],
                                ),
                              ),
                              IconButton(
                                icon: const Icon(Icons.edit_outlined, size: 20, color: AppColors.mutedText),
                                onPressed: () {},
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: AppSpacing.lg),

                    // Schedule Constraints Card
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
                              Text('Schedule Constraints', style: AppTypography.headlineSmall.copyWith(fontSize: 16)),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                decoration: BoxDecoration(
                                  color: AppColors.blueContainerLight,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Row(
                                  children: [
                                    const Icon(Icons.verified_outlined, size: 12, color: AppColors.secondaryBlue),
                                    const SizedBox(width: 4),
                                    Text('Verified strict', style: AppTypography.labelSmall.copyWith(color: AppColors.secondaryBlue)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: AppSpacing.md),

                          // Arrival Deadline
                          Container(
                            padding: const EdgeInsets.all(AppSpacing.md),
                            decoration: BoxDecoration(
                              color: AppColors.blueContainerLight,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              children: [
                                const Icon(Icons.access_time, color: AppColors.primaryDarkSlate, size: 20),
                                const SizedBox(width: AppSpacing.md),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('Arrival Deadline', style: AppTypography.labelSmall),
                                      Text(intent.deadlineDisplay, style: AppTypography.labelLarge.copyWith(fontWeight: FontWeight.bold, fontSize: 16)),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: AppColors.errorLightSurface,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Text('Hard limit', style: AppTypography.labelSmall.copyWith(color: AppColors.errorRed, fontWeight: FontWeight.bold)),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: AppSpacing.md),

                          // Travelers & Target Budget Grid
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
                                          const Icon(Icons.people_outline, size: 16, color: AppColors.mutedText),
                                          const SizedBox(width: 4),
                                          Text('Travelers', style: AppTypography.labelSmall),
                                        ],
                                      ),
                                      const SizedBox(height: 4),
                                      Text('${intent.travelers} Adult', style: AppTypography.labelLarge.copyWith(fontWeight: FontWeight.bold)),
                                      Text(intent.berthPreference, style: AppTypography.bodySmall),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(width: AppSpacing.md),
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
                                          const Icon(Icons.account_balance_wallet_outlined, size: 16, color: AppColors.mutedText),
                                          const SizedBox(width: 4),
                                          Text('Target Budget', style: AppTypography.labelSmall),
                                        ],
                                      ),
                                      const SizedBox(height: 4),
                                      Text('₹${intent.targetBudget.toInt()}', style: AppTypography.labelLarge.copyWith(fontWeight: FontWeight.bold)),
                                      Text('Maximum spend', style: AppTypography.bodySmall),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: AppSpacing.lg),

                    // Trip Comfort & Logistics Card
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
                          Text('Trip Comfort & Logistics', style: AppTypography.headlineSmall.copyWith(fontSize: 16)),
                          const SizedBox(height: AppSpacing.md),

                          Row(
                            children: [
                              const Icon(Icons.directions_bus_outlined, color: AppColors.primaryDarkSlate, size: 20),
                              const SizedBox(width: AppSpacing.md),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Coach Format', style: AppTypography.labelSmall),
                                    Text(intent.coachFormat, style: AppTypography.bodyMedium.copyWith(fontWeight: FontWeight.w600)),
                                  ],
                                ),
                              ),
                              TextButton(
                                onPressed: () {},
                                child: Text('Change', style: AppTypography.labelMedium.copyWith(color: AppColors.secondaryBlue)),
                              ),
                            ],
                          ),
                          const Divider(height: 16, thickness: 1, color: AppColors.divider),

                          Row(
                            children: [
                              const Icon(Icons.access_time_outlined, color: AppColors.primaryDarkSlate, size: 20),
                              const SizedBox(width: AppSpacing.md),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Transfer Buffer', style: AppTypography.labelSmall),
                                    Text('Minimum ${intent.minTransferBufferMinutes} mins safe layover', style: AppTypography.bodyMedium.copyWith(fontWeight: FontWeight.w600)),
                                  ],
                                ),
                              ),
                              TextButton(
                                onPressed: () {},
                                child: Text('Edit', style: AppTypography.labelMedium.copyWith(color: AppColors.secondaryBlue)),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: AppSpacing.xl),

                    // Actions
                    PrimaryButton(
                      label: 'Find trips',
                      icon: Icons.search,
                      onPressed: _onFindTripsPressed,
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Center(
                      child: TextButton(
                        onPressed: () => context.pop(),
                        child: Text('Back', style: AppTypography.labelLarge.copyWith(color: AppColors.mutedText)),
                      ),
                    ),

                    const SizedBox(height: AppSpacing.md),
                    const Center(child: DemoDataBadge()),
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
