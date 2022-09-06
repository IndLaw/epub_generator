library epub_generator;

import 'dart:html' as dhtml;

import 'package:epub_generator/board/book.dart';
import 'package:epub_generator/board/chapter.dart';
import 'package:epub_generator/board/resource.dart';
import 'package:epub_generator/service/media_type_service.dart';
import 'package:epub_generator/service/path_name_service.dart';
import 'package:epub_generator/util/book_processor.dart';

import 'dart:io' as dio;

class EPUBWriter {
  late final String workSpace;
  late final BookProcessor bookProcessor;
  late Book book;
  late String bookSource;
  late String epubPath;
  late String metaInfPath;
  late String htmlPath;
  late String cssPath;
  late String imagePath;
  late String jsPath;
  late PathNameService pathNameService;

  EPUBWriter(this.workSpace, BookProcessor bookProcessor) {
    book = bookProcessor.book;
    this.bookProcessor = bookProcessor.process();
    initPath();
  }

  void write(){
    //move the cover





  }

  void moveResources(){


  }

  void makeDirs(){
    dio.Directory(metaInfPath);
    dio.Directory(htmlPath);
    dio.Directory(cssPath);
    dio.Directory(imagePath);
    dio.Directory(jsPath);
  }

  void initPath(){
    pathNameService = bookProcessor.pathNameService;
    bookSource = workSpace + "\\" + book.bookTitle;

    epubPath = bookSource + "\\" + pathNameService.epubPathName;
    metaInfPath = bookSource + "\\" + pathNameService.metaInfPathName;

    htmlPath = epubPath + "\\" + pathNameService.htmlPathName;
    cssPath = epubPath + "\\" + pathNameService.cssPathName;
    imagePath = epubPath + "\\" + pathNameService.imagePathName;
    jsPath = epubPath + "\\" + pathNameService.jsPathName;

  }

  void writeXML(String path, String name, dhtml.Document document){
    dio.File file = dio.File(path);

  }

}
