import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:manda_bai/Core/app_images.dart';
import 'package:manda_bai/UI/intro/widget/template_onboarding.dart';


class OnboardingTwoPage extends StatelessWidget {
  const OnboardingTwoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TemplateOnboarding(
      image: AppImages.onboarding2,
      description: 'Di tudu um poku',
      title:AppLocalizations.of(context)!
          .product,
      actionButton: (){
        Navigator.pushNamed(context, '/onboarding3');
      },
      actionButtonTop: (){
        Navigator.pushReplacementNamed(context, '/onboarding3');
      },
      buttonTopLabel: AppLocalizations.of(context)!.textbutton_skip,
      position: 2,
      music: '““Terra fértil Das bananeiras, das laranajeiras, Do milho que dá cachupa, o cuscuz...."@Poétas de Terra',
      musicImage: AppImages.music2,

    );
  }
}
