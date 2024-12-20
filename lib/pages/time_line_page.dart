import 'package:PP_787/bloc/emotions_bloc.dart';
import 'package:PP_787/bloc/emotions_state.dart';
import 'package:PP_787/pages/home_page.dart';
import 'package:PP_787/storages/models/check_in.dart';
import 'package:PP_787/storages/models/exercise.dart';
import 'package:PP_787/storages/models/trigger.dart';
import 'package:PP_787/ui_kit/colors.dart';
import 'package:PP_787/ui_kit/text_styles.dart';
import 'package:PP_787/ui_kit/widgets/custom_app_bar.dart';
import 'package:PP_787/utils/assets_paths.dart';
import 'package:PP_787/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

const questions = [
  'When did you feel the same thing?',
  'How would you describe this to another person',
  'How does this emotion influence your actions',
  'Where do you feel this emotion in your body',
  'Reflection complete',
];

class TimeLinePage extends StatefulWidget {
  const TimeLinePage({super.key});

  @override
  State<TimeLinePage> createState() => _TimeLinePageState();
}

class _TimeLinePageState extends State<TimeLinePage> {
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: const CustomAppBar(title: 'Timeline'),
          ),
          body: GestureDetector(
            onTap: () {
              FocusManager.instance.primaryFocus?.unfocus();
            },
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.zero,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 24,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: BlocSelector<EmotionsBloc, EmotionsState, List<CheckIn>>(
                        selector: (state) {
                          return state.allCheckIns;
                        },
                        builder: (context, state) {
                          final selectedDate = context.read<EmotionsBloc>().state.date;

                          final startOfWeek = selectedDate.subtract(Duration(days: selectedDate.weekday - 1));
                          final DateTime endOfWeek = startOfWeek.add(const Duration(days: 6));

                          final weekly = state.where((elem) {
                            return elem.date.isAfter(startOfWeek) && elem.date.isBefore(endOfWeek);
                          }).toList();

                          return StatsBar(
                            items: weekly,
                            title: 'Your week',
                          );
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: BlocSelector<EmotionsBloc, EmotionsState, List<CheckIn>>(
                        selector: (state) {
                          return state.allCheckIns;
                        },
                        builder: (context, state) {
                          final selectedDate = context.read<EmotionsBloc>().state.date;

                          final monthly = state.where((elem) {
                            return elem.date.month == selectedDate.month && elem.date.year == selectedDate.year;
                          }).toList();

                          return StatsBar(
                            items: monthly,
                            title: 'Your month',
                          );
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: BlocSelector<EmotionsBloc, EmotionsState, List<CheckIn>>(
                        selector: (state) {
                          return state.allCheckIns;
                        },
                        builder: (context, state) {
                          final selectedDate = context.read<EmotionsBloc>().state.date;

                          final yearly = state.where((elem) {
                            return elem.date.year == selectedDate.year;
                          }).toList();

                          return StatsBar(
                            items: yearly,
                            title: 'Your year',
                          );
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: CalendarView(),
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        children: [
                          BlocSelector<EmotionsBloc, EmotionsState, DateTime>(
                            selector: (EmotionsState state) {
                              return state.date;
                            },
                            builder: (BuildContext context, DateTime state) {
                              return Text(
                                DateFormat('dd MMMM').format(state),
                                style: AppStyles.displaySmall,
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    const CheckInsView(),
                     ExercisesView(
                      isDrawTopDivider: context.read<EmotionsBloc>().state.checkIns.isEmpty,
                    ),
                    BlocBuilder<EmotionsBloc, EmotionsState>(
                      builder: (ctx, state) {
                        if (state.checkIns.isEmpty && state.exercises.isEmpty) {
                          return Stack(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Image.asset(
                                        AppImages.tl_empty,
                                        fit: BoxFit.fitWidth,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const Positioned(
                                top: 45,
                                left: 0,
                                right: 0,
                                child: Text(
                                  textAlign: TextAlign.center,
                                  'No data yet',
                                  style: AppStyles.displaySmall,
                                ),
                              ),
                            ],
                          );
                        } else {
                          return const SizedBox.shrink();
                        }
                      },
                    ),
                    const SizedBox(
                      height: 8,
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
    );
  }
}

//TODO components

class ExercisesView extends StatelessWidget {
  const ExercisesView({
    super.key, this.isDrawTopDivider = false,
  });
  final bool isDrawTopDivider;
  @override
  Widget build(BuildContext context) {
    return BlocSelector<EmotionsBloc, EmotionsState, List<Exercise>>(
      selector: (state) {
        return state.exercises;
      },
      builder: (context, state) {
        return Column(
          children: List.generate(state.length, (outerIndex) {
            return GestureDetector(
              onTap: () {
                //TODO
                showModalBottomSheet(
                  useSafeArea: true,
                  isScrollControlled: true,
                  context: context,
                  builder: (ctx) {
                    return ExerciseView(
                      selectedDateExecs: state,
                      outerIndex: outerIndex,

                    );
                  },
                );
              },
              child: Container(
                height: 60,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: const BorderSide(color: AppColors.secondary),
                    top: outerIndex == 0 && isDrawTopDivider ? const BorderSide(color: AppColors.secondary) : BorderSide.none,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 8, left: 16, right: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(state[outerIndex].words.length + state[outerIndex].words.length - 1,
                        (innerIndex) {
                      if (innerIndex % 2 != 0) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Container(
                            width: 4,
                            height: 4,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.orange,
                            ),
                          ),
                        );
                      } else {
                        return Expanded(
                          child: Text(
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            state[outerIndex].words[innerIndex ~/ 2],
                            style: AppStyles.bodyMedium,
                          ),
                        );
                      }
                    }),
                  ),
                ),
              ),
            );
          }),
        );
      },
    );
  }
}

class ExerciseView extends StatelessWidget {
  const ExerciseView({
    super.key,
    required this.selectedDateExecs,
    required this.outerIndex, this.isTop = false,
  });
  final bool isTop;
  final List<Exercise> selectedDateExecs;
  final int outerIndex;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: AppColors.secondary))),
          padding: const EdgeInsets.symmetric(vertical: 7),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width / 4.5,
                height: 6,
                decoration: BoxDecoration(
                  color: AppColors.gray,
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ],
          ),
        ),
        Container(
          height: 60,
          decoration: BoxDecoration(
            border: Border(
              bottom: const BorderSide(color: AppColors.secondary),
              top: isTop ? const BorderSide(color: AppColors.secondary) : BorderSide.none,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 8.0, bottom: 8, left: 16, right: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(
                  selectedDateExecs[outerIndex].words.length + selectedDateExecs[outerIndex].words.length - 1,
                  (innerIndex) {
                if (innerIndex % 2 != 0) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Container(
                      width: 4,
                      height: 4,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.orange,
                      ),
                    ),
                  );
                } else {
                  return Expanded(
                    child: Text(
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      selectedDateExecs[outerIndex].words[innerIndex ~/ 2],
                      style: AppStyles.bodyMedium,
                    ),
                  );
                }
              }),
            ),
          ),
        ),
        Flexible(
          child: SingleChildScrollView(
            child: Column(
              children: List.generate(selectedDateExecs[outerIndex].answers.length, (index) {
                return Container(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: AppColors.secondary),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8.0, bottom: 8, left: 16, right: 16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                questions[index],
                                style: AppStyles.labelMedium,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                selectedDateExecs[outerIndex].answers[index],
                                style: AppStyles.bodyMedium,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).padding.bottom,
        ),
      ],
    );
  }
}

