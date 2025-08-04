import 'package:collection/collection.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import 'package:xhs_app/components/easy_toast.dart';
import 'package:xhs_app/components/image_picker/easy_image_picker.dart';
import 'package:xhs_app/http/api/api.dart';
import 'package:xhs_app/model/community/collection_base_model.dart';
import 'package:xhs_app/model/image_upload_resp_model.dart';
import 'package:xhs_app/utils/utils.dart';
import 'package:xhs_app/views/player/chewie/src/chewie_player.dart';

import '../../../http/service/api_service.dart';
import '../../../model/community/community_classify_model.dart';
import '../../../model/community/community_release_model.dart';
import '../../../model/community/community_topic_model.dart';
import '../../../model/community/community_video_model.dart';
import '../../../services/user_service.dart';

const _dataTypeVideo = 2;
const _dataTypeImage = 1;

class CommunityReleasePageController extends GetxController {
  late final int dataType; // 发布类型 视频-2，图文-1

  ///是否是发布视频
  bool get isUploadVideo => dataType == _dataTypeVideo;

  TextEditingController textEditingController = TextEditingController();

  TextEditingController contentEditingController = TextEditingController();

  TextEditingController priceEditingController = TextEditingController();

  FocusNode focusNode = FocusNode();
  FocusNode contentFocusNode = FocusNode();
  FocusNode priceFocusNode = FocusNode();
  ValueNotifier<bool> showComm = ValueNotifier(false);

  final us = Get.find<UserService>();
  final int maxLength = 200;
  var communityRelease = CommunityReleaseModel.fromJson({}).obs;
  var video = CommunityVideoModel.fromJson({}).obs;

  ///标签
  var lablesItems = <CommunityTopicModel>[].obs;
  var selectedLablesItems = <CommunityTopicModel>[].obs;
  var allLablesItems = <CommunityTopicModel>[].obs;

  ///分类
  var classifyItems = <CommunityClassifyModel>[].obs;
  var currentClassify = CommunityClassifyModel.fromJson({}).obs;

  var collectionItems = <CollectionBaseModel>[].obs;

  var currentCollection = CollectionBaseModel.fromJson({}).obs;

  var moneyInputFormatter =
      FilteringTextInputFormatter.allow(RegExp(r'[0-9.]'));

  var isSwitch = false.obs;
  var isLabel = false.obs;

  void init(int dataType) {
    this.dataType = dataType;
  }

  @override
  void onInit() {
    // getTopicList();
    // getClassifyList();
    // getCollectionList();
    super.onInit();
  }

  @override
  void onClose() {
    textEditingController.dispose();
    priceEditingController.dispose();
    focusNode.dispose();
    contentFocusNode.dispose();
    priceFocusNode.dispose();
    super.onClose();
  }

  Future<void> getTopicList() async {
    final result = await Api.getTopicList(page: 1, pageSize: 10, noPage: true);
    if (result != null) {
      lablesItems.value = result;
      update();
    }
  }

  Future<void> getAllTopicList() async {
    try {
      SmartDialog.showLoading(msg: "加载中...", alignment: Alignment.center);
      final result =
          await Api.getTopicList(page: 1, pageSize: 100, noPage: true);
      if (result != null) {
        allLablesItems.value = result;
        update();
      }
    } catch (e) {
      SmartDialog.dismiss();
    } finally {
      SmartDialog.dismiss();
    }
  }

  Future<void> getClassifyList() async {
    final result = await Api.getCommunityClassify(true);
    if (result != null) {
      classifyItems.value = result;
      update();
    }
  }

  Future<void> getCollectionList() async {
    final result = await Api.queryCollectionByUser(
        page: 1, pageSize: 10, userId: us.user.userId ?? 0);
    if (result.isNotEmpty) {
      collectionItems.value = result;
      update();
    }
  }

  Future addTopic(CommunityTopicModel item) async {
    // if (items.length >= 2) {
    //   EasyToast.show('最多选择2个');
    // } else {

    // }
    for (int i = 0; i < lablesItems.length; i++) {
      if (lablesItems[i].id == item.id) {
        selectedLablesItems.add(item);
        lablesItems[i].selected = true;
        break;
      }
    }
    lablesItems.refresh();
  }

  Future selectClassify(CommunityClassifyModel item) async {
    currentClassify.value = item;
    update();
  }

  Future deleteTopic(CommunityTopicModel item) async {
    for (int i = 0; i < selectedLablesItems.length; i++) {
      if (selectedLablesItems[i].id == item.id) {
        selectedLablesItems.remove(item);
        break;
      }
    }
    selectedLablesItems.refresh();
  }

  Future addImages(List<String> images) async {
    communityRelease.value.images = images;
  }

  Future addVideo(Map map) async {
    video.value.id = map["id"];
    video.value.playTime = map["playTime"];
    video.value.videoUrl = map["uri"];
    video.value.title = map["title"];
    communityRelease.value.video = video.value;
  }

