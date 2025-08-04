import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:xhs_app/components/image_view.dart';
import 'package:xhs_app/model/partner_model/partner_model.dart';
import 'package:xhs_app/repositories/sys_partner.dart';
import 'package:xhs_app/utils/ad_jump.dart';

class PartnerItemCell extends StatelessWidget {
  const PartnerItemCell({super.key, required this.app, required this.style});

  final int style;

  final PartnerModel app;

  void _onTap() async {
    SignInRepositoryImpl().fetchClickReport(app.id!);
    jumpExternalAddress(app.link!, null);
  }

  Widget _buildZeroStyle() {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(5.w)),
          child: SizedBox(
            width: 60.w,
            height: 60.w,
            child: ImageView(src: app.icon ?? ''),
          ),
        ),
        SizedBox(
          width: 7.w,
        ),
        Expanded(
          child: Text(
            app.name ?? '',
            style: TextStyle(
              fontSize: 12.w,
              color: const Color(0xff333333),
            ),
          ),
        ),
        ClipRRect(
          child: Container(
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFFF78248), // #F78248
                  Color(0xFFF52C0F), // #F52C0F
                  Color(0xFFF5019A), // #F5019A
                ],
                stops: [0.0, 0.44, 1.0], // 渐变的停止位置
              ),
              borderRadius: BorderRadius.circular(11), // 设置圆角
            ),
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            child: Text(
              "立即下载",
              style: TextStyle(fontSize: 11.w, color: const Color(0xffffffff)),
            ),
          ),
        )
      ],
    );
  }

  Widget _buildOneStyle() {
    return Column(
      children: [
        AspectRatio(
          aspectRatio: 1 / 1, // 正方形图片
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(5.w)),
            child: ImageView(
              src: app.icon ?? '',
            ),
          ),
        ),
        SizedBox(
          height: 12.w,
        ),
        Text(
          app.name ?? '',
          style: TextStyle(
            fontSize: 12.w,
            color: const Color(0xff333333),
            overflow: TextOverflow.ellipsis,
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _onTap();
      },
      child: style == 0 ? _buildZeroStyle() : _buildOneStyle(),
    );
  }
}
