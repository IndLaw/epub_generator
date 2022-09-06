library epub_generator;

// this file has a circular dependency with resource.dart
import 'package:epub_generator/board/resource.dart';

/// Types of resource files supported by such listing programs

class MediaTypeService {
  static final Map<String, String> mediaType = {
    "xhtml": "application/xhtml+xml",
    "jpeg": "image/jpeg",
    "jpg": "image/jpg",
    "png": "image/png",
    "js": "application/javascript",
    "css": "text/css"
  };
  static const String xhtml = "application/xhtml+xml";
  static const String jpg = "image/jpg";
  static const String jpeg = "image/jpeg";
  static const String png = "image/png";
  static const String js = "application/javascript";
  static const String css = "text/css";

  static String getMediaTypeType(String extension) {
    return mediaType[extension]
        .toString(); // this may or may not cause trouble trying to find value from key
  }

  static bool isImage(Resource resource) {
    String type = resource.mediaType; // mediaType from resource file, not this file
    return (type == mediaType["jpeg"]) || (type == mediaType["jpg"]) || (type == mediaType["png"]);
  }
}
