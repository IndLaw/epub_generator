library epub_generator;

// this file has a circular dependency with book.dart

import 'package:epub_generator/board/book.dart';
import 'package:epub_generator/board/chapter.dart';
import 'package:epub_generator/board/resource.dart';
import 'package:epub_generator/service/media_type_service.dart';
import 'package:epub_generator/service/path_name_service.dart';
import 'package:epub_generator/util/package_opf.dart';
import 'package:epub_generator/util/string_util.dart';
import 'package:epub_generator/util/toc.dart';

class BookProcessor {
  late final Book book;
  late final PathNameService pathNameService;
  late PackageOPF packageOPF;
  late TOC toc;

  BookProcessor(this.book, this.pathNameService) {
    packageOPF = PackageOPF();
    toc = TOC();
  }

  BookProcessor.noPath(Book book) {
    BookProcessor(book, PathNameService());
  }

  BookProcessor process() {
    packageOPF.setID(book.bookID, book.pubID);
    packageOPF.addTOCItemToManifest(pathNameService.tocName + ".xhtml");
    packageOPF.setBookTitle(book.bookTitle);
    packageOPF.setLanguage(book.language);
    setCoverImage(book.coverImage);
    processChapterList(book.chapterList);
    processResources(book.resourceList);

    return this;
  }

  void processChapterList(List<Chapter> chapterList) {
    for (Chapter c in chapterList) {
      String extension = StringUtil.getFileExtension(c.htmlFile.uri.pathSegments.last);
      String errMsg() => "Chapter file can only be XHTML file:" + extension;
      if (extension != "xhtml") {
        print(errMsg());
        return;
      }
      String href = pathNameService.htmlPathName + "/" + c.chapterID;
      packageOPF.addItemToManifestViaPackage(
          c.chapterID, href, MediaTypeService.getMediaTypeType("xhtml"));
      packageOPF.addItemRefToSpine(c.chapterID);
      toc.addDefaultLi(href, c.chapterTitle);
    }
  }

  void setCoverImage(Resource coverImage) {
    String errMsg() => "Cover Image must be a image type.(jpg,jpeg or png)";
    if (!MediaTypeService.isImage(coverImage)) {
      print(errMsg());
    }
    packageOPF.setCoverImage(
        coverImage.id, pathNameService.imagePathName + "/" + coverImage.id, coverImage.mediaType);
  }

  void processResources(List<Resource> resourceList) {
    for (Resource r in resourceList) {
      packageOPF.addItemToManifestViaPackage(
          r.id, pathNameService.getPathName(r.extension + "/" + r.id), r.mediaType);
    }
  }

  String getContainerXML() {
    return "<?xml version=\"1.0\" encoding=\"utf-8\" standalone=\"no\"?>\n" +
        "<container xmlns=\"urn:oasis:names:tc:opendocument:xmlns:container\" version=\"1.0\">\n" +
        "\t<rootfiles>\n" +
        "\t\t<rootfile full-path=\"" +
        pathNameService.epubPathName +
        "/" +
        pathNameService.packageOPFName +
        ".opf\" media-type=\"application/oebps-package+xml\"/>\n" +
        "\t</rootfiles>\n" +
        "</container>";
  }
}
