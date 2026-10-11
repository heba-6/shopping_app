// import 'package:flutter/material.dart';
// import 'package:shopping_app/features/onboarding/presentation/view/widgets/item_card.dart';
// import 'package:smooth_page_indicator/smooth_page_indicator.dart';

// class OnboardingScreen extends StatefulWidget {
//   const OnboardingScreen({super.key});

//   static const String routeName = "OnboardingScreen";

//   @override
//   State<OnboardingScreen> createState() => _OnboardingScreenState();
// }

// class _OnboardingScreenState extends State<OnboardingScreen> {
//   PageController controller = PageController();

//   int index = 0;

//   List<OnboardingData> onboardingList = dataOnboarding();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,

//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 16),

//           child: Column(
//             children: [
//               // Skip / Arrow
//               SizedBox(
//                 height: 70,
//                 width: double.infinity,
//                 child: Align(
//                   alignment: Alignment.topRight,
//                   child: index == 0
//                       ? TextButton(
//                           onPressed: () {
//                             // Skip logic
//                           },
//                           child:  Text(
//                             "skip",
//                             style: TextStyle(
//                               color: Color(0xff1F1F1F),
//                               fontSize: 14,
//                               fontWeight: FontWeight.w400,
//                             ),
//                           ),
//                         )
//                       : Align(
//                           alignment: Alignment.topLeft,
//                           child: IconButton(
//                             onPressed: () {
//                               controller.previousPage(
//                                 duration: const Duration(milliseconds: 300),
//                                 curve: Curves.easeInOut,
//                               );
//                             },
//                             icon: const Icon(
//                               Icons.arrow_back,
//                               color: Color(0xff212121),
//                               size: 21,
//                             ),
//                           ),
//                         ),
//                 ),
//               ),

//               SizedBox(
//                 height: 472,
//                 child: PageView.builder(
//                   controller: controller,

//                   onPageChanged: (value) {
//                     setState(() {
//                       index = value;
//                     });
//                   },

//                   itemBuilder: (context, index) {
//                     return Padding(
//                       padding: const EdgeInsets.only(top: 35),

//                       child: ClipRRect(
//                         borderRadius: BorderRadius.circular(16),

//                         child: Image.asset(
//                           onboardingList[index].images,
//                           width: 472,
//                           height: 315,
//                           fit: BoxFit.cover,
//                         ),
//                       ),
//                     );
//                   },

//                   itemCount: onboardingList.length,
//                 ),
//               ),

//               const SizedBox(height: 16),

//               SmoothPageIndicator(
//                 controller: controller,
//                 count: onboardingList.length,
//               ),

//               const SizedBox(height: 82),

//               Container(
//                 margin: const EdgeInsets.symmetric(horizontal: 69),

//                 child: Column(
//                   children: [
//                     Text(
//                       onboardingList[index].title,
//                       style: const TextStyle(
//                         fontSize: 22,
//                         fontWeight: FontWeight.w700,
//                         color: Color(0xff1F1F1F),
//                       ),
//                     ),
//                     const SizedBox(height: 8),

//                     Text(
//                       onboardingList[index].describtion,
//                       style: const TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.w400,
//                         color: Color(0xff5C5C5C),
//                       ),
//                       textAlign: TextAlign.center,
//                     ),
//                   ],
//                 ),
//               ),

//               SizedBox(height: 56),

//               SizedBox(
//                 width: double.infinity,

//                 child: MaterialButton(
//                   onPressed: () {
//                     controller.nextPage(
//                       duration: const Duration(milliseconds: 300),
//                       curve: Curves.easeInOut,
//                     );
//                   },

//                   color: Color(0xffFF9900),
//                   height: 24,

//                   child: Padding(
//                     padding: EdgeInsets.all(12.0),

//                     child: Text(
//                       onboardingList[index].textbtn,
//                       style: TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.w600,
//                         color: Colors.white,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:shopping_app/core/route/app_route.dart';
import 'package:shopping_app/core/theme/app_colors.dart';
import 'package:shopping_app/features/onboarding/presentation/view/widgets/item_card.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  static const String routeName = "OnboardingScreen";

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  PageController controller = PageController();

  int index = 0;

  List<OnboardingData> onboardingList = dataOnboarding();

  Future<void> saveOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('seenOnboarding', true);
  }

  Future<void> navigateToHome() async {
    await saveOnboarding();

    if (!mounted) return;

    Navigator.pushReplacementNamed(context, RoutesManager.home);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),

          child: Column(
            children: [
              // Skip / Arrow
              SizedBox(
                height: 50,
                width: double.infinity,
                child: Align(
                  alignment: Alignment.topRight,
                  child: index == 0
                      ? TextButton(
                          onPressed: navigateToHome,
                          child: Text(
                            "skip",
                            style: TextTheme.of(
                              context,
                            ).labelMedium?.copyWith(color: AppColors.greyDark),
                          ),
                        )
                      : Align(
                          alignment: Alignment.topLeft,
                          child: IconButton(
                            onPressed: () {
                              controller.previousPage(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                              );
                            },
                            icon: const Icon(
                              Icons.arrow_back,
                              color: AppColors.black,
                              size: 21,
                            ),
                          ),
                        ),
                ),
              ),

              Expanded(
                child: SizedBox(
                  width: double.infinity,
                  child: PageView.builder(
                    controller: controller,
                    onPageChanged: (value) {
                      setState(() {
                        index = value;
                      });
                    },

                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 35),

                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),

                          child: Image.asset(
                            onboardingList[index].images,
                            width: 350,
                            height: 300,
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },

                    itemCount: onboardingList.length,
                  ),
                ),
              ),

              const SizedBox(height: 16),

              SmoothPageIndicator(
                controller: controller,
                count: onboardingList.length,
                effect: const WormEffect(
                  activeDotColor: AppColors.primaryOrange,
                  dotColor: AppColors.grey,
                  dotHeight: 8,
                  dotWidth: 8,
                ),
              ),

              const SizedBox(height: 24),

              Container(
                margin: const EdgeInsets.symmetric(horizontal: 69),

                child: Column(
                  children: [
                    Text(
                      onboardingList[index].title,
                      style: TextTheme.of(
                        context,
                      ).bodyLarge?.copyWith(color: AppColors.greyDark),
                    ),
                    const SizedBox(height: 8),

                    Text(
                      onboardingList[index].describtion,
                      style: TextTheme.of(
                        context,
                      ).bodyMedium?.copyWith(color: AppColors.greyDark),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),

              SizedBox(height: 24),

              SizedBox(
                width: double.infinity,

                child: MaterialButton(
                  onPressed: () {
                    if (index < onboardingList.length - 1) {
                      controller.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    } else {
                      navigateToHome();
                    }
                  },

                  color: AppColors.primaryOrange,
                  height: 24,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),

                  child: Padding(
                    padding: EdgeInsets.all(12.0),

                    child: Text(
                      onboardingList[index].textbtn,
                      style: TextTheme.of(
                        context,
                      ).titleMedium?.copyWith(fontSize: 16),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}
