library epub_generator;

// this file has a circular dependency with book_processor.dart
import 'package:epub_generator/service/time_service.dart';
import 'package:epub_generator/util/book_processor.dart';
import 'package:epub_generator/board/resource.dart';

import 'chapter.dart';

class Book {
  late final String bookTitle;
  late String creator;
  late String description;
  late String bookID;
  late String pubID;
  late String language;
  late String rights;
  late String modifiedData;
  late List<String> contributor;
  late Resource coverImage;

  late List<Chapter> chapterList;
  //Record the chapter name to prevent duplicate chapter names
  late List<String> chapterTitleList;

  late List<Resource> resourceList;
  //Record the resource ID to prevent duplicate IDs
  late List<String> resourceIDList;

  //BookProcessor processor;

  /// Basic initialization
  ///
  /// @param bookTitle
  /// @param bookID
  /// @param pubID
  /// @param language
  Book(this.bookTitle, this.bookID, this.pubID, this.language, this.modifiedData) {
    contributor = [];
    chapterList = [];
    resourceList = [];
    chapterTitleList = [];
    resourceIDList = [];
  }

  /// Default initialization method
  ///
  /// @param bookTitle
  Book.defaultBook(String bookTitle) {
    Book(bookTitle, "DefaultBookID", "DefaultPubID", "en", TimeService.getSystemUTCTime());
  }

   BookProcessor getProcessor(){
    return BookProcessor.noPath(this);
  }


  void addChapter(Chapter chapter) {
    String errMsg() => "Duplicate ChapterTitle: " + chapter.chapterTitle;
    if (chapterTitleList.contains(chapter.chapterTitle)) {
      print(errMsg());
      return;
    }
    chapterList.add(chapter);
    chapterTitleList.add(chapter.chapterTitle);
  }

  void addResource(Resource resource) {
    String errMsg() => "Duplicate ResourceID: " + resource.id;
    if (resourceIDList.contains(resource.id)) {
      print(errMsg());
      return;
    }
    resourceList.add(resource);
    resourceIDList.add(resource.id);
  }
}
