

import 'package:flutter/widgets.dart';

class ActivityMaskDown extends CustomClipper<Path>{
  bool? up;
  ActivityMaskDown({this.up});
  @override
  Path getClip(Size size) {
    var path = Path();
    path.moveTo(size.width/5, 0);
    path.lineTo(size.width/2+size.width/5, 0);
    path.lineTo(size.width,  size.height/2-size.height/5);
    path.lineTo(size.width,  size.height-size.height/5);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}