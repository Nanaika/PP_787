import 'package:PP_787/bloc/emotions_bloc.dart';
import 'package:PP_787/bloc/emotions_state.dart';
import 'package:PP_787/navigation/routes.dart';
import 'package:PP_787/storages/models/trigger.dart';
import 'package:PP_787/ui_kit/colors.dart';
import 'package:PP_787/ui_kit/text_styles.dart';
import 'package:PP_787/ui_kit/widgets/app_elevated_button.dart';
import 'package:PP_787/ui_kit/widgets/custom_app_bar.dart';
import 'package:PP_787/utils/assets_paths.dart';
import 'package:PP_787/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EditTriggerPage extends StatelessWidget {
  const EditTriggerPage({super.key});

  @override
  Widget build(BuildContext context) {
    final index = ModalRoute.of(context)!.settings.arguments! as int;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const CustomAppBar(title: 'Emotional trigger map'),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            BlocSelector<EmotionsBloc, EmotionsState, List<Trigger>>(
              builder: (BuildContext context, state) {
                if(state.length <= index) {
                  return const SizedBox();
                }
                if (state[index].emotions.isEmpty) {
                  return Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: EmptyView(
                        trigger: state[index],
                      ),
                    ),
                  );
                } else {
                  return Expanded(
                    child: Stack(
                      children: [
                        SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Column(
                              children: [
                                const SizedBox(height: 32,),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                        state[index].name,
                                        style: AppStyles.displayLarge,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 32,
                                ),
                                SingleChildScrollView(
                                  child: Column(
                                    children: List.generate(
                                        state[index].emotions.length + state[index].emotions.length - 1, (rowIndex) {
                                      if (rowIndex % 2 != 0) {
                                        return const SizedBox(
                                          height: 32,
                                        );
                                      }

                                      int max = state[index].emotions.reduce((a, b) => a.count > b.count ? a : b).count;
                                      for (int i = 0; i < state[index].emotions.length; i++) {
                                        if (state[index].emotions[i].count > max) {
                                          max = state[index].emotions[i].count;
                                        }
                                      }

                                      return Row(
                                        children: [
                                          SizedBox(
                                            width: 65,
                                            child: Column(
                                              children: [
                                                Container(
                                                  padding: const EdgeInsets.all(10),
                                                  width: 65,
                                                  height: 65,
                                                  child: SvgPicture.asset(
                                                    AppIcons.triggerEmotionsIcons[
                                                        state[index].emotions[rowIndex ~/ 2].type.index],
                                                  ),
                                                ),
                                                Text(
                                                  overflow: TextOverflow.ellipsis,
                                                  Emotions.values[state[index].emotions[rowIndex ~/ 2].type.index].name,
                                                  style: AppStyles.bodyMedium,
                                                ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 16,
                                          ),
                                          Expanded(
                                            child: AnimatedFractionallySizedBox(
                                              alignment: Alignment.topLeft,
                                              widthFactor: state[index].emotions[rowIndex ~/ 2].count / max,
                                              duration: AppConstants.duration200,
                                              child: AnimatedContainer(
                                                height: 35,
                                                decoration: BoxDecoration(
                                                  color: AppColors.primary,
                                                  borderRadius: BorderRadius.circular(32.0),
                                                ),
                                                duration: AppConstants.duration200,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 16,
                                          ),
                                          Text(
                                            state[index].emotions[rowIndex ~/ 2].count.toString(),
                                            style: AppStyles.displayLarge,
                                          ),
                                        ],
                                      );
                                    }),
                                  ),
                                ),
                                SizedBox(
                                  height: 32 + 16 + 54 + 54 + MediaQuery.of(context).padding.bottom,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: MediaQuery.of(context).padding.bottom,
                          left: 0,
                          right: 0,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Column(
                              children: [
                                AppElevatedButton(
                                  textColor: AppColors.black,
                                  backgroundColor: AppColors.secondary,
                                  buttonText: 'New emotion in the trigger',
                                  onTap: () {
                                    Navigator.of(context).pushNamed(AppRoutes.addEmotion, arguments: state[index]);
                                  },
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                AppElevatedButton(
                                  backgroundColor: AppColors.destructive,
                                  buttonText: 'Delete trigger',
                                  onTap: () async {
                                    await context.read<EmotionsBloc>().deleteTrigger(state[index].id);
                                    if (context.mounted) {
                                      Navigator.of(context).pop();
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }
              },
              selector: (state) {
                return state.triggers;
              },
            ),
          ],
        ),
      ),
    );
  }
}

class EmptyView extends StatelessWidget {
  const EmptyView({
    super.key,
    required this.trigger,
  });

  final Trigger trigger;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 32,
              ),
              const Text(
                'No records in this trigger yet',
                style: AppStyles.displayLarge,
              ),
              const SizedBox(
                height: 32,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(32),
                child: Image.asset(
                  AppImages.trigger3,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                height: 32 + 54 + MediaQuery.of(context).padding.bottom,
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 0 - MediaQuery.of(context).viewInsets.bottom + MediaQuery.of(context).padding.bottom,
          left: 0,
          right: 0,
          child: AppElevatedButton(
            buttonText: 'New emotion in the trigger',
            onTap: () {
              Navigator.of(context).pushNamed(AppRoutes.addEmotion, arguments: trigger);
            },
          ),
        ),
      ],
    );
  }
}
