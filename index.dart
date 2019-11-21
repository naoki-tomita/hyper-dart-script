
import 'dart:html';
import 'framework.dart';

void main() {
  render(AppComponent(), document.getElementById("app"));
}

class AppComponent extends Component {
  String description = "";
  TodoEntities entities = TodoEntities([]);
  Element render() {
    return div({ "class": "app" }, [
      h1({}, ["Todo app"]),
      TodoComponent(entities),
      DescriptionInputComponent(text: description, onChange: (text) {
        this.description = text;
        onUpdate();
      }),
      button({
        "onClick": (e) {
          entities.add(TodoEntity(description, false));
          description = "";
          onUpdate();
        }
      }, ["add"])
    ]);
  }
}

class FCC<T> {
  final List<T> values;
  FCC(this.values);
  List<E> mapWithIndex<E>(E f(int index, T e)) {
    final List<E> dst = [];
    values.asMap().forEach((i, x) => dst.add(f(i, x)));
    return dst;
  }
  void add(T el) => values.add(el);
}

class TodoEntities extends FCC<TodoEntity> {
  TodoEntities(List<TodoEntity> values) : super(values);
  void setDone(int index, bool done) {
    values[index].done = done;
  }
}

class TodoEntity {
  String description;
  bool done;
  TodoEntity(this.description, this.done);
}

class TodoComponent extends Component {
  final TodoEntities todos;
  TodoComponent(this.todos);
  Element render() {
    return ul({ "class": "todo-list" },
      todos.mapWithIndex((index, todo) => TodoItemComponent(todo, (done) {
        todos.setDone(index, done);
        onUpdate();
      })).toList()
    );
  }
}

typedef void OnDoneChange(bool done);

class TodoItemComponent extends Component {
  final TodoEntity todo;
  final OnDoneChange onDoneChange;
  TodoItemComponent(this.todo, this.onDoneChange);
  Element render() {
    final attr = <String, dynamic>{
      "type": "checkbox",
      "onChange": (e) => onDoneChange(e.target.checked)
    };
    if (todo.done) {
      attr.addAll({ "checked": "checked" });
    }
    return li({ "class": "todo-item" }, [
      todo.description,
      input(attr, [])
    ]);
  }
}

typedef void OnInputTextChange(String);

class DescriptionInputComponent extends Component {
  final OnInputTextChange onChange;
  final String text;
  DescriptionInputComponent({ this.text, this.onChange });
  Element render() {
    return input({
      "onChange": (e) => onChange(e.target.value),
      "value": text
    }, []);
  }
}
