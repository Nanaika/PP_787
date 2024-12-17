import 'package:PP_787/pages/home_page.dart';
import 'package:PP_787/ui_kit/text_styles.dart';
import 'package:PP_787/utils/assets_paths.dart';
import 'package:PP_787/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Padding(
              padding: EdgeInsets.only(top: 14 + MediaQuery.of(context).padding.top),
              child: TopBar(title: 'Settings', backPressed: () {
                Navigator.of(context).pop();
              },),
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
                              assetPath: AppIcons.settingsIcons[(index ~/ 2) + innerIndex],
                              text: AppConstants.settingsCategories[(index ~/ 2) + innerIndex]);
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

class TopBar extends StatelessWidget {
  const TopBar({
    super.key, required this.title, this.backPressed,
  });
  final String title;
  final void Function()? backPressed;
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: backPressed,
          child: Container(
            width: 24,
            height: 24,
            child: Icon(CupertinoIcons.chevron_back, size: 24,),
          ),
        ),
        SizedBox(width: 6,),
        Text(
          title,
          style: AppStyles.displaySmall,
        ),
        SizedBox(
          height: 16,
        ),
      ],
    );
  }
}
