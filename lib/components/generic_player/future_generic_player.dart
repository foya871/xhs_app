import 'dart:async';

import 'package:flutter/material.dart';

import '../../views/player/views/av_player_loading.dart';
import '../base_page/base_error_widget.dart';
import '../safe_state.dart';
import 'generic_player.dart';
import 'generic_player_model.dart';
import 'generic_player_option.dart';

class FutureGenericPlayer extends StatefulWidget {
  final Future<GenericPlayerModel> model;
  final FutureGenericPlayerOption? option;
  const FutureGenericPlayer(this.model, {super.key, this.option});

  @override
  State<FutureGenericPlayer> createState() => _State();
}

class _State extends SafeState<FutureGenericPlayer> {
  Widget _buildLoading(BuildContext context) =>
      widget.option?.loadingBuilder?.call(context) ?? const AvPlayerLoading();

  Widget _buildLoadFail(BuildContext context, Object? err) =>
      widget.option?.loadFailBuilder?.call(context, err) ??
      const BaseErrorWidget();

  @override
  Widget build(BuildContext context) => SizedBox(
        width: widget.option?.width,
        height: widget.option?.height,
        child: FutureBuilder<GenericPlayerModel>(
          future: widget.model,
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return _buildLoading(context);
              default:
                if (snapshot.hasError || !snapshot.hasData) {
                  return _buildLoadFail(context, snapshot.error);
                }
                return GenericPlayer(snapshot.data!);
            }
          },
        ),
      );
}
