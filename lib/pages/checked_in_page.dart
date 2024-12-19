import 'package:PP_787/bloc/emotions_bloc.dart';
import 'package:PP_787/navigation/routes.dart';
import 'package:PP_787/pages/settings_page.dart';
import 'package:PP_787/storages/models/check_in.dart';
import 'package:PP_787/ui_kit/text_styles.dart';
import 'package:PP_787/ui_kit/widgets/app_elevated_button.dart';
import 'package:PP_787/utils/assets_paths.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CheckedInPage extends StatelessWidget {
  const CheckedInPage({super.key});

  @override
  Widget build(BuildContext context) {
    final checkIn = ModalRoute.of(context)?.settings.arguments as CheckIn;
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 14 + MediaQuery.of(context).padding.top, left: 16, right: 16),
            child: TopBar(
              title: 'Check in',
              backPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
          SizedBox(
            height: 32,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: EmptyTriggersView(
                onSave: () {
                  if(checkIn.feelingPower == 0) {
                    checkIn.feelingPower = 1;
                  }
                  context.read<EmotionsBloc>().addCheckIn(checkIn);
                  if (context.mounted) {
                    Navigator.of(context).pushNamedAndRemoveUntil(AppRoutes.home, (_) => false);
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class EmptyTriggersView extends StatelessWidget {
  const EmptyTriggersView({
    super.key,
    required this.onSave,
  });

  final void Function() onSave;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                'You are checked in',
                style: AppStyles.displayLarge,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 32,
        ),
        Expanded(
          child: ClipRRect(
              borderRadius: BorderRadius.circular(32),
              child: Image.asset(
                width: double.infinity,
                AppImages.checked_in,
                fit: BoxFit.cover,
              )),
        ),
        SizedBox(
          height: 32,
        ),
        AppElevatedButton(
          buttonText: 'Save',
          onTap: onSave,
        ),
        SizedBox(
          height: MediaQuery.of(context).padding.bottom,
        ),
      ],
    );
  }
}
