import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:infra/screens/OnBoardingOne.dart';
import 'package:infra/screens/OnboardingTwo.dart';

void main() {
  testWidgets('OnBoardingOne renders correctly and navigates on tap', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: OnBoardingOne(),
        routes: {
          '/onboardingTwo': (context) => OnBoardingTwo(),
        },
      ),
    );

    // Check if all the widgets are displayed correctly
    expect(find.text("Let's Get Started!"), findsOneWidget);
    expect(find.text('Discover how FIP can Improve Infrastructure in your community'), findsOneWidget);
    expect(find.byType(Image), findsNWidgets(3));
    expect(find.byType(Container), findsWidgets);
    expect(find.byType(Row), findsOneWidget);
    expect(find.byType(Column), findsOneWidget);

    // Tap on the screen to navigate to OnBoardingTwo
    await tester.tap(find.byType(GestureDetector));
    await tester.pumpAndSettle();

    // Verify if the OnBoardingTwo screen is displayed
    expect(find.byType(OnBoardingTwo), findsOneWidget);
  });
}
