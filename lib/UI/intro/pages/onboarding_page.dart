import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:manda_bai/Core/app_images.dart';
import 'package:manda_bai/UI/intro/widget/template_onboarding.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TemplateOnboarding(
      image: AppImages.onboarding1,
      description: 'Djuda bu familia di dento pa fora.',
      title: AppLocalizations.of(context)!.family,
      actionButton: () {
        Navigator.pushNamed(context, '/onboarding2');
      },
      actionButtonTop: () {
        Navigator.pushReplacementNamed(context, '/onboarding3');
      },
      buttonTopLabel: AppLocalizations.of(context)!.textbutton_skip,
      position: 1,
      music:
          '“Ês dez graozinho di terra Qui Deus espaiá na meio di mar" @Cesária Évora',
      musicImage: AppImages.music1,
    );
  }
}
