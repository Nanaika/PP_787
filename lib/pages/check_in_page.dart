import 'package:PP_787/bloc/check_in_bloc.dart';
import 'package:PP_787/bloc/emotions_bloc.dart';
import 'package:PP_787/pages/settings_page.dart';
import 'package:PP_787/storages/models/check_in.dart';
import 'package:PP_787/storages/models/trigger.dart';
import 'package:PP_787/ui_kit/colors.dart';
import 'package:PP_787/ui_kit/text_styles.dart';
import 'package:PP_787/ui_kit/widgets/app_elevated_button.dart';
import 'package:PP_787/ui_kit/widgets/app_text_form_field.dart';
import 'package:PP_787/utils/assets_paths.dart';
import 'package:PP_787/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

const feelings = ['Positive', 'Neutral', 'Negative'];

class CheckInPage extends StatefulWidget {
  const CheckInPage({super.key});

  @override
  State<CheckInPage> createState() => _CheckInPageState();
}

class _CheckInPageState extends State<CheckInPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CheckInBloc(),
      child: Builder(
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
                          title: 'Check in',
                          backPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ),
                      SizedBox(
                        height: 32,
                      ),
                      BlocSelector<CheckInBloc, CheckIn, bool>(
                        selector: (CheckIn state) {
                          return state.isCustom;
                        },
                        builder: (BuildContext context, bool outerState) {
                          return IndexedStack(
                              index: outerState ? 1 : 0,
                              children: List.generate(2, (index) {
                                return BlocSelector<CheckInBloc, CheckIn, int>(
                                  selector: (CheckIn state) {
                                    return state.index;
                                  },
                                  builder: (context, state) {
                                    return EmotionsTilesGroup(
                                      selected: state,
                                      onSelected: (index) {
                                        context.read<CheckInBloc>().updateIndex(index);
                                      },
                                      isCustom: outerState,
                                    );
                                  },
                                );
                              }));
                        },
                      ),
                      SizedBox(
                        height: 32,
                      ),
                      BlocSelector<CheckInBloc, CheckIn, bool>(
                        selector: (CheckIn state) {
                          return state.isCustom;
                        },
                        builder: (BuildContext context, bool state) {
                          return AppElevatedButton(
                            textColor: AppColors.black,
                            backgroundColor: AppColors.secondary,
                            buttonText: !state ? 'Use custom emotion' : 'Use pre-made emotions',
                            onTap: () async {
                              context.read<CheckInBloc>().updateIsCustom(!state);
                            },
                          );
                        },
                      ),
                      SizedBox(
                        height: 32,
                      ),
                      Row(
                        children: [
                          Text(
                            'Generally this feeling is',
                            style: AppStyles.bodyMedium,
                          )
                        ],
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Row(
                        children: List.generate(5, (index) {
                          if (index % 2 != 0) {
                            return SizedBox(
                              width: 20,
                            );
                          }
                          return BlocSelector<CheckInBloc, CheckIn, FeelingType>(
                            selector: (CheckIn state) {
                              return state.feeling;
                            },
                            builder: (BuildContext context, FeelingType state) {
                              return FeelingTile(
                                index: index,
                                selected: state.index == index ~/ 2,
                                onTap: () {
                                  context.read<CheckInBloc>().updateFeelingType(FeelingType.values[index ~/ 2]);
                                },
                              );
                            },
                          );
                        }),
                      ),
                      SizedBox(
                        height: 32,
                      ),
                      Row(
                        children: [
                          Text(
                            'How strong is that feeling',
                            style: AppStyles.bodyMedium,
                          )
                        ],
                      ),
                      SizedBox(
                        height: 32,
                      ),
                      Row(
                        children: [
                          Expanded(child: BlocBuilder<CheckInBloc, CheckIn>(
                            builder: (context, state) {
                              return CustomSlider(
                                feelingIndex: state.feeling.index,
                                onChanged: (value) {
                                  context.read<CheckInBloc>().updateFeelingPower(value);
                                },
                                value: context.read<CheckInBloc>().state.feelingPower != 0
                                    ? ((context.read<CheckInBloc>().state.feelingPower) - 1) / 4
                                    : 0,
                              );
                            },
                          )),
                        ],
                      ),
                      SizedBox(
                        height: 32,
                      ),
                      Row(
                        children: [
                          Text(
                            'What was this emotion triggered by',
                            style: AppStyles.bodyMedium,
                          )
                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      AppTextFormField(
                        hint: 'What was this emotion triggered by',
                        onChanged: (text) {
                          context.read<CheckInBloc>().updateTriggerBy(text);
                        },
                      ),
                      SizedBox(
                        height: 32,
                      ),
                      BlocBuilder<CheckInBloc, CheckIn>(
                        builder: (BuildContext context, CheckIn state) {
                          return AppElevatedButton(
                            buttonText: 'Submit',
                            onTap: () {
                              final checkIn = context.read<CheckInBloc>().state;
                              context.read<EmotionsBloc>().addCheckIn(checkIn);
                              if (context.mounted) {
                                Navigator.of(context).pop();
                              }
                            },
                            // isActive: true,
                            isActive: context.read<CheckInBloc>().canSave(),
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
    );
  }
}

class CustomSlider extends StatelessWidget {
  const CustomSlider({
    super.key,
    required this.feelingIndex,
    required this.value,
    this.onChanged,
  });

  final int feelingIndex;
  final double value;
  final void Function(double)? onChanged;

  @override
  Widget build(BuildContext context) {
    final color = switch (feelingIndex) {
      0 => AppColors.orange,
      1 => AppColors.gray,
      2 => AppColors.primary,
      int() => AppColors.secondary,
    };
    return CupertinoSlider(
      divisions: 4,
      value: value,
      onChanged: onChanged,
      activeColor: color,
      thumbColor: color,
    );
  }
}

class FeelingTile extends StatelessWidget {
  const FeelingTile({
    super.key,
    required this.index,
    this.onTap,
    required this.selected,
  });

  final int index;
  final void Function()? onTap;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          height: 60,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            border: Border.all(color: selected ? AppColors.primary : Colors.transparent, width: 4),
            boxShadow: [
              BoxShadow(
                offset: Offset(0, 4),
                blurRadius: 16,
                color: AppColors.black.withOpacity(0.1),
              ),
            ],
            image: DecorationImage(
                image: AssetImage(
                  AppImages.feelings[index ~/ 2],
                ),
                fit: BoxFit.cover),
            borderRadius: BorderRadius.circular(16.0),
          ),
          duration: AppConstants.duration200,
          child: Center(
              child: Text(
            feelings[index ~/ 2],
            style: AppStyles.bodyMedium.copyWith(color: AppColors.white),
          )),
        ),
      ),
    );
  }
}

