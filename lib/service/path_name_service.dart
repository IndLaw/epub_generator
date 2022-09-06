library epub_generator;

import 'dart:collection';

class PathNameService {
  String metaInfPathName = "META-INF";
  String epubPathName = "EPUB";
  String htmlPathName = "html";
  String imagePathName = "image";
  String cssPathName = "css";
  String jsPathName = "js";
  String packageOPFName = "package";
  String tocName = "toc";

  Map<String, String> resourcePathName = HashMap();

  PathNameService() {
    resourcePathName = {
      "html": htmlPathName,
      "jpeg": imagePathName,
      "jpg": imagePathName,
      "png": imagePathName,
      "css": cssPathName,
      "js": jsPathName
    };
  }

  String getPathName(String extension) {
    return resourcePathName[extension]
        .toString(); // this may or may not cause trouble trying to find value from key
  }
}
