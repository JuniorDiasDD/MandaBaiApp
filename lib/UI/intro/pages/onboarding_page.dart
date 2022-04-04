import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manda_bai/Core/app_colors.dart';
import 'package:manda_bai/Core/app_images.dart';
import 'package:onboarding/onboarding.dart';
import 'package:websafe_svg/websafe_svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class OnboardingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Onboarding(
      proceedButtonStyle: ProceedButtonStyle(
          proceedButtonColor: AppColors.greenColor,
          proceedpButtonText: Text(
            AppLocalizations.of(context)!.textbutton_next,
            style: Theme.of(context).textTheme.headline4!.copyWith(
              color: Colors.white,
            ),
          ),
          proceedButtonRoute: (context) {

        return Navigator.pushReplacementNamed(context, '/chooseIsland');
      }),
      pages: [
        PageModel(
          widget: Center(
            child: Column(

              children: [
                const Spacer(),
                WebsafeSvg.asset(
                  AppImages.firstOnboardingImage,
                ),
                SizedBox(
                  height: 20,
                ),
                Text('Familia',
                    style: Theme.of(context).textTheme.headline1!.copyWith(
                          fontSize: Get.width * 0.08,
                        )),
                Text(
                  'De undi bu sta,pa undi bu krê i pa kenha ki bu krê!',
                  style: Theme.of(context).textTheme.headline3,
                ),
                const Spacer(),
              ],
            ),
          ),
        ),
        PageModel(
          widget: Center(
            child: Column(
              children: [
                const Spacer(),
                WebsafeSvg.asset(
                  AppImages.secondOnboardingImage,
                ),
                SizedBox(
                  height: 20,
                ),
                Text('Produtos',
                    style: Theme.of(context).textTheme.headline1!.copyWith(
                          fontSize: Get.width * 0.08,
                        ),),
                Text(
                  'Di tudo un poku!',
                  style: Theme.of(context).textTheme.headline3,
                ),
                const Spacer(),
              ],
            ),
          ),
        ),
        PageModel(
          widget: Center(
            child: Column(
              children: [
                const Spacer(),
                WebsafeSvg.asset(
                  AppImages.thirdOnboardingImage,
                ),
                SizedBox(
                  height: 20,
                ),
                Text('Pagamentu',
                    style: Theme.of(context).textTheme.headline1!.copyWith(
                          fontSize: Get.width * 0.08,
                        )),
                Text(
                  'Seguru i di rapidu acessu!',
                  style: Theme.of(context).textTheme.headline3,
                ),
                const Spacer(),
              ],
            ),
          ),
        ),
      ],
      isSkippable: true,
      skipButtonStyle: SkipButtonStyle(
          skipButtonColor: AppColors.greenColor,
          skipButtonText: Text(
            AppLocalizations.of(context)!.textbutton_skip,
            style: Theme.of(context).textTheme.headline4!.copyWith(
                  color: Colors.white,
                ),
          ),),
      indicator: Indicator(
        closedIndicator:
            ClosedIndicator(color: AppColors.greenColor, borderWidth: 5.0),
        indicatorDesign: IndicatorDesign.line(
          lineDesign: LineDesign(
            lineType: DesignType.line_uniform,
          ),
        ),
      ),
      background: Theme.of(context).scaffoldBackgroundColor,
    );
  }
}
