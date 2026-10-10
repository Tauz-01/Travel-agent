import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class RoamAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final Widget? titleWidget;
  final bool showBackButton;
  final VoidCallback? onBackPressed;
  final List<Widget>? actions;

  const RoamAppBar({
    super.key,
    this.title,
    this.titleWidget,
    this.showBackButton = true,
    this.onBackPressed,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.gutter, vertical: AppSpacing.sm),
        child: Row(
          children: [
            if (showBackButton)
              IconButton(
                icon: const Icon(Icons.arrow_back, color: AppColors.textHighEmphasis),
                onPressed: onBackPressed ?? () => Navigator.of(context).maybePop(),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(minWidth: 40, minHeight: 40),
              )
            else
              Row(
                children: [
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: AppColors.blueContainerLight,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: AppColors.secondaryBlue.withOpacity(0.3)),
                    ),
                    child: const Icon(Icons.directions_bus_rounded, size: 20, color: AppColors.secondaryBlue),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('RoamAgent', style: AppTypography.headlineSmall.copyWith(fontSize: 16)),
                      Text('AI Concierge', style: AppTypography.labelSmall.copyWith(color: AppColors.secondaryBlue)),
                    ],
                  ),
                ],
              ),
            if (titleWidget != null) ...[
              const SizedBox(width: AppSpacing.sm),
              Expanded(child: titleWidget!),
            ] else if (title != null) ...[
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Text(
                  title!,
                  style: AppTypography.headlineMedium,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ] else
              const Spacer(),
            if (actions != null) ...actions!,
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60.0);
}

class DemoDataBadge extends StatelessWidget {
  final String label;
  const DemoDataBadge({
    super.key,
    this.label = 'Demo • Simulated travel data',
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.blueContainerLight,
        borderRadius: BorderRadius.circular(AppSpacing.pillRadius),
        border: Border.all(color: AppColors.secondaryBlue.withOpacity(0.2)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: const BoxDecoration(
              color: AppColors.secondaryBlue,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: AppSpacing.xs),
          Text(
            label,
            style: AppTypography.labelSmall.copyWith(color: AppColors.secondaryBlue, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}

class PrimaryButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final bool isLoading;
  final Color backgroundColor;
  final Color textColor;

  const PrimaryButton({
    super.key,
    required this.label,
    this.onPressed,
    this.icon,
    this.isLoading = false,
    this.backgroundColor = AppColors.primaryDarkSlate,
    this.textColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: textColor,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSpacing.buttonRadius),
          ),
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
        ),
        onPressed: isLoading ? null : onPressed,
        child: isLoading
            ? const SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(strokeWidth: 2.5, color: Colors.white),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    label,
                    style: AppTypography.labelLarge.copyWith(color: textColor, fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  if (icon != null) ...[
                    const SizedBox(width: AppSpacing.sm),
                    Icon(icon, size: 20, color: textColor),
                  ]
                ],
              ),
      ),
    );
  }
}

class SecondaryButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;

  const SecondaryButton({
    super.key,
    required this.label,
    this.onPressed,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          backgroundColor: AppColors.blueContainerLight,
          foregroundColor: AppColors.textHighEmphasis,
          side: const BorderSide(color: Colors.transparent),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSpacing.buttonRadius),
          ),
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[
              Icon(icon, size: 18, color: AppColors.textHighEmphasis),
              const SizedBox(width: AppSpacing.sm),
            ],
            Text(
              label,
              style: AppTypography.labelLarge.copyWith(fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}

class StatusBadge extends StatelessWidget {
  final String label;
  final Color backgroundColor;
  final Color textColor;
  final IconData? icon;

  const StatusBadge({
    super.key,
    required this.label,
    required this.backgroundColor,
    required this.textColor,
    this.icon,
  });

  factory StatusBadge.aiRecommended() => const StatusBadge(
        label: '✦ AI Recommended',
        backgroundColor: AppColors.primaryDarkSlate,
        textColor: Colors.white,
      );

  factory StatusBadge.lowestFare() => const StatusBadge(
        label: 'Lowest fare',
        backgroundColor: AppColors.blueContainerLight,
        textColor: AppColors.secondaryBlue,
      );

  factory StatusBadge.onTime() => const StatusBadge(
        label: '• On Time',
        backgroundColor: AppColors.blueContainerLight,
        textColor: AppColors.secondaryBlue,
      );

  factory StatusBadge.critical() => const StatusBadge(
        label: 'Critical risk!',
        backgroundColor: AppColors.warningLightSurface,
        textColor: AppColors.disruptionOrange,
      );

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm, vertical: 4),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(AppSpacing.pillRadius),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 12, color: textColor),
            const SizedBox(width: 4),
          ],
          Text(
            label,
            style: AppTypography.labelSmall.copyWith(color: textColor, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
