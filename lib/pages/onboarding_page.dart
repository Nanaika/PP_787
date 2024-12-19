import 'package:PP_787/navigation/routes.dart';
import 'package:PP_787/ui_kit/colors.dart';
import 'package:PP_787/ui_kit/text_styles.dart';
import 'package:PP_787/ui_kit/widgets/app_elevated_button.dart';
import 'package:PP_787/utils/assets_paths.dart';
import 'package:PP_787/utils/constants.dart';
import 'package:flutter/material.dart';

const String onBoardingText1 = 'Your personal\nwellbeing journal';
const String onBoardingText2 = 'Express your\nfeelings your way';
const String onBoardingText3 = 'Emotional\nintelligence tools\nand exercises';
const onBoardingTexts = [
  onBoardingText1,
  onBoardingText2,
  onBoardingText3,
];

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final pageController = PageController();
  int currentPage = 0;

  void _nextPage() {
    setState(() {
      if (currentPage != 2) {
        currentPage++;
        pageController.nextPage(duration: AppConstants.duration200, curve: Curves.easeInOut);
      } else {
        Navigator.of(context).pushNamed(AppRoutes.home);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          Positioned.fill(
            child: PageView(
              physics: const NeverScrollableScrollPhysics(),
              controller: pageController,
              children: List.generate(3, (index) {
                return OnboardingView(
                  backAssetPath: AppImages.onBoardingAssets[index],
                  text: onBoardingTexts[index],
                );
              }),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Padding(
              padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom, left: 16, right: 16),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      5,
                      (index) {
                        if (index.isEven) {
                          return OnboardingChip(
                            isActive: currentPage >= index ~/ 2,
                          );
                        } else {
                          return const SizedBox(
                            width: 8,
                          );
                        }
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  AppElevatedButton(
                    buttonText: currentPage != 2 ? 'Next' : 'Start',
                    onTap: () {
                      _nextPage();
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class OnboardingView extends StatelessWidget {
  const OnboardingView({
    super.key,
    required this.backAssetPath,
    required this.text,
  });

  final String backAssetPath;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset(
            backAssetPath,
            fit: BoxFit.cover,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 32.0, right: 32, top: 80 + MediaQuery.of(context).padding.top),
          child: FittedBox(
            child: Text(
              text,
              style: AppStyles.displayLarge,
            ),
          ),
        )
      ,],
    );
  }
}

class OnboardingChip extends StatelessWidget {
  const OnboardingChip({
    super.key,
    required this.isActive,
  });

  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: 32,
          height: 8,
          decoration: BoxDecoration(
            color: AppColors.white.withOpacity(0.3),
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        AnimatedOpacity(
          opacity: isActive ? 1 : 0,
          duration: AppConstants.duration200,
          child: Container(
            width: 32,
            height: 8,
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
        ),
      ],
    );
  }
}
