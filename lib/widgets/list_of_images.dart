import 'package:flutter/material.dart';
import 'package:market_place/constant/decoration.dart';
import 'package:market_place/widgets/image_network.dart';

class ListOfImages extends StatelessWidget {
  const ListOfImages({
    this.width,
    this.images,
    this.onTap,
    this.height,
  });

  final double width;
  final double height;
  final Function onTap;
  final List images;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: 'Click Here to Change The Photos',
      preferBelow: true,
      showDuration: Duration(seconds: 7),
      waitDuration: Duration(seconds: 7),
      child: InkWell(
        onTap: onTap,
        child: ListView.builder(
          itemBuilder: (context, index) {
            return Container(
              margin: EdgeInsets.all(12.0),
              width: width / 2 + 34,
              decoration: BoxDecoration(
                boxShadow: [shadow],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12.0),
                child: ImageNetwork(
                  image: images[index],
                  width: width,
                  height: height,
                ),
              ),
            );
          },
          physics: ClampingScrollPhysics(),
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: images.length ?? 0,
        ),
      ),
    );
  }
}
