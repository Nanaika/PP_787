import 'package:PP_787/bloc/emotions_bloc.dart';
import 'package:PP_787/bloc/emotions_state.dart';
import 'package:PP_787/navigation/routes.dart';
import 'package:PP_787/pages/settings_page.dart';
import 'package:PP_787/storages/models/anchor.dart';
import 'package:PP_787/ui_kit/colors.dart';
import 'package:PP_787/ui_kit/text_styles.dart';
import 'package:PP_787/ui_kit/widgets/app_elevated_button.dart';
import 'package:PP_787/utils/assets_paths.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class AnchorPage extends StatelessWidget {
  const AnchorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 14 + MediaQuery.of(context).padding.top, left: 16, right: 16),
            child: TopBar(
              title: 'Positivity anchors',
              backPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
          SizedBox(
            height: 32,
          ),
          BlocSelector<EmotionsBloc, EmotionsState, List<Anchor>>(
            selector: (state) {
              return state.anchors;
            },
            builder: (context, state) {
              if (state.isEmpty) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: EmptyAnchorsView(),
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
                              return Container(
                                height: 60,
                                padding: EdgeInsets.symmetric(horizontal: 32),
                                decoration: BoxDecoration(
                                  border: Border(
                                    top: BorderSide(color: index == 0 ? AppColors.secondary : Colors.transparent),
                                    bottom: BorderSide(
                                        color: index == state.length - 1 ? AppColors.secondary : Colors.transparent),
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    SvgPicture.asset(
                                      AppIcons.star,
                                      width: 20,
                                      height: 20,
                                    ),
                                    SizedBox(
                                      width: 16,
                                    ),
                                    Text(
                                      state[index].name,
                                      style: AppStyles.bodyMedium,
                                    ),
                                  ],
                                ),
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
                            buttonText: 'Add anchor',
                            onTap: () {
                              Navigator.of(context).pushNamed(AppRoutes.addAnchor);
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

class EmptyAnchorsView extends StatelessWidget {
  const EmptyAnchorsView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                Positioned.fill(
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(32),
                        child: Image.asset(
                          AppImages.anchor1,
                          fit: BoxFit.cover,
                        ))),
                FittedBox(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16, top: 43),
                    child: Text(
                      'Write down things\nthat make you\nfeel good',
                      style: AppStyles.displayLarge,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 32,
          ),
          AppElevatedButton(
              buttonText: 'Add anchor',
              onTap: () {
                Navigator.of(context).pushNamed(AppRoutes.addAnchor);
              }),
          SizedBox(
            height: MediaQuery.of(context).padding.bottom,
          ),
        ],
      ),
    );
  }
}
