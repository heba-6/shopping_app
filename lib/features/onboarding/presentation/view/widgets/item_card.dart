import 'package:flutter/material.dart';

class OnboardingData {
  final String title;
  final String describtion;
  final String images;
  final String textbtn;

  OnboardingData({
    required this.title,
    required this.describtion,
    required this.images,
    required this.textbtn,
  });
}

List<OnboardingData> dataOnboarding() {
  return [
    OnboardingData(
      describtion: 'Now we are here to provide variety of the best fashion',
      images: 'assets/images/Maskgroup.png',
      title: 'Discover Trends',
      textbtn: 'Next',
    ),
    OnboardingData(
      describtion: 'Express your self through the art of the fashionism',
      images: "assets/images/Frame61.png",
      title: 'Latest out fit',
      textbtn: 'Get started',
    ),
  ];
}
