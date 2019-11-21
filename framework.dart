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

Element div(Map<String, dynamic> a, List<dynamic> c) => h("div", a, c);
Element a(Map<String, dynamic> a, List<dynamic> c) => h("a", a, c);
Element span(Map<String, dynamic> a, List<dynamic> c) => h("span", a, c);
Element h1(Map<String, dynamic> a, List<dynamic> c) => h("h1", a, c);
Element h2(Map<String, dynamic> a, List<dynamic> c) => h("h2", a, c);
Element h3(Map<String, dynamic> a, List<dynamic> c) => h("h3", a, c);
Element h4(Map<String, dynamic> a, List<dynamic> c) => h("h4", a, c);
Element h5(Map<String, dynamic> a, List<dynamic> c) => h("h5", a, c);
Element h6(Map<String, dynamic> a, List<dynamic> c) => h("h6", a, c);
Element ul(Map<String, dynamic> a, List<dynamic> c) => h("ul", a, c);
Element li(Map<String, dynamic> a, List<dynamic> c) => h("li", a, c);
Element input(Map<String, dynamic> a, List<dynamic> c) => h("input", a, c);
Element textarea(Map<String, dynamic> a, List<dynamic> c) => h("textarea", a, c);
Element button(Map<String, dynamic> a, List<dynamic> c) => h("button", a, c);
