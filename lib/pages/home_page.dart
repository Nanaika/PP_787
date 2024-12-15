import 'package:PP_787/ui_kit/colors.dart';
import 'package:PP_787/ui_kit/text_styles.dart';
import 'package:PP_787/utils/assets_paths.dart';
import 'package:PP_787/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';



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
                Bar(),
              ],
            ),
          ),
          SizedBox(height: 32,),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16
                ),
                itemCount: AppIcons.mainPageIcons.length,
                itemBuilder: (context, index) {
                  return MainCategoryTile(assetPath: AppIcons.mainPageIcons[index], text: AppConstants.mainCategories[index],);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MainCategoryTile extends StatelessWidget {
  const MainCategoryTile({
    super.key, required this.assetPath, required this.text, this.isOn = true,
  });
  final String assetPath;
  final String text;
  final bool isOn;
  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(24),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  offset: Offset(0, 4),
                  blurRadius: 16,
                  color: AppColors.black.withOpacity(0.1)
                ),
              ],
              color: isOn ? AppColors.surface : AppColors.secondary,
              borderRadius: BorderRadius.circular(32.0),
            ),
            child: SvgPicture.asset(assetPath),
          ),
          SizedBox(height: 8,),
          Text(text, style: AppStyles.bodyMedium,)
        ],
      ),
    );
  }
}

class Bar extends StatefulWidget {
  const Bar({
    super.key,
  });

  @override
  State<Bar> createState() => _BarState();
}

class _BarState extends State<Bar> {
  double orangeWidthFactor = 0.1;
  double grayWidthFactor = 0.2;
  double blueWidthFactor = 0.7;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          orangeWidthFactor = orangeWidthFactor == 0.1 ? 0.7 : 0.1;
          grayWidthFactor = grayWidthFactor == 0.2 ? 0.2 : 0.2;
          blueWidthFactor = blueWidthFactor == 0.7 ? 0.1 : 0.7;
        });
      },
      child: Container(
        width: double.infinity,
        clipBehavior: Clip.hardEdge,
        height: 36,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(32.0),
        ),
        child: Row(
          children: [
            AnimatedContainer(
              width: orangeWidthFactor * (MediaQuery.of(context).size.width - 32),
              duration: AppConstants.duration200,
              child: Container(
                color: AppColors.orange,
              ),
            ),
            AnimatedContainer(
              width: grayWidthFactor * (MediaQuery.of(context).size.width - 32),
              duration: AppConstants.duration200,
              child: Container(
                color: AppColors.gray,
              ),
            ),
            AnimatedContainer(
              width: blueWidthFactor * (MediaQuery.of(context).size.width - 32),
              duration: AppConstants.duration200,
              child: Container(
                color: AppColors.blue,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
