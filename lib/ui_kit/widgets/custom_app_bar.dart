import 'package:PP_787/ui_kit/text_styles.dart';
import 'package:flutter/cupertino.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    super.key, required this.title,
  });
  final String title;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pop();
      },
      child: Stack(
        children: [
          const SizedBox(
            width: 24,
            height: 24,
            child: Align(
                alignment: Alignment.centerLeft,
                child: Icon(
                  CupertinoIcons.chevron_back,
                  size: 24,
                )),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 24 + 6),
            child: Text(
              title,
              style: AppStyles.displaySmall,
            ),
          ),
        ],
      ),
    );
  }
}
