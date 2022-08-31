import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:homeservice_app_ui/screens/home/bloc/homepage_bloc.dart';
import 'package:homeservice_app_ui/screens/home/bloc/homepage_state.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildContext(context),
    );
  }
  BlocProvider<HomeBloc> _buildContext (BuildContext context){
    return BlocProvider<HomeBloc>(
      create: (BuildContext context) => HomeBloc(),
      child: BlocConsumer<HomeBloc, HomeState>(
        buildWhen: (_,currState) => currState is HomeInitial,
        builder: (context, state) {
          return HomeContent(),
        },
        listenWhen: (_,currState) => true,
        listener: (context, state){ },
      ),
      );
  }
}