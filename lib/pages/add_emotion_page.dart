import 'package:PP_787/bloc/emotions_bloc.dart';
import 'package:PP_787/bloc/trigger_bloc.dart';
import 'package:PP_787/pages/settings_page.dart';
import 'package:PP_787/storages/models/trigger.dart';
import 'package:PP_787/ui_kit/colors.dart';
import 'package:PP_787/ui_kit/text_styles.dart';
import 'package:PP_787/ui_kit/widgets/app_elevated_button.dart';
import 'package:PP_787/utils/assets_paths.dart';
import 'package:PP_787/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class AddEmotionPage extends StatefulWidget {
  const AddEmotionPage({super.key});

  @override
  State<AddEmotionPage> createState() => _AddEmotionPageState();
}

class _AddEmotionPageState extends State<AddEmotionPage> {
  int selected = -1;

  @override
  Widget build(BuildContext context) {
    final trigger = ModalRoute.of(context)?.settings.arguments as Trigger;
    print('TEEEEEEE---------------------- ${trigger.emotions.length}');
    return BlocProvider(
      create: (_) => TriggerBloc(trigger: trigger),
      child: Builder(
        builder: (context) {
          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
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
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(5, (index) {
                        if (index % 2 != 0) {
                          return SizedBox(
                            height: 16,
                          );
                        }
                        return SafeArea(
                          bottom: true,
                          top: false,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: List.generate(7, (innerIndex) {
                              if (innerIndex % 2 != 0) {
                                return SizedBox(
                                  width: 16,
                                );
                              }
                              final totalIndex = ((index ~/ 2) * 4) + (innerIndex ~/ 2);
                              print('INDEX -------  $totalIndex');
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selected = totalIndex;
                                  });
                                },
                                child: EmotionTile(selected: selected, totalIndex: totalIndex),
                              );
                            }),
                          ),
                        );
                      }),
                    ),
                    SizedBox(
                      height: 32,
                    ),
                    AppElevatedButton(
                      buttonText: 'Submit',
                      onTap: () async {
                        print('HASH-------------------${context.read<TriggerBloc>().hashCode}');
                        context.read<TriggerBloc>().updateEmotion(selected);
                        print('HASH-------------------${context.read<TriggerBloc>().hashCode}');
                        final emotions = context.read<TriggerBloc>().state.emotions;
                        await context.read<EmotionsBloc>().updateEmotions(trigger.id, emotions);

                        if (context.mounted) {
                          Navigator.of(context).pop();
                        }
                      },
                      isActive: selected != -1,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).padding.bottom,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class EmotionTile extends StatelessWidget {
  const EmotionTile({
    super.key,
    required this.selected,
    required this.totalIndex,
  });

  final int selected;
  final int totalIndex;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            Container(
              width: 65,
              height: 65,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: AppColors.surface,
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 4),
                    blurRadius: 16,
                    color: AppColors.black.withOpacity(0.1),
                  ),
                ],
              ),
              child: SvgPicture.asset(
                AppIcons.triggerEmotionsIcons[totalIndex],
              ),
            ),
            AnimatedOpacity(
              opacity: selected == totalIndex ? 1 : 0,
              duration: AppConstants.duration200,
              child: Container(
                width: 65,
                height: 65,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: AppColors.secondary,
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0, 4),
                      blurRadius: 16,
                      color: AppColors.black.withOpacity(0.1),
                    ),
                  ],
                ),
                child: SvgPicture.asset(
                  AppIcons.triggerEmotionsIcons[totalIndex],
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 8,
        ),
        Text(
          TriggerEmotions.values[totalIndex].name,
          style: AppStyles.bodyMedium,
        )
      ],
    );
  }
}
