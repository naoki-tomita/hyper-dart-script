import 'dart:html';

Element h(String tag, Map<String, dynamic> attributes, List<dynamic> children) {
  final el = document.createElement(tag);
  attributes.forEach((key, value) {
    if (key.startsWith("on") && value is Function) {
      el.addEventListener(key.replaceAll("on", "").toLowerCase(), value);
    } else {
      el.attributes.addAll({ key: value });
    }
  });
  children.forEach((child) {
    if (child is String) {
      el.appendText(child);
    } else if (child is Component) {
      el.append(child.createHtml(el));
    } else if (child is Element) {
      el.append(child);
    }
  });
  return el;
}

class Component {
  Element parent;
  Element current;
  createHtml(Element parent) {
    this.parent = parent;
    current = render();
    return current;
  }
  Element render() => throw UnimplementedError();
  void onUpdate() => current.replaceWith(createHtml(parent));
}

void render(Component component, Element bindTo) {
  bindTo.append(component.createHtml(bindTo));
}

Element a(Map<String, dynamic> attr, List<dynamic> children) => h("a", attr, children);
Element h1(Map<String, dynamic> attr, List<dynamic> children) => h("h1", attr, children);
Element h2(Map<String, dynamic> attr, List<dynamic> children) => h("h2", attr, children);
Element h3(Map<String, dynamic> attr, List<dynamic> children) => h("h3", attr, children);
Element h4(Map<String, dynamic> attr, List<dynamic> children) => h("h4", attr, children);
Element h5(Map<String, dynamic> attr, List<dynamic> children) => h("h5", attr, children);
Element h6(Map<String, dynamic> attr, List<dynamic> children) => h("h6", attr, children);
Element ul(Map<String, dynamic> attr, List<dynamic> children) => h("ul", attr, children);
Element li(Map<String, dynamic> attr, List<dynamic> children) => h("li", attr, children);
Element div(Map<String, dynamic> attr, List<dynamic> children) => h("div", attr, children);
Element span(Map<String, dynamic> attr, List<dynamic> children) => h("span", attr, children);
Element input(Map<String, dynamic> attr, List<dynamic> children) => h("input", attr, children);
Element button(Map<String, dynamic> attr, List<dynamic> children) => h("button", attr, children);
Element textarea(Map<String, dynamic> attr, List<dynamic> children) => h("textarea", attr, children);
