import 'package:flutter/cupertino.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:homeservice_app_ui/data/services_data.dart';

class ServicesCard extends StatelessWidget {
  final Function() onTap;
  final Color color;
  final ServicesData services;

  const ServicesCard({Key? key, required this.onTap, required this.services, required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.only(top: 20, right: 6, left: 10),
        height: 160,
        width: screenWidth * 0.6,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), 
            color: color),
            child: Stack(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 5),
                        Text(
                          services.title
                        )
                      ],
                    )],
              )],
            ),
      ),
    );
  }
}
