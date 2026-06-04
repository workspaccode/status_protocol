import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:status_protocol/status_protocol.dart';

Widget _buildApp(Widget child) {
  return MaterialApp(
    home: StatusProtocolProvider(
      child: child,
    ),
  );
}

void main() {
  group('StatusScreen', () {
    testWidgets('renders correct title and message for 404',
        (tester) async {
      await tester.pumpWidget(
        _buildApp(
          const StatusScreen(statusCode: 404, onRetry: null),
        ),
      );

      expect(find.text('Not Found'), findsOneWidget);
      expect(
        find.text("This resource doesn't exist."),
        findsOneWidget,
      );
    });

    testWidgets('renders custom title and message', (tester) async {
      await tester.pumpWidget(
        _buildApp(
          const StatusScreen(
            statusCode: 500,
            title: 'Custom Title',
            message: 'Custom message',
            onRetry: null,
          ),
        ),
      );

      expect(find.text('Custom Title'), findsOneWidget);
      expect(find.text('Custom message'), findsOneWidget);
    });

    testWidgets('button is hidden when showButton is false',
        (tester) async {
      await tester.pumpWidget(
        _buildApp(
          const StatusScreen(
            statusCode: 404,
            showButton: false,
            onRetry: null,
          ),
        ),
      );

      expect(find.text('Go Home'), findsNothing);
    });
  });

  group('StatusBanner', () {
    testWidgets('renders title and message', (tester) async {
      await tester.pumpWidget(
        _buildApp(
          const StatusBanner(statusCode: 429, onRetry: null),
        ),
      );

      expect(find.text('Too Many Requests'), findsOneWidget);
      expect(
        find.text("Slow down! You've hit the rate limit."),
        findsOneWidget,
      );
    });
  });
}
