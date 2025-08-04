///所有项目通用广告枚举
enum AdApiType {
  INVALID(""),
  START("START"), // 启动页  ("750*1624 / 750*806 / 750*533")
  START_POP_UP("START_POP_UP"), // 启动弹框  ("660*300")
  TOP_VERTICAL_BANNER("TOP_VERTICAL_BANNER"), //顶部竖版Banner
  TOP_BANNER("TOP_BANNER"), // 顶部横版banner  ("710*400")
  INDEX_POP_ICON("INDEX_POP_ICON"), // 弹窗九宫格图标  ("150*150")
  INSERT_ICON("INSERT_ICON"), // 插入图标广告  ("150*150")
  FLOATING_ICON_BOTTOM_RIGHT(
      "FLOATING_ICON_BOTTOM_RIGHT"), // 悬浮图标文字广告  ("150*150")
  ONE_COLUMN_WATERFALL_VERTICAL(
      "ONE_COLUMN_WATERFALL_VERTICAL"), // 单列瀑布流横版广告  ("710*400")
  TWO_COLUMN_WATERFALL_VERTICAL(
      "TWO_COLUMN_WATERFALL_VERTICAL"), // 两列瀑布流竖版广告  ("348*486")
  THREE_COLUMN_WATERFALL_VERTICAL(
      "THREE_COLUMN_WATERFALL_VERTICAL"), // 三列瀑布流竖版广告  ("230*320")
  INSERT_IMAGE("INSERT_IMAGE"), // 插入广告  ("710*200")
  TEXT("TEXT"), // 文字广告  ("配置最多4个字")
  COMMENT_TEXT("COMMENT_TEXT"), // 评论广告
  PLAY_PAGE_THUMBNAIL("PLAY_PAGE_THUMBNAIL"), // 播放页小图  ("300*60")
  LONG_VIDEO_PAUSE("LONG_VIDEO_PAUSE"), // 播放页暂停广告  ("348*196")
  LONG_VIDEO_PLAY_START("LONG_VIDEO_PLAY_START"), // 播放页开头广告  ("750*460")
  FULL_SCREEN("FULL_SCREEN"), //短视频播放全屏广告
  NAV_ICON("NAV_ICON"), // 福利图标广告  ("150*150")
  // VIDEO_COMMENT_TEXT("VIDEO_COMMENT_TEXT"), // 视频评论区文字广告2000,

  ;

  final String name;

  const AdApiType(this.name);
}

abstract class AdApiTypeCompat {
  static const CLASSIFY_ICON = AdApiType.INSERT_ICON;
  static const VERTICAL_INSERT = AdApiType.TWO_COLUMN_WATERFALL_VERTICAL;
  static const BOTTOM_BANNER = AdApiType.FLOATING_ICON_BOTTOM_RIGHT;
  static const PLAY_WIDGET = AdApiType.LONG_VIDEO_PLAY_START;
  static const VIDEO_PAUSED = AdApiType.LONG_VIDEO_PAUSE;
  static const PLAY_PAGE = AdApiType.INSERT_IMAGE;
  static const VERTICAL_LIST_INSERT = AdApiType.TWO_COLUMN_WATERFALL_VERTICAL;
  static const THREE_LIST_VERTICAL = AdApiType.THREE_COLUMN_WATERFALL_VERTICAL;
  static const LIST_STREAM = AdApiType.INSERT_ICON;
  static const HORIZONTAL_LIST_INSERT = AdApiType.INSERT_IMAGE;
  static const INSERT_COMMON = AdApiType.INSERT_IMAGE;
}

///广告展示类型
enum AdShowType {
  single("single"), // 单个广告
  multiple("multiple"), // 多个广告
  insert("insert"), // 插入广告
  ;

  final String type;

  const AdShowType(this.type);
}

extension AdApiTypeRatio on AdApiType {
  double get ratio => switch (this) {
        AdApiType.START || AdApiType.START_POP_UP => 750 / 1624,
        AdApiType.TOP_BANNER => 710 / 400,
        AdApiType.INDEX_POP_ICON ||
        AdApiType.INSERT_ICON ||
        AdApiType.FLOATING_ICON_BOTTOM_RIGHT =>
          150 / 150,
        AdApiType.ONE_COLUMN_WATERFALL_VERTICAL => 710 / 400,
        AdApiType.TWO_COLUMN_WATERFALL_VERTICAL => 348 / 486,
        AdApiType.THREE_COLUMN_WATERFALL_VERTICAL => 230 / 320,
        AdApiType.INSERT_IMAGE => 710 / 200,
        AdApiType.TEXT || AdApiType.COMMENT_TEXT => 1.0,
        AdApiType.PLAY_PAGE_THUMBNAIL => 300 / 60,
        AdApiType.LONG_VIDEO_PAUSE => 348 / 196,
        AdApiType.LONG_VIDEO_PLAY_START => 750 / 460,
        AdApiType.FULL_SCREEN => 750 / 460,
        _ => 1.0
      };
}
