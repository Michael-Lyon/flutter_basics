import 'package:flutter/widgets.dart';
import 'package:daily_glorb/app/app.dart';
import 'package:daily_glorb/home/home.dart';
import 'package:daily_glorb/onboarding/onboarding.dart';

List<Page<dynamic>> onGenerateAppViewPages(
  AppStatus state,
  List<Page<dynamic>> pages,
) {
  switch (state) {
    case AppStatus.onboardingRequired:
      return [OnboardingPage.page()];
    case AppStatus.unauthenticated:
    case AppStatus.authenticated:
      return [HomePage.page()];
  }
}
