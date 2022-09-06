library epub_generator;

import 'package:universal_html/html.dart' as web;
import 'package:epub_generator/util/config_XML.dart';

class TOC extends ConfigXML {
  late web.Document _document;
  late web.Element _rootHtml;
  late web.Element _body;
  late web.Element _head; // may need to add in charset child if not done in a later file
  late web.Element _nav;
  late web.Element _rootOl;

  TOC() {
    _document = web.Document();

    _rootHtml = web.Element.tag("html", "http://www.w3.org/1999/xhtml");
    _rootHtml.setAttributeNS("http://www.idpf.org/2007/ops", "epub", "epub");

    _head = web.Element.tag("head");
    _head.children.add(web.Element.tag("title"));
    _head.children.first.text = "title";

    _body = web.Element.tag("body");
    _nav = web.Element.tag("nav");
    _nav.attributes = {"epub:type": "toc"};
    _nav.id = "toc";
    _rootOl = web.Element.tag("ol");
    _rootOl.id = "ol";
    _nav.children.add(_rootOl);
    _body.children.add(_nav);

    _rootHtml.children.add(_head);
    _rootHtml.children.add(_body);

    _document.append(_rootHtml);
  }

  void addDefaultLi(String href, String title) {
    web.Element li = web.Element.tag("li");
    web.Element a = addTag(li, "a", title, {/* empty Map */});

    a.attributes = {"href": href};
    _document.getElementById("ol")!.children.add(li);
  }
}
