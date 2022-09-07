import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:homeservice_app_ui/core/const/color.dart';
import 'package:homeservice_app_ui/core/const/path_constants.dart';
import 'package:homeservice_app_ui/core/const/text_constants.dart';
import 'package:homeservice_app_ui/screens/edit_account_screen/page/edit_account_page.dart';
import 'package:homeservice_app_ui/screens/home/bloc/homepage_bloc.dart';
import 'package:homeservice_app_ui/screens/home/bloc/homepage_state.dart';
import 'package:homeservice_app_ui/screens/home/bloc/homepages_event.dart';
import 'package:homeservice_app_ui/screens/home/widgets/services_card.dart';

class HomeContent extends StatelessWidget {
  const HomeContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      child: _createHomeBody(context),
    );
  }

  Widget _createHomeBody(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.symmetric(vertical: 20),
        children: [
          _createProfileData(context),
          const SizedBox(height: 10),
          _createServicesCard(context),
          const SizedBox(height: 10),
          _createCategory(context),
          const SizedBox(height: 8),
          _createOtherServices(context),
        ],
      ),
    );
  }

  Widget _createProfileData(BuildContext context) {
    final User? user = FirebaseAuth.instance.currentUser;
    final displayName = user?.displayName ?? 'No username';
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  TextConstants.welcome,
                  style: TextStyle(
                      fontSize: 20,
                      color: AppColors.welcometextColor,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 6),
                Text(
                  displayName,
                  style: TextStyle(
                      fontSize: 17,
                      color: AppColors.displayNameTextColor,
                      fontWeight: FontWeight.w800),
                )
              ],
            ),
            BlocBuilder<HomeBloc, HomeState>(
                buildWhen: (_, currState) => currState is ReloadImageState,
                builder: (context, state) {
                  final photoURL = FirebaseAuth.instance.currentUser?.photoURL;
                  return GestureDetector(
                    child: photoURL == null
                        ? const CircleAvatar(
                            backgroundImage:
                                AssetImage(PathConstants.profileAvatar),
                            radius: 40,
                          )
                        : CircleAvatar(
                            radius: 25,
                            child: ClipOval(
                              child: FadeInImage.assetNetwork(
                                placeholder: PathConstants.profileAvatar,
                                image: photoURL,
                                fit: BoxFit.cover,
                                width: 200,
                                height: 120,
                              ),
                            ),
                          ),
                    onTap: () async {
                      await Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => const EditAccountScreen()));
                      // ignore: use_build_context_synchronously
                      BlocProvider.of<HomeBloc>(context)
                          .add(ReloadImageEvent());
                    },
                  );
                }),
          ],
        ));
  }

  Widget _createServicesCard(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            TextConstants.allCategory,
            style: TextStyle(
              color: AppColors.welcometextColor,
              fontSize: 18,
              fontWeight:   FontWeight.bold,
            ),
          ),          
          ),
          const SizedBox(height: 10),
          Container(
            height: 160,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                const SizedBox(width: 20),
                ServicesCard(
                  onTap: onTap, 
                  services: services, 
                  color: AppColors.containerOfferColor
              ],
            ),
          ),
      ],
    );
  }
}
