import 'package:PP_787/navigation/routes.dart';
import 'package:PP_787/storages/models/check_in.dart';
import 'package:PP_787/ui_kit/colors.dart';
import 'package:PP_787/ui_kit/text_styles.dart';
import 'package:PP_787/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../utils/assets_paths.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 14 + MediaQuery.of(context).padding.top,
                ),
                Text(
                  'Your wellbeing this month',
                  style: AppStyles.displaySmall,
                ),
                SizedBox(
                  height: 16,
                ),
                // Bar(
                //   items: [],
                // ),
              ],
            ),
          ),
          SizedBox(
            height: 32,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: List.generate(3, (index) {
                    if (index % 2 != 0) {
                      return SizedBox(
                        width: 16,
                      );
                    }
                    return SafeArea(
                      bottom: true,
                      top: false,
                      child: Column(
                        children: List.generate(5, (innerIndex) {
                          if (innerIndex % 2 != 0) {
                            return SizedBox(
                              height: 16,
                            );
                          }
                          return CategoryTile(
                            assetPath: AppIcons.mainPageIcons[(index ~/ 2) + innerIndex],
                            text: AppConstants.mainCategories[(index ~/ 2) + innerIndex],
                            onTap: () {
                              switch ((index ~/ 2) + innerIndex) {
                                case 0:
                                  {
                                    Navigator.of(context).pushNamed(AppRoutes.checkIn);
                                    break;
                                  }
                                case 1:
                                  {
                                    Navigator.of(context).pushNamed(AppRoutes.timeLine);
                                    break;
                                  }
                                case 2:
                                  {
                                    Navigator.of(context).pushNamed(AppRoutes.trigger);
                                    break;
                                  }
                                case 3:
                                  {
                                    Navigator.of(context).pushNamed(AppRoutes.exercise);
                                    break;
                                  }
                                case 4:
                                  {
                                    Navigator.of(context).pushNamed(AppRoutes.anchor);
                                    break;
                                  }
                                case 5:
                                  {
                                    Navigator.of(context).pushNamed(AppRoutes.settings);
                                    break;
                                  }
                              }
                            },
                          );
                        }),
                      ),
                    );
                  }),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CategoryTile extends StatelessWidget {
  const CategoryTile({
    super.key,
    required this.assetPath,
    required this.text,
    this.isOn = true,
    this.onTap,
  });

  final String assetPath;
  final String text;
  final bool isOn;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: FittedBox(
        child: Column(
          children: [
            Container(
              width: (MediaQuery.of(context).size.width - 16 - 40) / 2,
              height: (MediaQuery.of(context).size.width - 16 - 40) / 2,
              padding: EdgeInsets.all(32),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 4),
                    blurRadius: 16,
                    color: AppColors.black.withOpacity(0.1),
                  ),
                ],
                color: isOn ? AppColors.surface : AppColors.secondary,
                borderRadius: BorderRadius.circular(32.0),
              ),
              child: SvgPicture.asset(
                assetPath,
                fit: BoxFit.scaleDown,
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              text,
              style: AppStyles.bodyMedium,
            )
          ],
        ),
      ),
    );
  }
}

class Bar extends StatefulWidget {
  const Bar({
    super.key,
    required this.items,
  });

  final List<CheckIn> items;

  @override
  State<Bar> createState() => _BarState();
}

class _BarState extends State<Bar> {
  @override
  Widget build(BuildContext context) {
    final sumPositivePower = widget.items.fold(0, (prev, item) {
      if (item.feeling == FeelingType.Positive) {
        return prev + item.feelingPower;
      } else {
        return prev;
      }
    });
    final sumNeutralPower = widget.items.fold(0, (prev, item) {
      if (item.feeling == FeelingType.Neutral) {
        return prev + item.feelingPower;
      } else {
        return prev;
      }
    });
    final sumNegativePower = widget.items.fold(0, (prev, item) {
      if (item.feeling == FeelingType.Negative) {
        return prev + item.feelingPower;
      } else {
        return prev;
      }
    });
    final totalPower = widget.items.fold(0, (prev, item) => prev + item.feelingPower);
    double positiveWidthFactor = 0;
    double neutralWidthFactor = 0;
    double negativeWidthFactor = 0;
    if (totalPower > 0) {
      positiveWidthFactor = sumPositivePower / totalPower.toDouble();
    }
    if(totalPower > 0) {
      neutralWidthFactor = sumNeutralPower / totalPower.toDouble();
    }
    if(totalPower > 0) {
      negativeWidthFactor = sumNegativePower / totalPower.toDouble();
    }
    print('TEST pos -------------------${positiveWidthFactor}');
    print('TEST nut -------------------${neutralWidthFactor}');
    print('TEST nega -------------------${negativeWidthFactor}');

    print('TEst ----- ${sumPositivePower}');
    print('TEst ----- ${sumNeutralPower}');
    print('TEst ----- ${sumNegativePower}');
    return Container(
      width: double.infinity,
      clipBehavior: Clip.hardEdge,
      height: 36,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32.0),
      ),
      child: Row(
        children: [
          AnimatedContainer(
            width: positiveWidthFactor * (MediaQuery.of(context).size.width - 32),
            duration: AppConstants.duration200,
            child: Container(
              color: AppColors.orange,
            ),
          ),
          AnimatedContainer(
            width: neutralWidthFactor * (MediaQuery.of(context).size.width - 32),
            duration: AppConstants.duration200,
            child: Container(
              color: AppColors.gray,
            ),
          ),
          AnimatedContainer(
            width: negativeWidthFactor * (MediaQuery.of(context).size.width - 32),
            duration: AppConstants.duration200,
            child: Container(
              color: AppColors.blue,
            ),
          ),
        ],
      ),
    );
  }
}
