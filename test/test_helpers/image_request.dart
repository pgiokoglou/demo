import "dart:typed_data";

import "file_utils.dart" as file_utils;

class ImageRequest {
  final Map<String, String>? headers;
  final String mockImagePath;
  final int serverStatusCode;
  final Uri url;

  late final Uint8List _body;

  ImageRequest(
    this.url,
    this.mockImagePath, {
    this.serverStatusCode = 200,
    this.headers,
  }) {
    _body = file_utils.readAsBytesSync(mockImagePath);
  }

  String get baseUrl => url.origin;

  Uint8List get body => _body;

  String get resourcePath => url.toString().replaceAll(baseUrl, "");
}
