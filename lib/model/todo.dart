
class Todo {
  String id;
  String todoText;
  bool isDone;

  Todo({
    required this.id,
    required this.todoText,
    this.isDone = false,
  });

  static List<Todo> todoList() {
    return [
      Todo(id: '1', todoText: 'Morning Exercises', isDone: true),
      Todo(id: '2', todoText: 'Buy Groceries', isDone: true),
      Todo(id: '3', todoText: 'Check emails'),
      Todo(id: '4', todoText: 'Working on mobile app for 4 hours'),
    ];
  }

  void showInfo() {
    print('$id: $todoText is $isDone');
  }
}