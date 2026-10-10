import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../../../core/theme/app_theme.dart';

class IntegratedMapWidget extends StatelessWidget {
  final double height;
  final bool showDisruptionMarker;
  final String label;

  const IntegratedMapWidget({
    super.key,
    this.height = 160,
    this.showDisruptionMarker = false,
    this.label = 'NH16 Single-Lane Diversion • Slow moving (12 km/h)',
  });

  @override
  Widget build(BuildContext context) {
    // Vizag to Hyderabad route coordinates
    final points = [
      const LatLng(17.6868, 83.2185), // Visakhapatnam
      const LatLng(17.0005, 81.8040), // Rajahmundry
      const LatLng(16.5417, 81.5212), // Eluru
      const LatLng(16.5062, 80.6480), // Vijayawada
      const LatLng(17.3850, 78.4867), // Hyderabad
    ];

    return ClipRRect(
      borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
      child: Stack(
        children: [
          SizedBox(
            height: height,
            width: double.infinity,
            child: FlutterMap(
              options: MapOptions(
                initialCenter: const LatLng(16.8, 81.2),
                initialZoom: 7.2,
                interactionOptions: const InteractionOptions(flags: InteractiveFlag.none),
              ),
              children: [
                TileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  userAgentPackageName: 'com.roamagent.app',
                ),
                PolylineLayer(
                  polylines: [
                    Polyline(
                      points: points,
                      strokeWidth: 4.0,
                      color: showDisruptionMarker ? AppColors.disruptionOrange : AppColors.secondaryBlue,
                    ),
                  ],
                ),
                MarkerLayer(
                  markers: [
                    Marker(
                      point: points.first,
                      width: 24,
                      height: 24,
                      child: const Icon(Icons.circle, color: AppColors.primaryDarkSlate, size: 16),
                    ),
                    if (showDisruptionMarker)
                      Marker(
                        point: points[1], // Rajahmundry
                        width: 32,
                        height: 32,
                        child: Container(
                          decoration: const BoxDecoration(
                            color: AppColors.disruptionOrange,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.warning_amber_rounded, color: Colors.white, size: 20),
                        ),
                      ),
                    Marker(
                      point: points.last,
                      width: 24,
                      height: 24,
                      child: const Icon(Icons.location_on, color: AppColors.secondaryBlue, size: 20),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 8,
            left: 8,
            right: 8,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.92),
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 4),
                ],
              ),
              child: Row(
                children: [
                  Icon(
                    showDisruptionMarker ? Icons.build_circle : Icons.navigation,
                    size: 16,
                    color: showDisruptionMarker ? AppColors.disruptionOrange : AppColors.secondaryBlue,
                  ),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      label,
                      style: AppTypography.labelSmall.copyWith(
                        color: showDisruptionMarker ? AppColors.disruptionOrange : AppColors.textHighEmphasis,
                        fontWeight: FontWeight.bold,
                        fontSize: 11,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
