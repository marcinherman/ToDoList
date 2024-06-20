class ToDo {
  String id;
  String todoText;
  bool isDone;

  ToDo({
    required this.id,
    required this.todoText,
    this.isDone = false,
  });

  static List<ToDo> todoList() {
    return [
      ToDo(id: '01', todoText: 'Exercise', isDone: true),
      ToDo(id: '02', todoText: 'Shopping', isDone: true),
      ToDo(
        id: '03',
        todoText: 'Check Emails',
      ),
      ToDo(
        id: '04',
        todoText: 'Meeting',
      ),
      ToDo(id: '06', todoText: 'Work on mobile apps fot 2 hour'),
      ToDo(
        id: '07',
        todoText: 'Dinner with Jenny',
      )
    ];
  }
}
