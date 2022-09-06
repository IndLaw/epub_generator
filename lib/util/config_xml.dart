library epub_generator;

import 'package:universal_html/html.dart' as web;
import 'package:flutter/cupertino.dart';

abstract class ConfigXML {
  /*
  /// Add complete tags to Element.
  */
  /// @param element Element to be processed
  /// @param tag tag name
  /// @param text tag content
  /// @param attrs attribute name and attribute value
  /// @return element
  //
  @protected
  web.Element addTag(web.Element element, String tag, String text, Map<String, String> attrs) {
    web.Element resultElement = element;
    resultElement.appendHtml(tag);
    resultElement.appendText(text);
    for (MapEntry<String, String> attr in attrs.entries) {
      resultElement.setAttribute(attr.key, attr.value);
    }
    return resultElement;
  }

  // possibly not used -> nvm it's used in pack_opf somewhat
  web.Element addAttribute(web.Element element, String name, String value) {
    element.setAttribute(name, value);
    return element;
  }

/*
 * Add the most basic item tag to the manifest tag
 */
  /// @param manifest manifest
  /// @param id id
  /// @param href relative to the path of package.opf, such as html/chapter1.html
  /// @param mediaType resource type, see {@link com.epub_generator.service.MediaTypeService} for details
  //
  @protected
  web.Element addItemToManifest(web.Element manifest, String id, String href, String mediaType) {
    Map<String, String> attrs = {"id": id, "href": href, "media-type": mediaType};
    return addTag(manifest, "item", "", attrs);
  }
}