  Future release() async {
    final title = communityRelease.value.title!.trim();
    if (title.isEmpty) {
      EasyToast.show('请填写标题');
      return;
    }
    if (communityRelease.value.topic?.isNotEmpty != true) {
      EasyToast.show('请选择标签');
      return;
    }
    if (communityRelease.value.classifyTitle?.isNotEmpty != true) {
      EasyToast.show('请选择分类');
      return;
    }

    bool hasVideo = communityRelease.value.video != null;
    bool hasImage = communityRelease.value.images?.isNotEmpty == true;
    if (isUploadVideo) {
      if (!hasVideo) {
        EasyToast.show('请选择视频');
        return;
      }

      if (!hasImage) {
        EasyToast.show('请上传封面');
        return;
      }
    } else {
      if (!hasImage) {
        EasyToast.show('请上传图片');
        return;
      }
    }

    // if (isLabel.value == true) {
    //   int idx = lables.indexWhere((e) => e.isSelect == true);
    //   if (idx < 0) {
    //     EasyToast.show('请选择标签');
    //     return;
    //   } else {
    //     topicList.clear();
    //     for (int i = 0; i < lables.length; i++) {
    //       if (lables[i].isSelect == true) {
    //         topicList.add(lables[i].tagsTitle ?? '');
    //       }
    //     }
    //     communityRelease.value.topicNames = topicList;
    //   }
    // } else {
    //   if (items.isNotEmpty) {
    //     topicList.clear();
    //     for (int i = 0; i < items.length; i++) {
    //       topicList.add(items[i].name ?? '');
    //     }
    //     communityRelease.value.topicNames = topicList;
    //   }
    //   if (communityRelease.value.topicNames == null) {
    //     EasyToast.show('请选择话题');
    //     return;
    //   }
    // }
    SmartDialog.showLoading(msg: "加载中...", alignment: Alignment.center);
    if (isUploadVideo) {
      ///发布视频
      // final result = await Api.addVideo(
      //     checkSum: Utils.md5String(title),
      //     id: communityRelease.value.video?.id ?? '',
      //     playTime: communityRelease.value.video?.playTime ?? 0,
      //     tagTitles: selectedLablesItems.map((e) => e.name ?? '').toList(),
      //     title: title,
      //     videoUrl: communityRelease.value.video?.videoUrl ?? '',
      //     price: isSwitch.value ? int.tryParse(priceEditingController.text) : 0,
      //     videoType: isSwitch.value ? 2 : 0,
      //     verticalImg: communityRelease.value.images ?? [],
      //     coverImg: ['image/34/z4/44/dd/dc6371306bd547d8ba4c311b7c200424.png'],
      //     size: 1);

      final result = await Api.communityRelease(bean: communityRelease.value);
      SmartDialog.dismiss();
      if (result == true) {
        EasyToast.show('发布成功');
        Get.back();
      }
    } else {
      ///发布动态
      ///

      final result = await Api.communityRelease(bean: communityRelease.value);
      SmartDialog.dismiss();
      if (result) {
        EasyToast.show('发布成功');
        Get.back();
      }
    }
  }

  Future checkSwitch() async {
    isSwitch.value = !isSwitch.value;
  }

  //////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  var localFilePath = '';
  var seconds = 0;
  var nnn = 0;
  var count = 0;
  var taskId = '';
  var id = '';
  var videoUri = '';
  List<List<Uint8List>> segments = List<List<Uint8List>>.of([]);
  List<CancelToken> tokenList = List<CancelToken>.of([]);
  var segmentNum = 0;
  static const PERM = 1.5;
  static const PERSIZE = 1.5 * 1024 * 1024;
  static const MAXASYNCNUM = 5;
  ChewieController? chewieController;

  Future pickSingleVideo() async {
    updateLocalVideo('');
    final video = await EasyImagePicker.pickSingleVideoGrant();
    final bytes = await video?.bytes;
    if (bytes != null && video != null) {
      //选择到了视频
      updateLocalVideo(video.path);
      resizeVideoData(bytes, textEditingController.text, videoName: video.name);
    }
  }

  //更新本地视路径
  void updateLocalVideo(String filepath) {
    localFilePath = filepath;
    seconds = 0;
    if (filepath.isNotEmpty) {
      chewieController = ChewieController(
        videoPlayerController: VideoPlayerController.asset(filepath),
        autoInitialize: false,
        autoPlay: false,
        showOptions: false,
        showControls: false,
        looping: false,
        aspectRatio: 1,
        allowFullScreen: false,
        allowPlaybackSpeedChanging: false,
        showControlsOnInitialize: false,
        playbackSpeeds: [],
        placeholder: Container(
          color: Colors.black,
        ),
      );
      chewieController!.videoPlayerController.addListener(() {
        final playtime =
            chewieController!.videoPlayerController.value.duration.inSeconds;
        seconds = playtime;
      });
    }
    update();
  }

