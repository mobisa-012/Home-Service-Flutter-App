import 'package:homeservice_app_ui/data/home_services_list.dart';

class ServicesData {
  final String title;
  final String image;
  final List<HomeServicesList> homeServiceList;

  ServicesData(
      {required this.homeServiceList,
      required this.image,
      required this.title});

  @override
  String toString() {
    return 'ServicesData(title: $title, image: $image, homeServiceList: $homeServiceList)';
  }
}
