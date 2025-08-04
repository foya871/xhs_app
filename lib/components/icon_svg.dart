// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/svg.dart';
//
// class IconSvg extends StatelessWidget {
//   final String assetName;
//   final EdgeInsets padding;
//   final VoidCallback? onTap;
//   final double? width;
//   final double? height;
//   final Color? color;
//
//   const IconSvg(
//     this.assetName, {
//     super.key,
//     this.padding = EdgeInsets.zero,
//     this.onTap,
//     this.width,
//     this.height,
//     this.color,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     ColorFilter? colorFilter;
//     if (color != null) {
//       colorFilter = ColorFilter.mode(color!, BlendMode.srcIn);
//     }
//     final btn = GestureDetector(
//       onTap: onTap,
//       child: Padding(
//         padding: padding,
//         child: SvgPicture.asset(
//           assetName,
//           colorFilter: colorFilter,
//           width: width ?? 16.w,
//           height: height ?? 16.w,
//         ),
//       ),
//     );
//
//     return btn;
//   }
// }
