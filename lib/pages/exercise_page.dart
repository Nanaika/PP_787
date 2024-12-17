import 'package:PP_787/bloc/emotions_bloc.dart';
import 'package:PP_787/bloc/exercise_bloc.dart';
import 'package:PP_787/navigation/routes.dart';
import 'package:PP_787/storages/models/exercise.dart';
import 'package:PP_787/ui_kit/colors.dart';
import 'package:PP_787/ui_kit/text_styles.dart';
import 'package:PP_787/ui_kit/widgets/app_elevated_button.dart';
import 'package:PP_787/ui_kit/widgets/app_text_form_field.dart';
import 'package:PP_787/utils/assets_paths.dart';
import 'package:PP_787/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

const hints = ['First word', 'Second word', 'Third word'];
const colors = [
  AppColors.blue,
  AppColors.orange,
  AppColors.red,
];

const questions = [
  'When did you feel\nthe same thing?',
  'How would you\ndescribe this to\nanother person',
  'How does this\nemotion influence\nyour actions',
  'Where do you feel\nthis emotion in\nyour body',
  'Reflection complete',
];

const questionsImages = [
  AppImages.exec1,
  AppImages.exec2,
  AppImages.exec3,
  AppImages.exec4,
  AppImages.exec5,
];

class ExercisePage extends StatefulWidget {
  const ExercisePage({super.key});

  @override
  State<ExercisePage> createState() => _ExercisePageState();
}

class _ExercisePageState extends State<ExercisePage> {
  final _controller = PageController();
  int _currentPage = 0;

  Future<void> _nextPage() async {
    print('nextpage ------------------  ${_currentPage}');
    if (_currentPage == 5) {
    } else {
      setState(() => _currentPage++);
      await _controller.nextPage(
        duration: AppConstants.duration200,
        curve: Curves.easeInOut,
      );
    }
  }