  void resizeVideoData(Uint8List bytes, String title, {String? videoName}) {
    nnn = 0;
    final m = bytes.length / 1024 / 1024;
    const M = PERM;
    final ccc = m % M == 0;
    if (ccc) {
      nnn = (m / M).toInt();
    } else {
      nnn = (m / M).toInt() + 1;
    }
    List<Uint8List> bytesList = [];
// ignore: non_constant_identifier_names
    final BYTESPER = PERSIZE.toInt();
    for (int i = 0; i < nnn; i++) {
      final start = i * BYTESPER;
      final end = i < nnn - 1
          ? (i + 1) * BYTESPER
          : ccc
              ? (i + 1) * BYTESPER
              : bytes.length;
      final item = bytes.sublist(start, end);
      bytesList.add(item);
    }
    count = bytesList.length;
    String name = videoName?.split(".").first ?? '';
    taskId = Utils.md5String(name);

    /// 分片上传
    upload2ServerAction(bytesList, title, videoName: videoName);
  }

  void upload2ServerAction(List<Uint8List> bytesList, String title,
      {String? videoName}) async {
    const N = MAXASYNCNUM;
    final arr = bytesList.slices(N).toList();
    segments = arr;
    segmentNum = arr.length;
    uploadVideoData(title: title);
  }

  ///每N个开一条线程去上传
  Future uploadVideoData({required String title}) async {
    final current = segments.length - segmentNum;
    final total = segments.length;
    final percent = ((current / total) * 100).toDouble().toStringAsFixed(2);
    SmartDialog.showLoading(msg: "$percent%", alignment: Alignment.center);
    if (segmentNum >= 1) {
      final index = segments.length - segmentNum;
      final bytesList = segments[index];

      final tasks = bytesList.map(
        (e) {
          final token = CancelToken();
          tokenList.add(token);
          final iii = bytesList.indexOf(e);
          final pos = index * MAXASYNCNUM + iii;
          return task(bytes: e, token: token, pos: pos, taskId: taskId);
        },
      ).toList();
      final resp = await compute(_uploadSegmentsAction, tasks);
      if (resp != true) {
        uploadFailure();
        return;
      }
      if (segmentNum == 1) {
        videoOk(title: title);
        return;
      }
      segmentNum--;
      uploadVideoData(title: title);
    } else {
      videoOk(title: title);
    }
  }

  /// 构建任务
  Future task(
      {required Uint8List bytes,
      required CancelToken token,
      required int pos,
      required String taskId}) {
    return httpInstance.multiPartFormPost(
      url: "upload/video",
      isVideo: true,
      token: token,
      file: bytes,
      body: {
        "pos": pos,
        "taskId": taskId,
      },
    );
  }

  ///每N个开条线程处理一次
  Future<bool?> _uploadSegmentsAction(List<Future<dynamic>> tasks) async {
    try {
      final resp = await Future.wait(tasks);
      if (resp.isEmpty) {
        return false;
      }
      if (id.isEmpty) {
        _setUriAndId(resp[0]);
      }
      final success = resp.every((e) {
        final s =
            e != null && e is Map && e.keys.contains("id") && e["id"] != null;
        return s;
      });

      if (success == false) {
        uploadFailure();
      }
      return success;
    } catch (_) {
      uploadFailure();
      return false;
    }
  }

  void uploadFailure() {
    SmartDialog.dismiss();
    SmartDialog.showToast("失败，请重试!", alignment: Alignment.center);
  }

  ///合成视频
  Future videoOk({required String title}) async {
    assert(id.isNotEmpty && title.isNotEmpty && taskId.isNotEmpty,
        "videoOk required paramters not found");
    try {
      await httpInstance.post(url: "upload/videoOk", isFile: true, body: {
        "checkSum": taskId,
        "id": id,
        "title": title,
        "type": 1,
      });
      SmartDialog.dismiss();
      SmartDialog.showToast("上传成功!", alignment: Alignment.center);
    } catch (_) {
      uploadFailure();
    }
  }

  void _setUriAndId(dynamic resp) {
    if (resp is Map && resp["id"] != null) {
      id = resp["id"];
      videoUri = resp["videoUri"];
    }
  }

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  var cover = ''.obs;

  Future pickImage(int index) async {
    final imageFile = index == 2
        ? await EasyImagePicker.pickSingleImageGrantCamera()
        : await EasyImagePicker.pickSingleImageGrant();
    final bytes = await imageFile?.bytes;
    if (bytes != null) {
      uploadCover(bytes);
    }
  }

  Future uploadCover(Uint8List bytes) async {
    SmartDialog.showLoading(msg: "正在上传中...", alignment: Alignment.center);
    try {
      ImageUploadRspModel? resp =
          await httpInstance.uploadImage(bytes, (int count, int total) {});
      SmartDialog.dismiss();
      if (resp != null) {
        cover.value = resp.fileName ?? '';
        video.value.coverImg = cover.value;
      }
      SmartDialog.showToast("上传成功", alignment: Alignment.center);
    } catch (_) {
      SmartDialog.showToast("上传失败", alignment: Alignment.center);
    }
  }
}
