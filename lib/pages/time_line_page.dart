import 'package:PP_787/pages/home_page.dart';
import 'package:PP_787/pages/settings_page.dart';
import 'package:PP_787/ui_kit/text_styles.dart';
import 'package:flutter/material.dart';

class TimeLinePage extends StatefulWidget {
  const TimeLinePage({super.key});

  @override
  State<TimeLinePage> createState() => _TimeLinePageState();
}

class _TimeLinePageState extends State<TimeLinePage> {
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return Scaffold(
          body: GestureDetector(
            onTap: () {
              FocusManager.instance.primaryFocus?.unfocus();
            },
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 14 + MediaQuery.of(context).padding.top),
                      child: TopBar(
                        title: 'Timeline',
                        backPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                    SizedBox(
                      height: 32,
                    ),
                    StatsBar(title: 'Your week',),
                    SizedBox(
                      height: 32,
                    ),
                    StatsBar(title: 'Your month',),
                    SizedBox(
                      height: 32,
                    ),
                    StatsBar(title: 'Your year',),
                    SizedBox(
                      height: 16,
                    ),
                    SizedBox(
                      height: 32,
                    ),
                    SizedBox(
                      height: 32,
                    ),
                    SizedBox(
                      height: 32,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    SizedBox(
                      height: 32,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).padding.bottom,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class StatsBar extends StatelessWidget {
  const StatsBar({
    super.key, required this.title,
  });
  final String title;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              title,
              style: AppStyles.bodyMedium,
            )
          ],
        ),
        SizedBox(
          height: 16,
        ),
        Bar(),
      ],
    );
  }
}
