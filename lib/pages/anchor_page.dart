import 'package:PP_787/bloc/emotions_bloc.dart';
import 'package:PP_787/bloc/emotions_state.dart';
import 'package:PP_787/navigation/routes.dart';
import 'package:PP_787/storages/models/anchor.dart';
import 'package:PP_787/ui_kit/colors.dart';
import 'package:PP_787/ui_kit/text_styles.dart';
import 'package:PP_787/ui_kit/widgets/app_elevated_button.dart';
import 'package:PP_787/ui_kit/widgets/custom_app_bar.dart';
import 'package:PP_787/utils/assets_paths.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class AnchorPage extends StatelessWidget {
  const AnchorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: AppColors.background,
        automaticallyImplyLeading: false,
        title: const CustomAppBar(title: 'Positivity anchors',),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [


            BlocSelector<EmotionsBloc, EmotionsState, List<Anchor>>(
              selector: (state) {
                return state.anchors;
              },
              builder: (context, state) {
                if (state.isEmpty) {
                  return const Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: EmptyAnchorsView(),
                    ),
                  );
                } else {
                  return Expanded(
                    child: Stack(
                      children: [
                        ListView.separated(
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          itemBuilder: (ctx, index) {
                            if(index == state.length) {
                              return SizedBox(
                                height: 32 + 54 + MediaQuery.of(context).padding.bottom,
                              );
                            }
                            return Container(
                              height: 60,
                              padding: const EdgeInsets.symmetric(horizontal: 32),
                              decoration: BoxDecoration(
                                border: Border(
                                  top: BorderSide(color: index == 0 ? AppColors.secondary : Colors.transparent),
                                  bottom: BorderSide(
                                    color: index == state.length ? AppColors.secondary : Colors.transparent,
                                  ),
                                ),
                              ),
                              child: Row(
                                children: [
                                  SvgPicture.asset(
                                    AppIcons.star,
                                    width: 20,
                                    height: 20,
                                  ),
                                  const SizedBox(
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
                          itemCount: state.length + 1,
                        ),
                        const SizedBox(
                          height: 32,
                        ),
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,

                          child: Padding(
                            padding: EdgeInsets.only(left: 16, right: 16, bottom: MediaQuery.of(context).padding.bottom),
                            child: AppElevatedButton(
                              buttonText: 'Add anchor',
                              onTap: () {
                                Navigator.of(context).pushNamed(AppRoutes.addAnchor);
                              },
                            ),
                          ),
                        ),

                      ],
                    ),
                  );
                }
              },
            ),
          ],
        ),
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
    return Stack(
      children: [
        SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 32,),
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(32),
                    child: Image.asset(
                      width: double.infinity,
                      AppImages.anchor1,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 16, right: 16, top: 43),
                    child: Text(
                      'Write down things that make you feel good',
                      style: AppStyles.displayLarge,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Column(
            children: [
              AppElevatedButton(
                buttonText: 'Add anchor',
                onTap: () {
                  Navigator.of(context).pushNamed(AppRoutes.addAnchor);
                },
              ),
              SizedBox(
                height: MediaQuery.of(context).padding.bottom,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
