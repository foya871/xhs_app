import 'package:flutter/material.dart';

import '../../../../components/no_more/no_data.dart';
import 'community_tab_base_widget.dart';

class CommunityTabEmptyWidget extends CommunityTabBaseWidget {
  const CommunityTabEmptyWidget({super.key, required super.controllerTag});

  @override
  Widget build(BuildContext context) => const NoData();
}
