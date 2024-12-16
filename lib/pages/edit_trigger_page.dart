import 'package:PP_787/navigation/routes.dart';
import 'package:PP_787/pages/settings_page.dart';
import 'package:PP_787/storages/models/trigger.dart';
import 'package:PP_787/ui_kit/text_styles.dart';
import 'package:PP_787/ui_kit/widgets/app_elevated_button.dart';
import 'package:PP_787/utils/assets_paths.dart';
import 'package:flutter/material.dart';

class EditTriggerPage extends StatelessWidget {
  const EditTriggerPage({super.key});

  @override
  Widget build(BuildContext context) {

   final trigger =  ModalRoute.of(context)?.settings.arguments as Trigger;

    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 14 + MediaQuery.of(context).padding.top, left: 16, right: 16),
            child: TopBar(
              title: 'Emotional trigger map',
              backPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
          SizedBox(
            height: 32,
          ),
          if(trigger.emotions.isEmpty)
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: EmptyView(trigger: trigger,),
            ),
          ),
          if(trigger.emotions.isNotEmpty)
          Center(child: Text('NOT EMPTY'),),
        ],
      ),
    );
  }
}

class EmptyView extends StatelessWidget {
  const EmptyView({
    super.key, required this.trigger,
  });
  final Trigger trigger;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FittedBox(
          child: Text(
            'No records in this\ntrigger yet',
            style: AppStyles.displayLarge,
          ),
        ),
        SizedBox(
          height: 32,
        ),
        Expanded(
          child: ClipRRect(
              borderRadius: BorderRadius.circular(32),
              child: Image.asset(
                AppImages.trigger3,
                fit: BoxFit.cover,
              )),
        ),
        SizedBox(
          height: 32,
        ),
        AppElevatedButton(
            buttonText: 'New emotion in the trigger',
            onTap: () {
              Navigator.of(context).pushNamed(AppRoutes.addEmotion, arguments: trigger);
            }),
        SizedBox(
          height: MediaQuery.of(context).padding.bottom,
        ),
      ],
    );
  }
}
