import 'package:homeservice_app_ui/core/const/path_constants.dart';
import 'package:homeservice_app_ui/core/const/text_constants.dart';
import 'package:homeservice_app_ui/screens/onboarding/widgets/onboarding_tile.dart';

class DataConstants {
  static final onboardingTiles = [
    OnboardingTile(
      title: TextConstants.onboardingTilesTitle,
      mainText: TextConstants.onboardingTilesDescription,
      imagePath : PathConstants.onboarding1
    ),
  ];
}
