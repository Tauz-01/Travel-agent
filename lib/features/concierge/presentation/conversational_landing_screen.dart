import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_theme.dart';
import '../../core/widgets/common_widgets.dart';
import '../../app/providers.dart';

class ConversationalLandingScreen extends ConsumerStatefulWidget {
  const ConversationalLandingScreen({super.key});

  @override
  ConsumerState<ConversationalLandingScreen> createState() => _ConversationalLandingScreenState();
}

class _ConversationalLandingScreenState extends ConsumerState<ConversationalLandingScreen> {
  late TextEditingController _textController;

  @override
  void initState() {
    super.initState();
    final currentIntent = ref.read(tripIntentProvider);
    _textController = TextEditingController(text: currentIntent.rawPrompt);
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  void _onPlanTripPressed() {
    if (_textController.text.trim().isNotEmpty) {
      ref.read(tripIntentProvider.notifier).updatePrompt(_textController.text.trim());
    }
    context.push('/review_trip');
  }

  void _onClearPressed() {
    setState(() {
      _textController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    final intent = ref.watch(tripIntentProvider);

    return Scaffold(
      backgroundColor: AppColors.mainLightCanvas,
      body: SafeArea(
        child: Column(
          children: [
            // Top App Bar Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.gutter, vertical: AppSpacing.sm),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          color: AppColors.blueContainerLight,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: AppColors.secondaryBlue.withOpacity(0.3)),
                        ),
                        child: const Icon(Icons.directions_bus_rounded, size: 22, color: AppColors.secondaryBlue),
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('RoamAgent', style: AppTypography.headlineSmall.copyWith(fontSize: 18)),
                          Text('AI Concierge', style: AppTypography.labelSmall.copyWith(color: AppColors.secondaryBlue)),
                        ],
                      ),
                    ],
                  ),
                  const CircleAvatar(
                    radius: 20,
                    backgroundColor: AppColors.blueContainerMedium,
                    child: Icon(Icons.person, color: AppColors.primaryDarkSlate),
                  ),
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.gutter),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: AppSpacing.sm),
                    const Center(child: DemoDataBadge()),
                    const SizedBox(height: AppSpacing.md),

                    // Greeting Card Banner
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(AppSpacing.lg),
                      decoration: BoxDecoration(
                        color: AppColors.blueContainerLight,
                        borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
                      ),
                      child: Stack(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    width: 8,
                                    height: 8,
                                    decoration: const BoxDecoration(
                                      color: AppColors.secondaryBlue,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  const SizedBox(width: 6),
                                  Text(
                                    'Intercity Smart Transit',
                                    style: AppTypography.labelSmall.copyWith(color: AppColors.secondaryBlue, fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              const SizedBox(height: AppSpacing.sm),
                              Text(
                                'Where are you\nheaded?',
                                style: AppTypography.mobileHeadlineLarge.copyWith(fontSize: 24, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: AppSpacing.xs),
                              Text(
                                'Tell RoamAgent what matters for your trip.',
                                style: AppTypography.bodySmall.copyWith(color: AppColors.mutedText),
                              ),
                              const SizedBox(height: AppSpacing.md),
                              Wrap(
                                spacing: AppSpacing.sm,
                                children: [
                                  Chip(
                                    avatar: const Icon(Icons.navigation_outlined, size: 14, color: AppColors.primaryDarkSlate),
                                    label: const Text('RTC & Premium Fleets', style: TextStyle(fontSize: 11)),
                                    backgroundColor: Colors.white,
                                    side: BorderSide.none,
                                    padding: EdgeInsets.zero,
                                    visualDensity: VisualDensity.compact,
                                  ),
                                  Chip(
                                    avatar: const Icon(Icons.bed_outlined, size: 14, color: AppColors.primaryDarkSlate),
                                    label: const Text('Multi-axle Sleepers', style: TextStyle(fontSize: 11)),
                                    backgroundColor: Colors.white,
                                    side: BorderSide.none,
                                    padding: EdgeInsets.zero,
                                    visualDensity: VisualDensity.compact,
                                  ),
                                ],
                              )
                            ],
                          ),
                          Positioned(
                            top: 0,
                            right: 0,
                            child: Container(
                              width: 54,
                              height: 54,
                              decoration: BoxDecoration(
                                color: const Color(0xFF60A5FA),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Stack(
                                children: [
                                  const Center(child: Icon(Icons.directions_bus_filled, color: Colors.white, size: 30)),
                                  Positioned(
                                    top: 4,
                                    right: 4,
                                    child: Container(
                                      width: 10,
                                      height: 10,
                                      decoration: const BoxDecoration(
                                        color: AppColors.disruptionOrange,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),

                    const SizedBox(height: AppSpacing.lg),

                    // Conversational Prompt Box
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
                                  const Icon(Icons.auto_awesome, size: 16, color: AppColors.secondaryBlue),
                                  const SizedBox(width: 6),
                                  Text('Describe your journey', style: AppTypography.labelLarge.copyWith(fontSize: 14)),
                                ],
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                decoration: BoxDecoration(
                                  color: AppColors.blueContainerLight,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text('Natural Speech / Text', style: AppTypography.labelSmall.copyWith(color: AppColors.mutedText, fontSize: 10)),
                              ),
                            ],
                          ),
                          const SizedBox(height: AppSpacing.sm),
                          Container(
                            padding: const EdgeInsets.all(AppSpacing.md),
                            decoration: BoxDecoration(
                              color: AppColors.mainLightCanvas,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: TextField(
                              controller: _textController,
                              maxLines: 3,
                              style: AppTypography.bodyMedium,
                              decoration: const InputDecoration.collapsed(
                                hintText: 'e.g., Visakhapatnam to Hyderabad tomorrow morning under ₹1,500...',
                              ),
                            ),
                          ),
                          const SizedBox(height: AppSpacing.sm),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text('Listening for Telugu / English voice input... (Simulated)')),
                                  );
                                },
                                borderRadius: BorderRadius.circular(20),
                                child: Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: const BoxDecoration(
                                    color: AppColors.blueContainerLight,
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(Icons.mic, color: AppColors.primaryDarkSlate, size: 20),
                                ),
                              ),
                              TextButton(
                                onPressed: _onClearPressed,
                                child: Text('Clear', style: AppTypography.labelMedium.copyWith(color: AppColors.mutedText)),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: AppSpacing.md),

                    // AI Parsed Constraints Section
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('AI PARSED CONSTRAINTS', style: AppTypography.labelSmall.copyWith(letterSpacing: 0.5, fontWeight: FontWeight.bold)),
                            Row(
                              children: [
                                const Icon(Icons.check_circle_outline, size: 14, color: AppColors.secondaryBlue),
                                const SizedBox(width: 4),
                                Text('Ready to route', style: AppTypography.labelSmall.copyWith(color: AppColors.secondaryBlue, fontWeight: FontWeight.w600)),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: AppSpacing.sm),
                        Wrap(
                          spacing: AppSpacing.xs,
                          runSpacing: AppSpacing.xs,
                          children: intent.parsedTags.map((tag) {
                            IconData icon = Icons.check;
                            if (tag.contains('To:')) icon = Icons.location_on_outlined;
                            if (tag.contains('Arrive')) icon = Icons.access_time;
                            if (tag.contains('Sleeper')) icon = Icons.bed_outlined;
                            if (tag.contains('Budget')) icon = Icons.account_balance_wallet_outlined;

                            return Chip(
                              avatar: Icon(icon, size: 14, color: AppColors.primaryDarkSlate),
                              label: Text(tag, style: AppTypography.labelSmall.copyWith(fontWeight: FontWeight.w600)),
                              backgroundColor: AppColors.blueContainerLight,
                              side: BorderSide.none,
                              visualDensity: VisualDensity.compact,
                            );
                          }).toList(),
                        ),
                      ],
                    ),

                    const SizedBox(height: AppSpacing.lg),

                    // Popular Corridors Tonight Card
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
                              Text('Popular Corridors Tonight', style: AppTypography.headlineSmall.copyWith(fontSize: 15)),
                              Text('Live status', style: AppTypography.labelSmall.copyWith(color: AppColors.secondaryBlue)),
                            ],
                          ),
                          const SizedBox(height: AppSpacing.sm),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Stack(
                              children: [
                                Container(
                                  height: 120,
                                  width: double.infinity,
                                  color: AppColors.primaryDarkSlate,
                                  child: Image.network(
                                    'https://images.unsplash.com/photo-1544620347-c4fd4a3d5957?auto=format&fit=crop&q=80&w=600',
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
                                      colors: [Colors.transparent, Colors.black.withOpacity(0.8)],
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 12,
                                  left: 12,
                                  right: 12,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text('Corridor Insight', style: AppTypography.labelSmall.copyWith(color: Colors.white70)),
                                          Text('Vizag → Hyderabad via NH16', style: AppTypography.labelLarge.copyWith(color: Colors.white, fontWeight: FontWeight.bold)),
                                        ],
                                      ),
                                      Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                        decoration: BoxDecoration(
                                          color: Colors.black.withOpacity(0.6),
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                        child: Text('~11h 45m', style: AppTypography.labelSmall.copyWith(color: Colors.white)),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),

                    const SizedBox(height: AppSpacing.xl),

                    // Action Buttons
                    PrimaryButton(
                      label: 'Plan my trip',
                      icon: Icons.arrow_forward,
                      onPressed: _onPlanTripPressed,
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    SecondaryButton(
                      label: 'Enter details manually',
                      icon: Icons.tune,
                      onPressed: () => context.push('/review_trip'),
                    ),

                    const SizedBox(height: AppSpacing.md),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.shield_outlined, size: 14, color: AppColors.mutedText),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            'AI plans your route based on simulated timetable models. No real operator bookings.',
                            style: AppTypography.bodySmall.copyWith(fontSize: 11),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
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
