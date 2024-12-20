import 'package:PP_787/bloc/emotions_bloc.dart';
import 'package:PP_787/bloc/trigger_bloc.dart';
import 'package:PP_787/pages/settings_page.dart';
import 'package:PP_787/storages/models/trigger.dart';
import 'package:PP_787/ui_kit/colors.dart';
import 'package:PP_787/ui_kit/text_styles.dart';
import 'package:PP_787/ui_kit/widgets/app_elevated_button.dart';
import 'package:PP_787/ui_kit/widgets/custom_app_bar.dart';
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
    final trigger = ModalRoute.of(context)!.settings.arguments! as Trigger;
    return BlocProvider(
      create: (_) => TriggerBloc(trigger: trigger),
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
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [

                      const SizedBox(
                        height: 32,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: List.generate(5, (index) {
                          if (index % 2 != 0) {
                            return const SizedBox(
                              height: 16,
                            );
                          }
                          return SafeArea(
                            top: false,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: List.generate(7, (innerIndex) {
                                if (innerIndex % 2 != 0) {
                                  return const SizedBox(
                                    width: 16,
                                  );
                                }
                                final totalIndex = ((index ~/ 2) * 4) + (innerIndex ~/ 2);
                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selected = totalIndex;
                                    });
                                  },
                                  child: EmotionTile(
                                    selected: selected,
                                    totalIndex: totalIndex,
                                    isSelected: totalIndex == selected,
                                  ),
                                );
                              }),
                            ),
                          );
                        }),
                      ),
                      const SizedBox(
                        height: 32,
                      ),
                      AppElevatedButton(
                        buttonText: 'Submit',
                        onTap: () async {
                          context.read<TriggerBloc>().updateEmotion(selected);
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
    required this.isSelected,
  });

  final int selected;
  final int totalIndex;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 65,
      child: Column(
        children: [
          Stack(
            children: [
              AnimatedContainer(
                width: 65,
                height: 65,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(color: isSelected ? AppColors.primary : Colors.transparent, width: 4),
                  borderRadius: BorderRadius.circular(16),
                  color: AppColors.surface,
                  boxShadow: [
                    BoxShadow(
                      offset: const Offset(0, 4),
                      blurRadius: 16,
                      color: AppColors.black.withOpacity(0.1),
                    ),
                  ],
                ),
                duration: AppConstants.duration200,
                child: SvgPicture.asset(
                  AppIcons.triggerEmotionsIcons[totalIndex],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            overflow: TextOverflow.ellipsis,
            Emotions.values[totalIndex].name,
            style: AppStyles.bodyMedium,
          ),
        ],
      ),
    );
  }
}
