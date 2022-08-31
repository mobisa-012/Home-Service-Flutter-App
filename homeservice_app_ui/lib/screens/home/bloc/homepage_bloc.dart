import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:homeservice_app_ui/screens/home/bloc/homepage_state.dart';
import 'package:homeservice_app_ui/screens/home/bloc/homepages_event.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial());

  @override
  Stream<HomeState> mapEventToState(
    HomeEvent event,
  ) async* {
    if (event is ReloadImageEvent) {
      yield ReloadImageState();
    }
  }
}
