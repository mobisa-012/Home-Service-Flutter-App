import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:homeservice_app_ui/screens/tab_bar/bloc/tab_bar_event.dart';
import 'package:homeservice_app_ui/screens/tab_bar/bloc/tab_bar_state.dart';

class TabBarBloc extends Bloc<TabBarEvent, TabBarState> {
  TabBarBloc() : super(TabBarInitial());

  int currentIndex = 0;
  bool isSelected = false;

  @override
  Stream<TabBarState> mapEventToState(TabBarEvent event) async* {
    if (event is TabBarItemTappedEvent) {
      currentIndex = event.index;
      yield TabBarItemSelectedState(index: currentIndex);
    }
  }
}
