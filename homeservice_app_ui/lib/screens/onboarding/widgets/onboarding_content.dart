import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:homeservice_app_ui/core/const/color.dart';
import 'package:homeservice_app_ui/core/const/data_constants.dart';
import 'package:homeservice_app_ui/screens/onboarding/bloc/onboarding_bloc.dart';
import 'package:homeservice_app_ui/screens/onboarding/bloc/onboarding_event.dart';
import 'package:homeservice_app_ui/screens/onboarding/bloc/onboarding_state.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class OnboardingContent extends StatelessWidget {
  const OnboardingContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<OnboardingBloc>(context);
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(flex: 4, child: _createPageView(bloc.pageController, bloc)),
          Expanded(flex: 2, child: _createStatic(bloc))
        ],
      ),
    );
  }

  Widget _createPageView(PageController controller, OnboardingBloc bloc) {
    return PageView(
        scrollDirection: Axis.horizontal,
        controller: controller,
        children: DataConstants.onboardingTiles,
        onPageChanged: (index) {
          bloc.add(PageSwipedEvent(index: index));
        });
  }

  Widget _createStatic(OnboardingBloc bloc) {
    return Column(children: [
      const SizedBox(height: 30),
      BlocBuilder<OnboardingBloc, OnboardingState>(
        buildWhen: (_, currState) => currState is PageChangedState,
        builder: (context, state) {
          return DotsIndicator(
            dotsCount: 3,
            position: bloc.pageIndex.toDouble(),
            decorator: DotsDecorator(
                color: AppColors.dotsColor,
                activeColor: AppColors.dotsActiveColor),
          );
        },
      ),
      Spacer(),
      BlocBuilder<OnboardingBloc, OnboardingState>(
          buildWhen: (_, currState) => currState is PageChangedState,
          builder: (context, state) {
            final percent = _getPercent(bloc.pageIndex);
            return TweenAnimationBuilder<double>(
              tween: Tween<double>(begin: 0, end: percent),
              duration: const Duration(seconds: 1),
              builder: (context, value, _) => CircularPercentIndicator(
                radius: 110,
                backgroundColor: AppColors.dotsActiveColor,
                progressColor: Colors.white,
                percent: 1 - value,
                center: Material(
                  shape: const CircleBorder(),
                  color: AppColors.dotsActiveColor,
                  child: RawMaterialButton(
                    onPressed: () {
                      bloc.add(PageChangedEvent());
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(24.0),
                      child: Icon(
                        Icons.east_rounded,
                        size: 38.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            );
          }),
      const SizedBox(height: 30),
    ]);
  }

  double _getPercent(int pageIndex) {
    switch (pageIndex) {
      case 0:
        return 0.25;
      case 1:
        return 0.65;
      case 2:
        return 1;
      default:
        return 0;
    }
  }
}
