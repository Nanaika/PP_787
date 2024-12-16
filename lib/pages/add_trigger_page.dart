import 'package:PP_787/bloc/anchor_bloc.dart';
import 'package:PP_787/bloc/emotions_bloc.dart';
import 'package:PP_787/bloc/trigger_bloc.dart';
import 'package:PP_787/pages/settings_page.dart';
import 'package:PP_787/storages/models/anchor.dart';
import 'package:PP_787/storages/models/trigger.dart';
import 'package:PP_787/ui_kit/text_styles.dart';
import 'package:PP_787/ui_kit/widgets/app_elevated_button.dart';
import 'package:PP_787/ui_kit/widgets/app_text_form_field.dart';
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
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: LayoutBuilder(
                builder: (ctx, constrains) {
                  return SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(minWidth: constrains.maxWidth, minHeight: constrains.maxHeight),
                      child: IntrinsicHeight(
                        child: GestureDetector(
                          onTap: () {
                            FocusManager.instance.primaryFocus?.unfocus();
                          },
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(top: 14 + MediaQuery.of(context).padding.top),
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
                              Expanded(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(32),
                                  child: Image.asset(
                                    width: double.infinity,
                                    AppImages.trigger2,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 32,
                              ),
                              Row(
                                children: [
                                  Text(
                                    'Trigger name',
                                    style: AppStyles.labelMedium,
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
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
                                height: 32,
                              ),
                              BlocBuilder<TriggerBloc, Trigger>(
                                builder: (context, state) {
                                  return AppElevatedButton(
                                    buttonText: 'Add new trigger',
                                    onTap: () async {
                                      await context.read<EmotionsBloc>().addTrigger(state);
                                      if (context.mounted) {
                                        Navigator.of(context).pop();
                                      }
                                    },
                                    isActive: context.read<TriggerBloc>().canSave(),
                                  );
                                },
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
              ),
            ),
          );
        },
      ),
    );
  }
}
