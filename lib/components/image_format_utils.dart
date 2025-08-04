// ignore_for_file: constant_identifier_names

/// 图片格式
///
enum ImageFormat {
  /// 未知格式
  UNDEFINED,
  JPEG,
  PNG,
  GIF,
  TIFF,
  WEBP,
  PDF,
  SVG,
  BMP,
}

class ImageFormatUtils {
  ImageFormatUtils._();

  /// 通过图片bytes分析前几位 获取图片格式，加密了的图片 他前几位编码格式是乱码，所以解密，普通未加密的图片则不需要解密操作
  ///
  static ImageFormat imageFormatForImageUnit8List(List<int> data) {
    if (data.isEmpty || data.length < 4) {
      return ImageFormat.UNDEFINED;
    }

    switch (data) {
      case [137, 80, 78, 71, 13, 10, 26, 10, ...]:
        return ImageFormat.PNG;
      case [255, 216, 255, ...]:
        return ImageFormat.JPEG;
      case [71, 73, 70, 56, 55, 97, ...] || [71, 73, 70, 56, 57, 97, ...]:
        return ImageFormat.GIF;
      case [82, 73, 70, 70, ...]:
        return ImageFormat.WEBP;
      case [73, 73, 42, ...] || [77, 77, 0, ...]:
        return ImageFormat.TIFF;
      case [60, 115, 118, 103, ...] && [..., 60, 47, 115, 118, 103, 62]:
        return ImageFormat.SVG;
      case [66, 77, ...]:
        return ImageFormat.BMP;
      case [0x25, 0x50, 0x44, 0x46, 0x2D, ...]:
        return ImageFormat.PDF;
      default:
        return ImageFormat.UNDEFINED;
    }
  }
}
