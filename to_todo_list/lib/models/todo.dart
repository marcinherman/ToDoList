class Todo {
  String? id;
  String? todoText;
  bool? isDone;

  Todo({
    required this.id,
    required this.todoText,
    this.isDone = false,
  });

  static List<Todo> todoList() {
    return [
      Todo(id: '01', todoText: 'Exercise', isDone: true),
      Todo(id: '02', todoText: 'Shopping', isDone: true),
      Todo(
        id: '03',
        todoText: 'Check Emails',
      ),
      Todo(
        id: '04',
        todoText: 'Meeting',
      ),
      Todo(id: '06', todoText: 'Work on mobile apps fot 2 hour'),
      Todo(
        id: '07',
        todoText: 'Dinner with Jenny',
      )
    ];
  }
}
