import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:tasky/core/services/cache_helper.dart';
import 'package:tasky/core/utils/app_colors.dart';
import 'package:tasky/core/utils/app_styles.dart';
import 'package:tasky/core/utils/assets.dart';
import 'package:tasky/features/auth/presentation/views/login_view.dart';

class OnboardingViewBody extends StatefulWidget {
  const OnboardingViewBody({super.key});

  @override
  State<OnboardingViewBody> createState() => _OnboardingViewBodyState();
}

class _OnboardingViewBodyState extends State<OnboardingViewBody> {
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.75,
            child: PageView.builder(
              onPageChanged: (value) {
                setState(() {
                  currentIndex = value;
                });
              },
              controller: _pageController,
              itemCount: page.length,
              itemBuilder: (context, index) {
                return Container(
                  color: AppColors.scaffoldColor,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      const SizedBox(height: 120),

                      ZoomIn(
                        duration: const Duration(milliseconds: 800),
                        child: SizedBox(
                          height: 280,
                          child: Image.asset(
                            page[index]["image"]!,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),

                      const SizedBox(height: 40),

                      FadeInRight(
                        duration: const Duration(milliseconds: 800),
                        child: Text(
                          page[index]["title"]!,
                          style: AppStyles.latoBold32.copyWith(
                            color: AppColors.titleColor,
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      FadeInLeft(
                        duration: const Duration(milliseconds: 800),
                        child: Text(
                          page[index]["subTitle"]!,
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          style: AppStyles.latoRegular16.copyWith(
                            color: AppColors.subTitleColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 20),

          SmoothPageIndicator(
            controller: _pageController,
            count: page.length,
            effect: WormEffect(
              activeDotColor: AppColors.primaryColor,
              dotHeight: 6,
              dotWidth: 30,
              spacing: 8,
              radius: 56,
            ),
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton.extended(
        heroTag: "button",
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        backgroundColor: AppColors.primaryColor,
        onPressed: () async {
          if (currentIndex < page.length - 1) {
            setState(() {
              currentIndex++;
              _pageController.animateToPage(
                currentIndex,
                duration: const Duration(milliseconds: 800),
                curve: Curves.fastOutSlowIn,
              );
            });
          } else {
            await CacheHelper().saveData(key: 'NewUser', value: true);

            Navigator.pushReplacement(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) {
                  return const LoginView();
                },
              ),
            );
          }
        },
        label: Text(
          currentIndex < page.length - 1 ? "NEXT" : "GET STARTED",
          style: AppStyles.latoRegular18.copyWith(
            color: const Color(0xffFFFFFF),
          ),
        ),
      ),
    );
  }
}

List<Map<String, String>> page = [
  {
    "image": Assets.imagesOnboarding1,
    "title": "Manage your tasks",
    "subTitle":
        "You can easily manage all of your daily tasks in DoMe for free",
  },
  {
    "image": Assets.imagesOnboarding2,
    "title": "Create daily routine",
    "subTitle":
        "In Tasky you can create your personalized routine to stay productive",
  },
  {
    "image": Assets.imagesOnboarding3,
    "title": "Organize your tasks",
    "subTitle":
        "You can organize your daily tasks by adding them into separate categories",
  },
];
