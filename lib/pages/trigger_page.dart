import 'package:PP_787/bloc/emotions_bloc.dart';
import 'package:PP_787/bloc/emotions_state.dart';
import 'package:PP_787/navigation/routes.dart';
import 'package:PP_787/storages/models/trigger.dart';
import 'package:PP_787/ui_kit/colors.dart';
import 'package:PP_787/ui_kit/text_styles.dart';
import 'package:PP_787/ui_kit/widgets/app_elevated_button.dart';
import 'package:PP_787/ui_kit/widgets/custom_app_bar.dart';
import 'package:PP_787/utils/assets_paths.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class TriggerPage extends StatelessWidget {
  const TriggerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const CustomAppBar(title: 'Emotional trigger map'),
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          BlocSelector<EmotionsBloc, EmotionsState, List<Trigger>>(
            selector: (state) {
              return state.triggers;
            },
            builder: (context, state) {
              if (state.isEmpty) {
                return const Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: EmptyTriggersView(),
                  ),
                );
              } else {
                return Expanded(
                  child: Column(
                    children: [
                      Flexible(
                        child: ListView.separated(
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          itemBuilder: (ctx, index) {
                            return TriggerTile(
                              index: index,
                              state: state,
                              onTap: () {
                                Navigator.of(context).pushNamed(AppRoutes.editTrigger, arguments: index);
                              },
                            );
                          },
                          separatorBuilder: (ctx, index) {
                            return Container(
                              height: 1,
                              color: AppColors.secondary,
                            );
                          },
                          itemCount: state.length,
                        ),
                      ),
                      const SizedBox(
                        height: 32,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: AppElevatedButton(
                          buttonText: 'Add new trigger',
                          onTap: () {
                            Navigator.of(context).pushNamed(AppRoutes.addTrigger);
                          },
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).padding.bottom,
                      ),
                    ],
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}

class TriggerTile extends StatelessWidget {
  const TriggerTile({
    super.key,
    required this.index,
    required this.state,
    this.onTap,
  });

  final List<Trigger> state;
  final int index;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 72,
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(color: index == 0 ? AppColors.secondary : Colors.transparent),
            bottom: BorderSide(color: index == state.length - 1 ? AppColors.secondary : Colors.transparent),
          ),
        ),
        child: Row(
          children: [
            const SizedBox(
              width: 32,
            ),
            ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: (MediaQuery.of(context).size.width - 32) / 2,
              ),
              child: Text(
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                state[index].name,
                style: AppStyles.bodyMedium,
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(state[index].emotions.length, (innerIndex) {
                    return Container(
                      width: 60,
                      height: 60,
                      padding: const EdgeInsets.all(10),
                      child: SvgPicture.asset(
                        AppIcons.triggerEmotionsIcons[state[index].emotions[innerIndex].type.index],
                      ),
                    );
                  }),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class EmptyTriggersView extends StatelessWidget {
  const EmptyTriggersView({
    super.key,
  });

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
                'No triggers yet',
                style: AppStyles.displayLarge,
              ),
              const SizedBox(
                height: 32,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(32),
                child: Image.asset(
                  width: double.infinity,
                  AppImages.trigger1,
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
          bottom: 0,
          left: 0,
          right: 0,
          child: Padding(
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
            child: AppElevatedButton(
              buttonText: 'Next',
              onTap: () {
                Navigator.of(context).pushNamed(AppRoutes.addTrigger);
              },
            ),
          ),
        ),
      ],
    );
  }
}
