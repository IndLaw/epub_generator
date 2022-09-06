library epub_generator;

import 'dart:io';

class Chapter {
  String chapterTitle;
  File htmlFile;
  String chapterID = "";
  List<Chapter> chapterList = [];

  Chapter(this.chapterTitle, this.htmlFile) {
    chapterID = htmlFile.uri.pathSegments.last;
  }

  Chapter addChapter(Chapter chapter) {
    chapterList.add(chapter);
    return this;
  }
}
