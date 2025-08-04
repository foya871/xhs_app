import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:xhs_app/components/partner_item_cell/partner_item_cell.dart';
import 'package:xhs_app/model/partner_model/partner_model.dart';
import 'package:xhs_app/repositories/sys_partner.dart';

class SysPartnerListView extends StatefulWidget {
  const SysPartnerListView({
    super.key,
    required this.title,
    required this.labelType,
  });

  final String title;

  final int labelType;

  @override
  State<SysPartnerListView> createState() => _SysPartnerListViewState();
}

class _SysPartnerListViewState extends State<SysPartnerListView> {
  List<PartnerModel> _list = [];

  @override
  void initState() {
    super.initState();
    initList();
  }

  void initList() async {
    var list = await SignInRepositoryImpl().fetchPartnerList(widget.labelType);
    setState(() {
      _list = list;
    });
  }

  Widget _buildTitle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(2.5),
            color: const Color(0xffdd001b),
          ),
          width: 4.w,
          height: 15.w,
        ),
        SizedBox(
          width: 6.w,
        ),
        Text(
          widget.title,
          style: TextStyle(
            fontSize: 16.w,
            color: const Color(0xff333333),
            letterSpacing: 0,
          ),
        )
      ],
    );
  }

  Widget _buildGridListByLabelTypeOne() {
    return MasonryGridView.builder(
      gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 5,
      ),
      padding: const EdgeInsets.all(0),
      mainAxisSpacing: 12.w,
      crossAxisSpacing: 18.w,
      // controller: _scrollController,
      // primary: true,
      itemCount: _list.length,
      shrinkWrap: true,
      // physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        // return PartnerItemCellStyleOne(
        //   app: _list[index],
        // );
        return PartnerItemCell(app: _list[index], style: widget.labelType);
      },
    );
  }

  Widget _buildListListByLabelTypeZero() {
    return ListView.separated(
      padding: const EdgeInsets.all(0),
      shrinkWrap: true, // 根据内容大小收缩
      physics: const NeverScrollableScrollPhysics(), // 禁用滚动
      itemCount: _list.length,
      itemBuilder: (context, index) {
        // return PartnerItemCellStyleZero(app: _list[index]);
        return PartnerItemCell(app: _list[index], style: widget.labelType);
      },
      separatorBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 9.w),
          child: const Divider(
            color: Color(0xfff0f0f0),
            height: 1,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildTitle(),
        SizedBox(
          height: 12.w,
        ),
        widget.labelType == 0
            ? _buildListListByLabelTypeZero()
            : _buildGridListByLabelTypeOne()
      ],
    );
  }
}
