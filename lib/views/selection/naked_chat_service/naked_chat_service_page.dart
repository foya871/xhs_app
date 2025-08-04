import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../components/ad_banner/classify_ads.dart';
import '../../../components/base_refresh/base_refresh_widget.dart';
import '../../../components/no_more/no_data.dart';
import '../../../components/product/product_cell.dart';
import '../../../model/video/product_detail_model.dart';
import '../../../routes/routes.dart';
import 'naked_chat_service_logic.dart';
import 'naked_chat_service_state.dart';

class NakedChatServicePage extends StatefulWidget {
  const NakedChatServicePage({super.key});

  @override
  State<NakedChatServicePage> createState() => _NakedChatServicePageState();
}

class _NakedChatServicePageState extends State<NakedChatServicePage> {
  final NakedChatServiceLogic logic = Get.put(NakedChatServiceLogic());
  final NakedChatServiceState state = Get.find<NakedChatServiceLogic>().state;

  @override
  void dispose() {
    Get.delete<NakedChatServiceLogic>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseRefreshWidget(
      logic.refreshController,
      child: SingleChildScrollView(
        child: Column(
          children: [
            const ClassifyAds(),
            PagedGridView<int, ProductDetailModel>(
              padding: EdgeInsets.only(top: 10.h, left: 14.w, right: 14.w),
              addAutomaticKeepAlives: true,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              pagingController: logic.refreshController.pagingControllers,
              builderDelegate: PagedChildBuilderDelegate<ProductDetailModel>(
                firstPageProgressIndicatorBuilder: (context) =>
                    const SizedBox.shrink(),
                newPageProgressIndicatorBuilder: (context) =>
                    const SizedBox.shrink(),
                noMoreItemsIndicatorBuilder: (context) =>
                    const SizedBox.shrink(),
                noItemsFoundIndicatorBuilder: (context) => const NoData(),
                itemBuilder: (context, item, index) => ProductCell(
                    item: item,
                    onTap: () {
                      Get.toNakedChatDetail(id: item.productId ?? 0);
                    }),
              ),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisSpacing: 10.w,
                  crossAxisSpacing: 8.w,
                  crossAxisCount: 2,
                  childAspectRatio: 173 / 310),
            )
          ],
        ),
      ),
    );
  }
}
