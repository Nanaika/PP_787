import 'package:PP_787/bloc/emotions_bloc.dart';
import 'package:PP_787/bloc/emotions_state.dart';
import 'package:PP_787/navigation/routes.dart';
import 'package:PP_787/pages/settings_page.dart';
import 'package:PP_787/storages/models/trigger.dart';
import 'package:PP_787/ui_kit/colors.dart';
import 'package:PP_787/ui_kit/text_styles.dart';
import 'package:PP_787/ui_kit/widgets/app_elevated_button.dart';
import 'package:PP_787/utils/assets_paths.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class TriggerPage extends StatelessWidget {
  const TriggerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 14 + MediaQuery.of(context).padding.top, left: 16, right: 16),
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
          BlocSelector<EmotionsBloc, EmotionsState, List<Trigger>>(
            selector: (state) {
              return state.triggers;
            },
            builder: (context, state) {
              if (state.isEmpty) {
                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
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
                            itemCount: state.length),
                      ),
                      SizedBox(
                        height: 32,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: AppElevatedButton(
                            buttonText: 'Add new trigger',
                            onTap: () {
                              Navigator.of(context).pushNamed(AppRoutes.addTrigger);
                            }),
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
        padding: EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(color: index == 0 ? AppColors.secondary : Colors.transparent),
            bottom: BorderSide(color: index == state.length - 1 ? AppColors.secondary : Colors.transparent),
          ),
        ),
        child: Row(
          children: [
            SizedBox(
              width: 32,
            ),
            ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: (MediaQuery.of(context).size.width - 32) / 2
              ),
              child: Text(
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                state[index].name,
                style: AppStyles.bodyMedium,
              ),
            ),
            SizedBox(
              width: 8,
            ),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: List.generate(state[index].emotions.length, (innerIndex) {
                    return Container(
                      width: 60,
                      height: 60,
                      padding: EdgeInsets.all(10),
                      child: SvgPicture.asset(
                        AppIcons.triggerEmotionsIcons[state[index].emotions[innerIndex].type.index],
                      ),
                    );
                  }),
                ),
              ),
            )
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FittedBox(
          child: Text(
            'No triggers yet',
            style: AppStyles.displayLarge,
          ),
        ),
        SizedBox(
          height: 32,
        ),
        Expanded(
          child: ClipRRect(
              borderRadius: BorderRadius.circular(32),
              child: Image.asset(
                AppImages.trigger1,
                fit: BoxFit.cover,
              )),
        ),
        SizedBox(
          height: 32,
        ),
        AppElevatedButton(
            buttonText: 'Next',
            onTap: () {
              Navigator.of(context).pushNamed(AppRoutes.addTrigger);
            }),
        SizedBox(
          height: MediaQuery.of(context).padding.bottom,
        ),
      ],
    );
  }
}
