library epub_generator;

import 'package:epub_generator/util/config_xml.dart';
import 'package:universal_html/html.dart' as web;
import 'package:epub_generator/service/media_type_service.dart';



class PackageOPF extends ConfigXML{
  late web.Document document;
  late web.Element rootPackage;
  late web.Element metadata;
  late web.Element manifest;
  late web.Element spine;



  /// No parameter construction method, incomplete label creation, lack of necessary id, language
  PackageOPF(){
    document = web.Document();
    //Initialize package tag attributes. Version, three namespaces.
    rootPackage = web.Element.tag("package", "http://www.idpf.org/2007/opf");
    rootPackage.setAttributeNS("http://purl.org/dc/elements/1.1/", "dc", "dc");
    rootPackage.setAttributeNS("http://purl.org/dc/terms/", "dcterms", "dcterms");
    rootPackage.setAttribute("version", 3.0);

    //Create a metadata tag
    metadata = web.Element.tag("metadata");
    //Create manifest tag
    manifest = web.Element.tag("manifest");
    //Create spine tag
    spine = web.Element.tag("spine");

    rootPackage.children.add(metadata);
    rootPackage.children.add(manifest);
    rootPackage.children.add(spine);

    document.append(rootPackage);

  }
   void addTOCItemToManifest(String href) {
    web.Element toc = addItemToManifestViaPackage("toc", href, MediaTypeService.getMediaTypeType("xhtml"));
    addAttribute(toc, "properties", "nav");
  }


   web.Element addItemToManifestViaPackage(String id, String href, String mediaType) {
    return addItemToManifest(manifest, id, href, mediaType);
  }

   void addItemRefToSpine(String id) {
    web.Element itemref = addTag(spine, "itemref", "" , {/* empty Map */});
    addAttribute(itemref, "idref", id);
  }

  /// set ID
  ///
  /// @param bookID
  /// @param pubID
  ///

   void setID(String bookID, String pubID) {
    addAttribute(rootPackage, "unique-identifier", bookID);
    web.Element identifier = addTag(metadata, "dc:identifier", pubID, {"id": bookID});
  }

   void setCoverImage(String ID, String href, String mediaType) {
    web.Element coverItem = addItemToManifest(manifest, ID, href, mediaType);
    addAttribute(coverItem, "properties", "cover-image");
  }

   void setBookTitle(String bookTitle) {
     //initialize title
    addTag(metadata, "dc:title", bookTitle, {/* empty Map */});
  }

   void setLanguage(String language) {
     //initialize language
    addTag(metadata, "dc:language", language, {/* empty Map */});
  }

   void setModifiedData(String modifiedData) {
    web.Element meta = addTag(metadata, "meta", modifiedData, {"property": "dcterms:modified"});
  }

   void setCreator(String creator) {
    addTag(metadata, "dc:creator", creator, {/* empty Map */});
  }

   void addContributor(String contributor) {
    addTag(metadata, "dc:contributor", contributor, {/* empty Map */});
  }

   void addRights(String rights) {
    addTag(metadata, "dc:rights", rights, {/* empty Map */});
  }

   void addData(String data) {
    addTag(metadata, "dc:data", data, {/* empty Map */});
  }


}