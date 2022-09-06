library epub_generator;

// this file has a circular dependency with media_type_service.dart
import 'package:epub_generator/service/media_type_service.dart';
import 'package:epub_generator/util/string_util.dart';

import 'dart:io';

class Resource {
  late File file;
  late String id;
  late String extension;
  late String mediaType;

  Resource(this.file) {
    id = file.uri.pathSegments.last;
    extension = StringUtil.getFileExtension(id);
    mediaType = MediaTypeService.getMediaTypeType(extension);
  }
}
