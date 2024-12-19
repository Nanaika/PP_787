import 'package:PP_787/bloc/anchor_bloc.dart';
import 'package:PP_787/bloc/emotions_bloc.dart';
import 'package:PP_787/storages/models/anchor.dart';
import 'package:PP_787/ui_kit/text_styles.dart';
import 'package:PP_787/ui_kit/widgets/app_elevated_button.dart';
import 'package:PP_787/ui_kit/widgets/app_text_form_field.dart';
import 'package:PP_787/ui_kit/widgets/custom_app_bar.dart';
import 'package:PP_787/utils/assets_paths.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddAnchorPage extends StatelessWidget {
  const AddAnchorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AnchorBloc(),
      child: Builder(
        builder: (context) {
          return Scaffold(
            appBar: AppBar(
              scrolledUnderElevation: 0,
              title: const CustomAppBar(title: 'Positivity anchors'),
              automaticallyImplyLeading: false,
            ),
            body: GestureDetector(
              onTap: () {
                FocusManager.instance.primaryFocus?.unfocus();
              },
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      Expanded(
                        child: Stack(
                          children: [
                            SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    height: 32,
                                  ),
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(32),
                                    child: Image.asset(
                                      width: double.infinity,
                                      AppImages.anchor2,
                                      fit: BoxFit.fitWidth,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 32,
                                  ),
                                  const Text(
                                    textAlign: TextAlign.start,
                                    'Positivity anchor',
                                    style: AppStyles.labelMedium,
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width / 2,
                                    child: AppTextFormField(
                                      hint: 'A friend group brunch',
                                      onChanged: (text) {
                                        context.read<AnchorBloc>().updateName(text);
                                      },
                                      formatters: [LengthLimitingTextInputFormatter(50)],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 32 + 54 + MediaQuery.of(context).padding.bottom,
                                  ),
                                ],
                              ),
                            ),
                            Positioned(
                              bottom: 0  - MediaQuery.of(context).viewInsets.bottom + MediaQuery.of(context).padding.bottom,
                              left: 0,
                              right: 0,
                              child: BlocBuilder<AnchorBloc, Anchor>(
                                builder: (context, state) {
                                  return AppElevatedButton(
                                    buttonText: 'Save anchor',
                                    onTap: () async {
                                      await context.read<EmotionsBloc>().addAnchor(state);
                                      if (context.mounted) {
                                        Navigator.of(context).pop();
                                      }
                                    },
                                    isActive: context.read<AnchorBloc>().canSave(),
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
            ),
          );
        },
      ),
    );
  }
}