class EmotionsTilesGroup extends StatelessWidget {
  const EmotionsTilesGroup({
    super.key,
    required this.selected,
    required this.onSelected,
    this.isCustom = false,
  });

  final int selected;
  final void Function(int) onSelected;
  final bool isCustom;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
                  return GestureDetector(
                    onTap: () {
                      onSelected(totalIndex);
                    },
                    child: EmotionTile(
                      selected: selected,
                      totalIndex: totalIndex,
                      isCustom: isCustom,
                      isSelected: totalIndex == selected,
                    ),
                  );
                }),
              ),
            );
          }),
        ),
        if (isCustom)
          Column(
            children: [
              SizedBox(
                height: 16,
              ),
              Row(
                children: [
                  Text(
                    'Name that emotion',
                    style: AppStyles.labelMedium,
                  )
                ],
              ),
              SizedBox(
                height: 8,
              ),
              BlocSelector<CheckInBloc, CheckIn, String>(
                selector: (CheckIn state) {
                  return state.name;
                },
                builder: (context, state) {
                  return AppTextFormField(
                    hint: 'Name that emotion',
                    onChanged: (text) {
                      context.read<CheckInBloc>().updateName(text);
                    },
                  );
                },
              ),
            ],
          ),
      ],
    );
  }
}

class EmotionTile extends StatelessWidget {
  const EmotionTile({
    super.key,
    required this.selected,
    required this.totalIndex,
    this.isCustom = false,
    this.isSelected = false,
  });

  final int selected;
  final int totalIndex;
  final bool isCustom;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            AnimatedContainer(
              width: 65,
              height: 65,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(color: isSelected ? AppColors.primary : Colors.transparent, width: 4),
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
              duration: AppConstants.duration200,
              child: SvgPicture.asset(
                isCustom ? AppIcons.customEmotions[totalIndex] : AppIcons.triggerEmotionsIcons[totalIndex],
              ),
            ),
          ],
        ),
        if (!isCustom)
          SizedBox(
            height: 8,
          ),
        if (!isCustom)
          Text(
            Emotions.values[totalIndex].name,
            style: AppStyles.bodyMedium,
          ),
      ],
    );
  }
}
