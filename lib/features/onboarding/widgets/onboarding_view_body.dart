import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:tasky/core/utils/app_colors.dart';
import 'package:tasky/core/utils/app_styles.dart';
import 'package:tasky/core/utils/assets.dart';

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
            height: MediaQuery.sizeOf(context).height * 0.5,
            child: PageView.builder(
              onPageChanged: (value) {
                setState(() {
                  currentIndex = value;
                });
              },
              controller: _pageController,
              itemCount: 3,
              itemBuilder: (context, index) {
                return Container(
                  color: AppColors.scaffoldColor,
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    children: [
                      SizedBox(height: 150),
                      SizedBox(
                        height: 300,

                        child: Image.asset(
                          page[index]["image"]!,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 20),
          SmoothPageIndicator(
            controller: _pageController,
            count: 3,
            effect: WormEffect(
              activeDotColor: AppColors.primaryColor,
              dotHeight: 6,
              dotWidth: 30,
              spacing: 8,
              radius: 56,
            ),
          ),
          SizedBox(height: 70),
          Text(
            page[currentIndex]["title"]!,
            style: AppStyles.latoBold32.copyWith(color: AppColors.titleColor),
          ),
          SizedBox(height: 30),
          Text(
            textAlign: TextAlign.center,
            maxLines: 2,
            page[currentIndex]["subTitle"]!,
            style: AppStyles.latoRegular16.copyWith(
              color: AppColors.subTitleColor,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: "button",

        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        backgroundColor: AppColors.primaryColor,
        onPressed: () {
          if (currentIndex <= 1) {
            setState(() {
              currentIndex++;
              _pageController.animateToPage(
                currentIndex,
                duration: const Duration(milliseconds: 800),
                curve: Curves.fastOutSlowIn,
              );
            });
          }
        },
        label: Text(
          currentIndex <= 1 ? "NEXT" : "GET STARTED",
          style: AppStyles.latoRegular18.copyWith(color: Color(0xffFFFFFF)),
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
        "You can easily manage all of your daily                                 tasks in DoMe for free",
  },
  {
    "image": Assets.imagesOnboarding2,
    "title": "Create daily routine",
    "subTitle":
        "In Tasky  you can create your personalized                        routine to stay productive",
  },
  {
    "image": Assets.imagesOnboarding3,
    "title": "Orgonaize your tasks",
    "subTitle":
        "You can organize your daily tasks by                                    adding your tasks into separate categories",
  },
];
