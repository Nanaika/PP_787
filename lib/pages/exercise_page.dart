import 'package:PP_787/bloc/emotions_bloc.dart';
import 'package:PP_787/bloc/exercise_bloc.dart';
import 'package:PP_787/navigation/routes.dart';
import 'package:PP_787/storages/models/exercise.dart';
import 'package:PP_787/ui_kit/colors.dart';
import 'package:PP_787/ui_kit/text_styles.dart';
import 'package:PP_787/ui_kit/widgets/app_elevated_button.dart';
import 'package:PP_787/ui_kit/widgets/app_text_form_field.dart';
import 'package:PP_787/ui_kit/widgets/custom_app_bar.dart';
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
  'When did you feel the same thing?',
  'How would you describe this to another person',
  'How does this emotion influence your actions',
  'Where do you feel this emotion in your body',
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
      child: Builder(
        builder: (context) {
          return GestureDetector(
            onTap: () {
              FocusManager.instance.primaryFocus?.unfocus();
            },
            child: Scaffold(
              appBar: AppBar(
                automaticallyImplyLeading: false,
                title: const CustomAppBar(title: 'Reflection exercise'),
              ),
              body: SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Column(
                  children: [
                    Expanded(
                      child: Stack(
                        children: [
                          PageView(
                            controller: _controller,
                            physics: const NeverScrollableScrollPhysics(),
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
                                      showTextField: index != questions.length - 1,
                                      question: questions[index],
                                      onChanged: (text) {
                                        context.read<ExerciseBloc>().updateAnswer(text, index);
                                      },
                                      imagePath: questionsImages[index],
                                      isActive: false,
                                      onTap: () {},
                                    );
                                  },
                                );
                              }),
                            ],
                          ),
                          if (_currentPage > 0)
                            Positioned(
                              bottom:
                                  0 - MediaQuery.of(context).viewInsets.bottom + MediaQuery.of(context).padding.bottom,
                              left: 0,
                              right: 0,
                              child: BlocBuilder<ExerciseBloc, Exercise>(
                                builder: (BuildContext context, Exercise state) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 16),
                                    child: Row(
                                      children: [
                                        if (_currentPage > 1)
                                          GestureDetector(
                                            onTap: () {
                                              FocusManager.instance.primaryFocus?.unfocus();
                                              _prevPage();
                                            },
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
                                                      offset: const Offset(0, 4),
                                                      blurRadius: 16,
                                                      color: AppColors.black.withOpacity(0.1),
                                                    ),
                                                  ],
                                                ),
                                                child: const Icon(
                                                  CupertinoIcons.chevron_back,
                                                  size: 24,
                                                ),
                                              ),
                                            ),
                                          ),
                                        AnimatedContainer(
                                          duration: AppConstants.duration200,
                                          child: Expanded(
                                            child: AppElevatedButton(
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
                                              isActive: _currentPage - 1 == questions.length - 1
                                                  ? true
                                                  : context.read<ExerciseBloc>().canAnswerNext(_currentPage - 1),
                                              buttonText: _currentPage == 5 ? 'Submit' : 'Next',
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                        ],
                      ),
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
          const SizedBox(
            height: 32,
          ),
          const Row(
            children: [
              Expanded(
                child: Text(
                  'Describe what you feel in three words',
                  style: AppStyles.displayLarge,
                ),
              ),
            ],
          ),
          const SizedBox(
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
                    return const SizedBox(
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
          const SizedBox(
            height: 32,
          ),
          Column(
            children: List.generate(5, (index) {
              if (index % 2 != 0) {
                return const SizedBox(
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
          const SizedBox(
            height: 32,
          ),
          BlocBuilder<ExerciseBloc, Exercise>(
            builder: (BuildContext context, Exercise state) {
              return Padding(
                padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
                child: AppElevatedButton(
                  buttonText: 'Next',
                  onTap: onTap,
                  isActive: context.read<ExerciseBloc>().canWordsNext(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class QuestionView extends StatefulWidget {
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
  State<QuestionView> createState() => _QuestionViewState();
}

class _QuestionViewState extends State<QuestionView> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 32,
            ),
            Text(
              textAlign: TextAlign.left,
              widget.question,
              style: AppStyles.displayLarge,
            ),
            const SizedBox(
              height: 32,
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(32),
              child: Image.asset(
                width: double.infinity,
                widget.imagePath,
                fit: BoxFit.fitWidth,
              ),
            ),
            const SizedBox(
              height: 32,
            ),
            if (widget.showTextField)
              BlocSelector<ExerciseBloc, Exercise, List<String>>(
                selector: (state) { return state.answers; },
                builder: (BuildContext context, state) { return Padding(
                  padding: EdgeInsets.only(bottom: 54 + 32 + MediaQuery.of(context).padding.bottom),
                  child: AppTextFormField(
                    hint: 'Describe the situation',
                    onChanged: widget.onChanged,
                    formatters: [LengthLimitingTextInputFormatter(50)],
                  ),
                ); },
              ),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
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
