import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:roam_agent/main.dart';

void main() {
  testWidgets('RoamAgent App renders Conversational Landing Screen', (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: RoamAgentApp(),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text('RoamAgent'), findsOneWidget);
    expect(find.text('Where are you\nheaded?'), findsOneWidget);
    expect(find.text('Plan my trip'), findsOneWidget);
    expect(find.text('Enter details manually'), findsOneWidget);
  });
}
