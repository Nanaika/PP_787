import 'package:PP_787/bloc/emotions_bloc.dart';
import 'package:PP_787/navigation/routes.dart';
import 'package:PP_787/storages/models/check_in.dart';
import 'package:PP_787/ui_kit/text_styles.dart';
import 'package:PP_787/ui_kit/widgets/app_elevated_button.dart';
import 'package:PP_787/ui_kit/widgets/custom_app_bar.dart';
import 'package:PP_787/utils/assets_paths.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CheckedInPage extends StatelessWidget {
  const CheckedInPage({super.key});

  @override
  Widget build(BuildContext context) {
    final checkIn = ModalRoute.of(context)!.settings.arguments! as CheckIn;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const CustomAppBar(title: 'Check in'),
      ),
      body: Column(
        children: [
          Expanded(
            child: CheckedInView(
              onSave: () {
                if (checkIn.feelingPower == 0) {
                  checkIn.feelingPower = 1;
                }
                context.read<EmotionsBloc>().addCheckIn(checkIn);
                if (context.mounted) {
                  Navigator.of(context).pushNamedAndRemoveUntil(AppRoutes.home, (_) => false);
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

class CheckedInView extends StatelessWidget {
  const CheckedInView({
    super.key,
    required this.onSave,
  });

  final void Function() onSave;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 32,),
                const Text(
                  'You are checked in',
                  style: AppStyles.displayLarge,
                ),
                const SizedBox(
                  height: 32,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(32),
                  child: Image.asset(
                    width: double.infinity,
                    AppImages.checked_in,
                    fit: BoxFit.fitWidth,
                  ),
                ),
                SizedBox(
                  height: 32 + 54 + MediaQuery.of(context).padding.bottom,
                ),
              ],
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0 + MediaQuery.of(context).padding.bottom,
            child: AppElevatedButton(
              buttonText: 'Save',
              onTap: onSave,
            ),
          ),
        ],
      ),
    );
  }
}
