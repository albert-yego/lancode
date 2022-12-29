import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lanquiz/util/constants.dart';

class CustomSnackBarContent extends StatelessWidget {
  const CustomSnackBarContent({
    Key? key,
    required this.errorMessage,
  }) : super(key: key);

  final String errorMessage;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          padding: EdgeInsets.all(16),
          height: getHeight / 9,
          decoration: BoxDecoration(
            color: Colors.purple,
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          child: Row(
            children: [
              SizedBox(width: getWidth / 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Damn',
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontFamily: 'Muli'),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Spacer(),
                    Text(
                      errorMessage,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                        fontFamily: 'Muli',
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 0,
          child: ClipRRect(
            borderRadius:
                const BorderRadius.only(bottomLeft: Radius.circular(20)),
            child: SvgPicture.asset(
              "assets/icons/bubbles.svg",
              height: getHeight / 16,
              width: getWidth / 10,
              color: Color(0xff801336),
            ),
          ),
        ),
        Positioned(
            top: -(getHeight / 40),
            left: 0,
            child: Stack(
              alignment: Alignment.center,
              children: [
                SvgPicture.asset(
                  "assets/icons/fail.svg",
                  height: getHeight / 20,
                ),
              ],
            )),
      ],
    );
  }
}