class CheckInsView extends StatelessWidget {
  const CheckInsView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocSelector<EmotionsBloc, EmotionsState, List<CheckIn>>(
      selector: (EmotionsState state) {
        return state.checkIns;
      },
      builder: (context, state) {
        return Column(
          children: List.generate(state.length, (index) {
            final String assetPath;
            final String name;
            final Color powerColor = switch (state[index].feeling) {
              FeelingType.Positive => AppColors.orange,
              FeelingType.Neutral => AppColors.gray,
              FeelingType.Negative => AppColors.blue,
              FeelingType.NotSelected => AppColors.orange,
            };
            if (state[index].isCustom) {
              assetPath = AppIcons.customEmotions[state[index].index];
              name = state[index].name;
            } else {
              assetPath = AppIcons.triggerEmotionsIcons[state[index].index];
              name = Emotions.values[state[index].index].name;
            }
            return Container(
              decoration: BoxDecoration(
                border: Border(
                  top: const BorderSide(color: AppColors.secondary),
                  bottom: BorderSide(color: index == state.length - 1 ? AppColors.secondary : Colors.transparent),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 8, left: 16, right: 16),
                child: Row(
                  children: [
                    SizedBox(
                      height: 50,
                      width: 50,
                      child: SvgPicture.asset(
                        assetPath,
                      ),
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  name,
                                  maxLines: 1,
                                  style: AppStyles.bodyMedium,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  'Triggerd by: ${state[index].triggerBy}',
                                  maxLines: 1,
                                  style: AppStyles.labelMedium,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    Container(
                      height: 50,
                      width: 50,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(shape: BoxShape.circle, color: powerColor),
                      child: Center(
                        child: FittedBox(
                          child: Text(
                            '${state[index].feelingPower}/5',
                            style: AppStyles.displaySmall.copyWith(color: AppColors.white),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        );
      },
    );
  }
}

class CalendarView extends StatelessWidget {
  const CalendarView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocSelector<EmotionsBloc, EmotionsState, DateTime>(
      selector: (EmotionsState state) {
        return state.date;
      },
      builder: (BuildContext context, DateTime state) {
        final nextMonth = DateTime(
          state.year,
          state.month + 1,
        );
        final firstDayWeekDay = DateTime(
          state.year,
          state.month,
        ).weekday;
        final daysCount = nextMonth.subtract(const Duration(days: 1)).day;
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const DateRow(),
              const SizedBox(height: 32),
              Column(
                children: List.generate(11, (outerIndex) {
                  if (outerIndex % 2 != 0) {
                    return const SizedBox(
                      height: 8,
                    );
                  }
                  return Row(
                    children: List.generate(13, (innerIndex) {
                      final firstDayOfMonth = DateTime(
                        state.year,
                        state.month,
                      ); // Первый день месяца
                      final firstDayWeekday = firstDayOfMonth.weekday;
                      if (innerIndex % 2 != 0) {
                        return const SizedBox(
                          width: 8,
                        );
                      }
                      if (outerIndex ~/ 2 == 0 && innerIndex ~/ 2 < firstDayWeekDay - 1) {
                        return SizedBox(
                          width: (MediaQuery.of(context).size.width - 40 - 32 - 48) / 7,
                        );
                      }

                      final dayNumber = (outerIndex ~/ 2 * 7) + (innerIndex ~/ 2 - (firstDayWeekDay - 1)) + 1;

                      if (dayNumber > daysCount) {
                        return const SizedBox.shrink();
                      }
                      final dayOfWeek = (firstDayWeekday + dayNumber - 1) % 7;
                      return CalendarTile(
                        onTap: () {
                          final newDate = DateUtils.dateOnly(DateTime(state.year, state.month, dayNumber));
                          context.read<EmotionsBloc>().updateDate(newDate);
                        },
                        isToday: dayNumber == DateUtils.dateOnly(DateTime.now()).day &&
                            state.month == DateUtils.dateOnly(DateTime.now()).month &&
                            state.year == DateUtils.dateOnly(DateTime.now()).year,
                        isSelected: state.day == dayNumber,
                        dayNumber: dayNumber,
                        backgroundColor: dayOfWeek == 6 || dayOfWeek == 0 ? AppColors.redLight : AppColors.surface,
                      );
                    }),
                  );
                }),
              ),
            ],
          ),
        );
      },
    );
  }
}

class CalendarTile extends StatelessWidget {
  const CalendarTile({
    super.key,
    required this.dayNumber,
    this.onTap,
    this.isToday = false,
    this.isSelected = false,
    this.backgroundColor = AppColors.surface,
  });

  final int dayNumber;
  final void Function()? onTap;
  final bool isToday;
  final bool isSelected;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        width: (MediaQuery.of(context).size.width - 40 - 32 - 48) / 7,
        height: (MediaQuery.of(context).size.width - 40 - 32 - 48) / 7,
        decoration: BoxDecoration(
          border: Border.all(color: isToday ? AppColors.primary : Colors.transparent, width: 2),
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 4),
              blurRadius: 16,
              color: AppColors.black.withOpacity(0.1),
            ),
          ],
          shape: BoxShape.circle,
          color: isSelected ? AppColors.primary : backgroundColor,
        ),
        duration: AppConstants.duration200,
        child: Center(
          child: FittedBox(
            child: Text(
              '$dayNumber',
              style: isSelected ? AppStyles.bodyMedium.copyWith(color: AppColors.white) : AppStyles.bodyMedium,
            ),
          ),
        ),
      ),
    );
  }
}

