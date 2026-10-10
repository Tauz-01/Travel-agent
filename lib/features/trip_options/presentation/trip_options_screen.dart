import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_theme.dart';
import '../../core/widgets/common_widgets.dart';
import '../../data/models/trip_models.dart';
import '../../data/fixtures/mock_fixtures.dart';
import '../../app/providers.dart';

class TripOptionsScreen extends ConsumerStatefulWidget {
  const TripOptionsScreen({super.key});

  @override
  ConsumerState<TripOptionsScreen> createState() => _TripOptionsScreenState();
}

class _TripOptionsScreenState extends ConsumerState<TripOptionsScreen> {
  String _selectedFilter = 'Arrival Deadline';
  final Map<String, bool> _expandedWhyMap = {};

  @override
  Widget build(BuildContext context) {
    final options = MockDataFixtures.getMockTripOptions();

    return Scaffold(
      backgroundColor: AppColors.mainLightCanvas,
      appBar: const RoamAppBar(showBackButton: false),
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
                    const Center(child: DemoDataBadge()),
                    const SizedBox(height: AppSpacing.sm),

                    Text('3 simulated routes found for Vizag → Hyderabad', style: AppTypography.bodySmall),
                    const SizedBox(height: AppSpacing.md),

                    // Filter Chips Row
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          _buildFilterChip('Arrival Deadline', Icons.access_time_filled),
                          const SizedBox(width: AppSpacing.sm),
                          _buildFilterChip('Lowest Fare', Icons.currency_rupee),
                          const SizedBox(width: AppSpacing.sm),
                          _buildFilterChip('Fewest Transfers', Icons.alt_route),
                        ],
                      ),
                    ),

                    const SizedBox(height: AppSpacing.lg),

                    // Trip Options List
                    ...options.map((option) => _buildOptionCard(option)),

                    const SizedBox(height: AppSpacing.md),

                    // Corridor Insight Map Link Card
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
                            decoration: BoxDecoration(
                              color: AppColors.blueContainerDark,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Icon(Icons.map_outlined, color: AppColors.secondaryBlue, size: 20),
                          ),
                          const SizedBox(width: AppSpacing.md),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('NH 16 → NH 65 Corridor', style: AppTypography.labelLarge.copyWith(fontWeight: FontWeight.bold)),
                                Text('Monitored live for toll congestion &...', style: AppTypography.bodySmall),
                              ],
                            ),
                          ),
                          const Icon(Icons.chevron_right, color: AppColors.mutedText),
                        ],
                      ),
                    ),

                    const SizedBox(height: AppSpacing.md),
                    Center(
                      child: Text('Simulated schedule and fares • Demo mode', style: AppTypography.bodySmall.copyWith(fontSize: 11)),
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

  Widget _buildFilterChip(String label, IconData icon) {
    final isSelected = _selectedFilter == label;
    return ChoiceChip(
      avatar: Icon(icon, size: 14, color: isSelected ? Colors.white : AppColors.primaryDarkSlate),
      label: Text(label, style: TextStyle(color: isSelected ? Colors.white : AppColors.primaryDarkSlate, fontWeight: FontWeight.bold, fontSize: 12)),
      selected: isSelected,
      selectedColor: AppColors.primaryDarkSlate,
      backgroundColor: AppColors.blueContainerLight,
      showCheckmark: false,
      onSelected: (selected) {
        if (selected) {
          setState(() {
            _selectedFilter = label;
          });
        }
      },
    );
  }

  Widget _buildOptionCard(TripOption option) {
    final isExpanded = _expandedWhyMap[option.id] ?? false;

    if (!option.isFeasible) {
      // Infeasible Route Card
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
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.warningLightSurface,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.warning_amber_rounded, size: 12, color: AppColors.disruptionOrange),
                      const SizedBox(width: 4),
                      Text('Misses arrival deadline', style: AppTypography.labelSmall.copyWith(color: AppColors.disruptionOrange, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
                const Spacer(),
                Text('+20m Late', style: AppTypography.labelSmall.copyWith(color: AppColors.errorRed, fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: AppSpacing.md),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(option.departureTimeStr, style: AppTypography.headlineMedium.copyWith(fontWeight: FontWeight.bold)),
                    Text(option.originStop, style: AppTypography.bodySmall),
                  ],
                ),
                Column(
                  children: [
                    Text(option.totalDurationStr, style: AppTypography.labelSmall),
                    const Icon(Icons.clear, color: AppColors.errorRed, size: 16),
                    Text('Direct (0 transfers)', style: AppTypography.labelSmall.copyWith(color: AppColors.mutedText)),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(option.arrivalTimeStr, style: AppTypography.headlineMedium.copyWith(fontWeight: FontWeight.bold, color: AppColors.errorRed)),
                    Text('Ameerpet, Hyd', style: AppTypography.bodySmall),
                    Text('Arrives after 9:00 AM', style: AppTypography.labelSmall.copyWith(color: AppColors.errorRed, fontSize: 10)),
                  ],
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),

            Container(
              padding: const EdgeInsets.all(AppSpacing.sm),
              decoration: BoxDecoration(
                color: AppColors.warningLightSurface,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  const Icon(Icons.info_outline, size: 16, color: AppColors.disruptionOrange),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      option.feasibilityWarning,
                      style: AppTypography.bodySmall.copyWith(color: AppColors.disruptionOrange, fontSize: 11),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.md),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('TOTAL FARE', style: AppTypography.labelSmall),
                    Text('₹${option.totalFare.toInt()}', style: AppTypography.dataMetric),
                  ],
                ),
                ElevatedButton.icon(
                  onPressed: null,
                  icon: const Icon(Icons.block, size: 16),
                  label: const Text('Not recommended'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    foregroundColor: AppColors.mutedText,
                    elevation: 0,
                  ),
                )
              ],
            )
          ],
        ),
      );
    }

    // Feasible Route Card
    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.lg),
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
        border: Border.all(color: option.isAiRecommended ? AppColors.secondaryBlue : AppColors.outline, width: option.isAiRecommended ? 1.5 : 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              if (option.isAiRecommended) ...[
                StatusBadge.aiRecommended(),
                const SizedBox(width: AppSpacing.xs),
              ],
              if (option.isLowestFare) ...[
                StatusBadge.lowestFare(),
                const SizedBox(width: AppSpacing.xs),
              ],
              if (option.isOnTime) ...[
                StatusBadge.onTime(),
              ] else ...[
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.blueContainerLight,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(option.transferBufferStr, style: AppTypography.labelSmall.copyWith(color: AppColors.secondaryBlue)),
                )
              ],
            ],
          ),
          const SizedBox(height: AppSpacing.md),

          // Departure -> Arrival Summary
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(option.departureTimeStr, style: AppTypography.headlineMedium.copyWith(fontWeight: FontWeight.bold, fontSize: 20)),
                  Text(option.originStop, style: AppTypography.bodySmall),
                  const Text('Day 1', style: TextStyle(fontSize: 10, color: AppColors.mutedText)),
                ],
              ),
              Column(
                children: [
                  Text(option.totalDurationStr, style: AppTypography.labelSmall),
                  Row(
                    children: [
                      Container(width: 20, height: 1, color: AppColors.outline),
                      const Icon(Icons.circle, size: 6, color: AppColors.secondaryBlue),
                      const Icon(Icons.arrow_forward, size: 14, color: AppColors.secondaryBlue),
                    ],
                  ),
                  Text('${option.transferCount} transfer\n(${option.transferBufferStr})', style: AppTypography.labelSmall.copyWith(color: AppColors.secondaryBlue, fontSize: 10), textAlign: TextAlign.center),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(option.arrivalTimeStr, style: AppTypography.headlineMedium.copyWith(fontWeight: FontWeight.bold, fontSize: 20)),
                  Text(option.destinationStop, style: AppTypography.bodySmall),
                  Text(option.arrivalBufferText, style: AppTypography.labelSmall.copyWith(color: AppColors.secondaryBlue, fontWeight: FontWeight.bold, fontSize: 10)),
                ],
              ),
            ],
          ),

          const SizedBox(height: AppSpacing.md),

          // Corridor info badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: 6),
            decoration: BoxDecoration(
              color: AppColors.blueContainerLight,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(Icons.directions_bus_outlined, size: 14, color: AppColors.primaryDarkSlate),
                    const SizedBox(width: 6),
                    Text(option.routeCorridor, style: AppTypography.labelSmall),
                  ],
                ),
                Text(option.operatorInfo, style: AppTypography.labelSmall.copyWith(color: AppColors.mutedText)),
              ],
            ),
          ),

          const SizedBox(height: AppSpacing.md),

          // Fare & Action
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('TOTAL FARE', style: AppTypography.labelSmall),
                  Row(
                    children: [
                      Text('₹${option.totalFare.toInt()}', style: AppTypography.dataMetric),
                      if (option.originalFare != null) ...[
                        const SizedBox(width: 6),
                        Text(
                          '₹${option.originalFare!.toInt()}',
                          style: AppTypography.bodySmall.copyWith(decoration: TextDecoration.lineThrough, color: AppColors.mutedText),
                        ),
                      ]
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 44,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: option.isAiRecommended ? AppColors.primaryDarkSlate : AppColors.blueContainerMedium,
                    foregroundColor: option.isAiRecommended ? Colors.white : AppColors.textHighEmphasis,
                    elevation: 0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  onPressed: () {
                    ref.read(activeTripOptionProvider.notifier).state = option;
                    context.push('/itinerary_details');
                  },
                  icon: Text(option.isAiRecommended ? 'View itinerary' : 'Select option', style: const TextStyle(fontWeight: FontWeight.bold)),
                  label: Icon(Icons.arrow_forward, size: 16, color: option.isAiRecommended ? Colors.white : AppColors.textHighEmphasis),
                ),
              )
            ],
          ),

          const SizedBox(height: AppSpacing.sm),

          // Why this option dropdown
          InkWell(
            onTap: () {
              setState(() {
                _expandedWhyMap[option.id] = !isExpanded;
              });
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                children: [
                  const Icon(Icons.lightbulb_outline, size: 16, color: AppColors.secondaryBlue),
                  const SizedBox(width: 6),
                  Text('Why this option?', style: AppTypography.labelSmall.copyWith(color: AppColors.secondaryBlue, fontWeight: FontWeight.bold)),
                  const Spacer(),
                  Icon(isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down, size: 18, color: AppColors.secondaryBlue),
                ],
              ),
            ),
          ),
          if (isExpanded) ...[
            const SizedBox(height: 4),
            Text(
              option.whyThisOptionExplanation,
              style: AppTypography.bodySmall.copyWith(color: AppColors.mutedText, fontSize: 12),
            ),
          ]
        ],
      ),
    );
  }
}
