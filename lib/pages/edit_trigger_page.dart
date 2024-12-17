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
import 'package:flutter_svg/flutter_svg.dart';

class EditTriggerPage extends StatelessWidget {
  const EditTriggerPage({super.key});

  @override
  Widget build(BuildContext context) {
    final index = ModalRoute
        .of(context)
        ?.settings
        .arguments as int;
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 14 + MediaQuery
                .of(context)
                .padding
                .top, left: 16, right: 16),
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
            builder: (BuildContext context, state) {
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
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                state[index].name,
                                style: AppStyles.displayLarge,
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 32,
                        ),
                        Flexible(
                          child: SingleChildScrollView(
                            child: Column(
                              children: List.generate(state[index].emotions.length + state[index].emotions.length - 1, (rowIndex) {
                                if(rowIndex % 2 != 0) {
                                  return SizedBox(height: 32,);
                                }
                                return Row(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(10),
                                      child: SvgPicture.asset(
                                        AppIcons.triggerEmotionsIcons[state[index].emotions[rowIndex ~/ 2].type.index],
                                      ),
                                      width: 65,
                                      height: 65,
                                    ),
                                    SizedBox(width: 16,),
                                    Expanded(child: Container(
                                      height: 35,
                                      decoration: BoxDecoration(
                                        color: AppColors.primary,
                                        borderRadius: BorderRadius.circular(32.0),
                                      ),
                                    ),),
                                    SizedBox(width: 16,),
                                    Text(state[index].emotions[rowIndex ~/ 2].count.toString(), style: AppStyles.displayLarge,),
                                  ],
                                );
                              }),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 32,
                        ),
                        AppElevatedButton(
                          textColor: AppColors.black,
                          backgroundColor: AppColors.secondary,
                            buttonText: 'New emotion in the trigger',
                            onTap: () {
                              Navigator.of(context).pushNamed(AppRoutes.addEmotion, arguments: state[index]);
                            }),
                        SizedBox(
                          height: 16,
                        ),
                        AppElevatedButton(
                          backgroundColor: AppColors.destructive,
                          textColor: AppColors.white,
                            buttonText: 'Delete trigger',
                            onTap: () async {
                              await context.read<EmotionsBloc>().deleteTrigger(state[index].id);
                              if(context.mounted) {
                                Navigator.of(context).pop();
                              }
                            }),
                        SizedBox(
                          height: 10 + MediaQuery.of(context).padding.bottom,
                        ),
                      ],

                    ),
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FittedBox(
          child: Text(
            'No records in this\ntrigger yet',
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
                AppImages.trigger3,
                fit: BoxFit.cover,
              )),
        ),
        SizedBox(
          height: 32,
        ),
        AppElevatedButton(
            buttonText: 'New emotion in the trigger',
            onTap: () {
              Navigator.of(context).pushNamed(AppRoutes.addEmotion, arguments: trigger);
            }),
        SizedBox(
          height: MediaQuery
              .of(context)
              .padding
              .bottom,
        ),
      ],
    );
  }
}
