import 'package:PP_787/bloc/emotions_bloc.dart';
import 'package:PP_787/bloc/trigger_bloc.dart';
import 'package:PP_787/storages/models/trigger.dart';
import 'package:PP_787/ui_kit/text_styles.dart';
import 'package:PP_787/ui_kit/widgets/app_elevated_button.dart';
import 'package:PP_787/ui_kit/widgets/app_text_form_field.dart';
import 'package:PP_787/ui_kit/widgets/custom_app_bar.dart';
import 'package:PP_787/utils/assets_paths.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddTriggerPage extends StatelessWidget {
  const AddTriggerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TriggerBloc(),
      child: Builder(
        builder: (context) {
          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              title: const CustomAppBar(title: 'Emotional trigger map'),
            ),
            body: GestureDetector(
              onTap: () {
                FocusManager.instance.primaryFocus?.unfocus();
              },
              child: Stack(
                children: [
                  SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 32,
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(32),
                            child: Image.asset(
                              width: double.infinity,
                              AppImages.trigger2,
                              fit: BoxFit.fitWidth,
                            ),
                          ),
                          const SizedBox(
                            height: 32,
                          ),
                          const Row(
                            children: [
                              Text(
                                'Trigger name',
                                style: AppStyles.labelMedium,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: (MediaQuery.of(context).size.width / 2) - 32,
                                child: AppTextFormField(
                                  hint: 'A friend group brunch',
                                  onChanged: (text) {
                                    context.read<TriggerBloc>().updateName(text);
                                  },
                                  formatters: [LengthLimitingTextInputFormatter(50)],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 32 + 54 + MediaQuery.of(context).padding.bottom,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0 - MediaQuery.of(context).viewInsets.bottom + MediaQuery.of(context).padding.bottom,
                    left: 0,
                    right: 0,
                    child: BlocBuilder<TriggerBloc, Trigger>(
                      builder: (context, state) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: AppElevatedButton(
                            buttonText: 'Add new trigger',
                            onTap: () async {
                              await context.read<EmotionsBloc>().addTrigger(state);
                              if (context.mounted) {
                                Navigator.of(context).pop();
                              }
                            },
                            isActive: context.read<TriggerBloc>().canSave(),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
