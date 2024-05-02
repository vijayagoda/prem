import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MySvgWidget extends StatelessWidget {
  final image;
  MySvgWidget({required this.image});
  @override
  Widget build(BuildContext context) {
    return SvgPicture.network(
      image,
      height: 30,
      width: 40,
      // fit: BoxFit.fill,
    );
  }
}
