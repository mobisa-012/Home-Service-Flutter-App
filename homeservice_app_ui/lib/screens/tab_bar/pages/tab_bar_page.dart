import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:homeservice_app_ui/core/color.dart';
import 'package:homeservice_app_ui/core/path_constants.dart';
import 'package:homeservice_app_ui/core/text_constants.dart';
import 'package:homeservice_app_ui/screens/account_page/page/account_page.dart';
import 'package:homeservice_app_ui/screens/home/pages/home_page.dart';
import 'package:homeservice_app_ui/screens/tab_bar/bloc/tab_bar_bloc.dart';
import 'package:homeservice_app_ui/screens/tab_bar/bloc/tab_bar_event.dart';
import 'package:homeservice_app_ui/screens/tab_bar/bloc/tab_bar_state.dart';
import 'package:homeservice_app_ui/screens/task_page/page/task_page.dart';

class TabBarPage extends StatelessWidget {
  const TabBarPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TabBarBloc>(
      create: (BuildContext context) => TabBarBloc(),
      child: BlocConsumer<TabBarBloc, TabBarState>(
        listener: (context, state) => {},
        buildWhen: (_, currState) =>
            currState is TabBarInitial || currState is TabBarItemSelectedState,
        builder: (context, state) {
          final bloc = BlocProvider.of<TabBarBloc>(context);
          return Scaffold(
            body: _createBody(context, bloc.currentIndex),
            bottomNavigationBar: _createBottomTabBar(context),
          );
        },
      ),
    );
  }

  Widget _createBottomTabBar(BuildContext context) {
    final bloc = BlocProvider.of<TabBarBloc>(context);
    return BottomNavigationBar(
      currentIndex: bloc.currentIndex,
      fixedColor: AppColors.dotsActiveColor,
      items: [
        BottomNavigationBarItem(
            icon: Image(
              image: const AssetImage(PathConstants.homeIcon),
              color: bloc.currentIndex == 0 ? AppColors.dotsActiveColor : null,
            ),
            label: TextConstants.homeIcon),
        BottomNavigationBarItem(
            icon: Image(
              image: const AssetImage(PathConstants.taskIcon),
              color: bloc.currentIndex == 1 ? AppColors.dotsActiveColor : null,
            ),
            label: TextConstants.homeIcon),
        BottomNavigationBarItem(
            icon: Image(
              image: const AssetImage(PathConstants.accountIcon),
              color: bloc.currentIndex == 2 ? AppColors.dotsActiveColor : null,
            ),
            label: TextConstants.homeIcon),
      ],
      onTap: (index) {
        bloc.add(TabBarItemTappedEvent(index: index));
      },
    );
  }

  Widget _createBody(BuildContext context, int index) {
    final children = [
      const HomePage(),
      const TasksPage(),
      const AccountsPage(),
    ];
    return children[index];
  }
}
