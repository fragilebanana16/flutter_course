class MessageModel {
  String type;
  String message;
  String time;
  ImageDetail image;
  MessageModel(
      {this.message = '',
      this.type = '',
      this.time = '',
      this.image = const ImageDetail()});

  bool isImageNotEmpty() {
    return image.imgPath != '' && image.imgWidth != 0 && image.imgHeight != 0;
  }
}

class ImageDetail {
  final String imgPath;
  final int imgWidth;
  final int imgHeight;
  const ImageDetail({
    this.imgPath = '',
    this.imgWidth = 0,
    this.imgHeight = 0,
  });
}