  Future<void> _prevPage() async {
    if (_currentPage == 0) {
      // Navigator.of(context).pushReplacementNamed(AppRoutes.home);
    } else {
      setState(() => _currentPage--);
      await _controller.previousPage(
        duration: AppConstants.duration200,
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ExerciseBloc(),
      child: Builder(builder: (context) {
        return GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Scaffold(
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Padding(
                    padding: EdgeInsets.only(top: 14 + MediaQuery.of(context).padding.top),
                    child: TopBar(
                      title: 'Reflection exercise',
                      backPressed: () {
                        FocusManager.instance.primaryFocus?.unfocus();
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: 32,
                ),
                Expanded(
                  child: PageView(
                    controller: _controller,
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      SingleChildScrollView(
                        child: FirstView(
                          onTap: () {
                            FocusManager.instance.primaryFocus?.unfocus();
                            _nextPage();
                          },
                        ),
                      ),
                      ...List.generate(questions.length, (index) {
                        return BlocSelector<ExerciseBloc, Exercise, List<String>>(
                          selector: (Exercise state) {
                            return state.answers;
                          },
                          builder: (BuildContext context, List<String> state) {
                            return QuestionView(
                              showBackButton: index != 0,
                              showTextField: index != questions.length - 1,
                              question: questions[index],
                              onChanged: (text) {
                                context.read<ExerciseBloc>().updateAnswer(text, index);
                              },
                              onBackTap: () {
                                FocusManager.instance.primaryFocus?.unfocus();
                                _prevPage();
                              },
                              onTap: () {
                                if (_currentPage == 5) {
                                  FocusManager.instance.primaryFocus?.unfocus();
                                  final exercise = context.read<ExerciseBloc>().state;
                                  context.read<EmotionsBloc>().addExercise(exercise);
                                  Navigator.of(context).pushReplacementNamed(AppRoutes.home);
                                } else {
                                  FocusManager.instance.primaryFocus?.unfocus();
                                  _nextPage();
                                }
                              },
                              imagePath: questionsImages[index],
                              isActive: index == questions.length - 1
                                  ? true
                                  : context.read<ExerciseBloc>().canAnswerNext(index),
                              buttonText: index == 4 ? 'Submit' : 'Next',
                            );
                          },
                        );
                      })
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}

class FirstView extends StatelessWidget {
  const FirstView({
    super.key,
    required this.onTap,
  });

  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: FittedBox(
                  child: Text(
                    'Describe what you\nfeel in three words',
                    style: AppStyles.displayLarge,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 32,
          ),
          BlocSelector<ExerciseBloc, Exercise, List<String>>(
            selector: (Exercise state) {
              return state.words;
            },
            builder: (BuildContext context, List<String> state) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(5, (index) {
                  if (index % 2 != 0) {
                    return SizedBox(
                      width: 32,
                    );
                  }
                  return CustomCircle(
                    color: colors[index ~/ 2],
                    isActive: state[index ~/ 2].isNotEmpty,
                  );
                }),
              );
            },
          ),
          SizedBox(
            height: 32,
          ),
          Column(
            children: List.generate(5, (index) {
              if (index % 2 != 0) {
                return SizedBox(
                  height: 16,
                );
              }
              return AppTextFormField(
                hint: hints[index ~/ 2],
                onChanged: (text) {
                  context.read<ExerciseBloc>().updateWord(text, index ~/ 2);
                },
                formatters: [LengthLimitingTextInputFormatter(20)],
              );
            }),
          ),
          SizedBox(
            height: 32,
          ),
          BlocBuilder<ExerciseBloc, Exercise>(
            builder: (BuildContext context, Exercise state) {
              return AppElevatedButton(
                buttonText: 'Next',
                onTap: onTap,
                isActive: context.read<ExerciseBloc>().canWordsNext(),
              );
            },
          ),
          SizedBox(
            height: MediaQuery.of(context).padding.top,
          )
        ],
      ),
    );
  }
}

//TODO
class QuestionView extends StatelessWidget {
  const QuestionView({
    super.key,
    required this.onTap,
    required this.question,
    required this.imagePath,
    required this.isActive,
    this.buttonText = 'Next',
    this.isBackExist = true,
    this.onBackTap,
    this.showBackButton = true,
    this.showTextField = true,
    required this.onChanged,
  });

  final void Function() onTap;
  final String question;
  final String imagePath;
  final bool isActive;
  final String buttonText;
  final bool isBackExist;
  final void Function()? onBackTap;
  final bool showBackButton;
  final bool showTextField;
  final void Function(String) onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: FittedBox(
                  child: Text(
                    question,
                    style: AppStyles.displayLarge,
                  ),
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
                imagePath,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(
            height: 32,
          ),
          if (showTextField)
            Padding(
              padding: const EdgeInsets.only(bottom: 32),
              child: AppTextFormField(
                hint: 'Describe the situation',
                onChanged: onChanged,
                formatters: [LengthLimitingTextInputFormatter(50)],
              ),
            ),
          BlocBuilder<ExerciseBloc, Exercise>(
            builder: (BuildContext context, Exercise state) {
              return Row(
                children: [
                  if (showBackButton)
                    GestureDetector(
                      onTap: onBackTap,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 16.0),
                        child: Container(
                          height: 54,
                          width: 54,
                          decoration: BoxDecoration(
                            color: AppColors.secondary,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                offset: Offset(0, 4),
                                blurRadius: 16,
                                color: AppColors.black.withOpacity(0.1),
                              ),
                            ],
                          ),
                          child: Icon(
                            CupertinoIcons.chevron_back,
                            size: 24,
                          ),
                        ),
                      ),
                    ),
                  Expanded(
                    child: AppElevatedButton(
                      buttonText: buttonText,
                      onTap: onTap,
                      isActive: isActive,
                    ),
                  ),
                ],
              );
            },
          ),
          SizedBox(
            height: MediaQuery.of(context).padding.top,
          )
        ],
      ),
    );
  }
}

class CustomCircle extends StatefulWidget {
  const CustomCircle({
    super.key,
    required this.color,
    this.isActive = false,
  });

  final Color color;
  final bool isActive;

  @override
  State<CustomCircle> createState() => _CustomCircleState();
}

class _CustomCircleState extends State<CustomCircle> {
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      height: 45,
      width: 45,
      decoration: BoxDecoration(
        color: widget.isActive ? widget.color : Colors.transparent,
        shape: BoxShape.circle,
        border: Border.all(color: widget.color, width: widget.isActive ? 0 : 4),
      ),
      duration: AppConstants.duration200,
    );
  }
}

class TopBar extends StatelessWidget {
  const TopBar({
    super.key,
    required this.title,
    this.backPressed,
  });

  final String title;
  final void Function()? backPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: backPressed,
          child: Container(
            width: 24,
            height: 24,
            child: Icon(
              CupertinoIcons.chevron_back,
              size: 24,
            ),
          ),
        ),
        SizedBox(
          width: 6,
        ),
        Text(
          title,
          style: AppStyles.displaySmall,
        ),
        SizedBox(
          height: 16,
        ),
      ],
    );
  }
}
