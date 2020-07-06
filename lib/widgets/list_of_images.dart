import 'package:flutter/material.dart';
import 'package:market_place/constant/decoration.dart';
import 'package:market_place/widgets/image_network.dart';

class ListOfImages extends StatelessWidget {
  const ListOfImages({
    this.images,
    this.onTap,
  });

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
              margin: EdgeInsets.only(right: 8.0, left: 8),
              decoration: BoxDecoration(
                boxShadow: [shadow],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(24.0),
                child: ImageNetwork(image: images[index]),
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
