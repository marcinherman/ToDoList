import 'package:flutter/material.dart';
import 'package:to_todo_list/constants/colors.dart';
import 'package:to_todo_list/domain/entity/todo.dart';
import 'package:to_todo_list/presentation/home/widget/todo_item.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final todosList = ToDo.todoList();
  List<ToDo> _foundToDo = [];
  final _todoController = TextEditingController();
  final _scrollController = ScrollController();

  @override
  void initState() {
    _foundToDo = todosList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: tdBGColor,
        appBar: _buildAppBar(),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                _buildSearchBox(),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildListHeader(context),
                      Expanded(
                        child: Material(
                          color: tdBGColor,
                          child: ListView.separated(
                            shrinkWrap: true,
                            controller: _scrollController,
                            itemCount: _foundToDo.length,
                            separatorBuilder: (context, index) {
                              return const SizedBox(height: 10);
                            },
                            itemBuilder: (context, index) {
                              return TodoItem(
                                todo: _foundToDo[index],
                                onToDoChanged: _handleToDoChange,
                                onDeleteItem: _deleteToDoItem,
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                _buildNewItemInput(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _handleToDoChange(ToDo todo) {
    setState(() {
      todo.isDone = !todo.isDone;
    });
  }

  void _deleteToDoItem(String id) {
    setState(() {
      todosList.removeWhere((item) => item.id == id);
    });
  }

  void _addToDoItem(String toDo) {
    if (toDo.trim().isEmpty) return;

    setState(() {
      todosList.add(ToDo(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        todoText: toDo,
      ));
    });
    _todoController.clear();
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeIn,
    );
  }

  void _runFilter(String enteredKeyword) {
    List<ToDo> results = [];
    if (enteredKeyword.isEmpty) {
      results = todosList;
    } else {
      results = todosList
          .where((item) => item.todoText
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase()))
          .toList();
    }
    setState(() {
      _foundToDo = results;
    });
  }

  Widget _buildSearchBox() {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextField(
        onChanged: (value) => _runFilter(value),
        decoration: const InputDecoration(
            prefixIcon: Padding(
              padding: EdgeInsets.only(
                left: 10,
                right: 10,
              ),
              child: Icon(
                Icons.search,
                color: tdBlack,
                size: 20,
              ),
            ),
            prefixIconConstraints: BoxConstraints(
              maxHeight: 20,
              maxWidth: 35,
            ),
            border: InputBorder.none,
            hintText: "Search",
            hintStyle: TextStyle(color: tdGrey),
            contentPadding: EdgeInsets.only(left: 20)),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: tdBGColor,
      elevation: 0,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Icon(
            Icons.menu,
            color: tdBlack,
            size: 30,
          ),
          SizedBox(
            height: 40,
            width: 40,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset('assets/images/lion2.jpeg'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNewItemInput(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: const [
                BoxShadow(
                  color: Colors.grey,
                  offset: Offset(0.0, 0.0),
                  blurRadius: 10.0,
                  spreadRadius: 0.0,
                ),
              ],
            ),
            child: TextField(
              controller: _todoController,
              decoration: const InputDecoration(
                hintText: 'Add a new todo Item',
                contentPadding: EdgeInsets.only(
                  left: 20.0,
                ),
                border: InputBorder.none,
              ),
            ),
          ),
        ),
        const SizedBox(width: 8),
        ElevatedButton(
          onPressed: () => _addToDoItem(_todoController.text),
          style: ElevatedButton.styleFrom(
            backgroundColor: tdBlue,
            minimumSize: const Size(60, 60),
            elevation: 10,
          ),
          child: const Text(
            '+',
            style: TextStyle(
              fontSize: 40,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildListHeader(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(
        top: 50,
        bottom: 20,
      ),
      child: Text(
        'All Todos',
        style: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
