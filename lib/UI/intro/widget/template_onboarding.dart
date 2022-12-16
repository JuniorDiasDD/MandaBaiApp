import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manda_bai/UI/intro/widget/circle.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:manda_bai/UI/widget/button_ui.dart';

import 'circle_button.dart';

class TemplateOnboarding extends StatelessWidget {
  final String buttonTopLabel;
  final String title;
  final String description;
  final String? music;
  final String? musicImage;
  final String image;
  final VoidCallback actionButtonTop;
  final VoidCallback actionButton;
  final int position;
  final bool finalCheck;
  const TemplateOnboarding(
      {Key? key,
      required,
      required this.buttonTopLabel,
      required this.title,
      required this.description,
      required this.image,
      required this.actionButton,
      required this.actionButtonTop,
      required this.position,
      this.finalCheck = false,
      this.musicImage,
      this.music})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                children: [
                  const Spacer(),
                  TextButton(
                    onPressed: actionButtonTop,
                    child: Text(
                      buttonTopLabel,
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Image.asset(image),
              Text(
                title,
                style:
                    Theme.of(context).textTheme.headline5!.copyWith(fontSize: 24),
              ),
              Text(
                description,
                style: Theme.of(context).textTheme.headline4,
              ),
              const SizedBox(height: 32,),
              Row(
                children: [
                  if (position == 1) Image.asset(musicImage!),
                  if (position == 2) Image.asset(musicImage!),
                  const SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    child: position!=3? Text(
                      music!,
                      style: Theme.of(context).textTheme.labelSmall,
                    ):Container(),
                  ),
                ],
              ),
              const SizedBox(
                height: 16.0,
              ),
              const Spacer(),
              Row(
                children: [
                  const Spacer(),
                  SizedBox(
                    child: position == 1
                        ? CircleIcon(
                            icon: Icons.arrow_forward,
                            action: actionButton,
                          )
                        : position == 2
                            ? Row(
                                children: [
                                  CircleIcon(
                                      icon: Icons.arrow_back, action: () {Navigator.pop(context);}),
                                  CircleIcon(
                                      icon: Icons.arrow_forward, action: actionButton),
                                ],
                              )
                            : Container(),
                  ),
                ],
              ),
              if(position==3)
                ButtonUI(label:   AppLocalizations.of(context)!
                    .star_button,action:actionButton ),

              Padding(
                padding:  EdgeInsets.all(Get.height*0.03),
                child: Row(
                  children: [
                    const Spacer(),
                    SizedBox(
                      child: position == 1
                          ? Row(
                              children: const [
                                Circle(
                                  active: true,
                                ),
                                Circle(),
                                Circle(),
                              ],
                            )
                          : position == 2
                              ? Row(
                                  children: const [
                                    Circle(),
                                    Circle(
                                      active: true,
                                    ),
                                    Circle(),
                                  ],
                                )
                              : Container(),
                    ),
                    const Spacer(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