class DateRow extends StatefulWidget {
  const DateRow({
    super.key,
  });

  @override
  State<DateRow> createState() => _DateRowState();
}

class _DateRowState extends State<DateRow> {
  @override
  Widget build(BuildContext context) {
    return BlocSelector<EmotionsBloc, EmotionsState, DateTime>(
      selector: (EmotionsState state) {
        return state.date;
      },
      builder: (BuildContext context, DateTime state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    final newDate = DateTime(state.year, state.month - 1, state.day);
                    context.read<EmotionsBloc>().updateDate(newDate);
                  },
                  child: Container(
                    color: Colors.transparent,
                    width: 24,
                    height: 24,
                    child: const Icon(CupertinoIcons.chevron_back),
                  ),
                ),
                const SizedBox(
                  width: 4,
                ),
                FittedBox(
                  child: Text(
                    textAlign: TextAlign.center,
                    DateFormat('MMMM').format(state),
                    style: AppStyles.displaySmall,
                  ),
                ),
                const SizedBox(
                  width: 4,
                ),
                GestureDetector(
                  onTap: () {
                    final newDate = DateTime(state.year, state.month + 1, state.day);
                    context.read<EmotionsBloc>().updateDate(newDate);
                  },
                  child: Container(
                    color: Colors.transparent,
                    width: 24,
                    height: 24,
                    child: const Icon(CupertinoIcons.chevron_forward),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    final newDate = DateTime(state.year - 1, state.month, state.day);
                    context.read<EmotionsBloc>().updateDate(newDate);
                  },
                  child: Container(
                    color: Colors.transparent,
                    width: 24,
                    height: 24,
                    child: const Icon(CupertinoIcons.chevron_back),
                  ),
                ),
                const SizedBox(
                  width: 4,
                ),
                Text(
                  textAlign: TextAlign.center,
                  DateFormat('yyyy').format(state),
                  style: AppStyles.displaySmall,
                ),
                const SizedBox(
                  width: 4,
                ),
                GestureDetector(
                  onTap: () {
                    final newDate = DateTime(state.year + 1, state.month, state.day);
                    context.read<EmotionsBloc>().updateDate(newDate);
                  },
                  child: Container(
                    color: Colors.transparent,
                    width: 24,
                    height: 24,
                    child: const Icon(CupertinoIcons.chevron_forward),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}

class StatsBar extends StatelessWidget {
  const StatsBar({
    super.key,
    required this.title,
    required this.items,
  });

  final List<CheckIn> items;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              title,
              style: AppStyles.bodyMedium,
            ),
          ],
        ),
        const SizedBox(
          height: 16,
        ),
        Bar(
          items: items,
        ),
      ],
    );
  }
}
