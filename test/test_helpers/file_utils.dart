import "dart:io";
import "dart:typed_data";

Uint8List readAsBytesSync(String file) => File(file).readAsBytesSync();
