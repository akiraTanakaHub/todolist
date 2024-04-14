import 'package:flutter/material.dart';
import 'package:todolist/constants/colors.dart';
import 'package:uuid/uuid.dart';
import '../model/todo.dart';
import '../widgets/todo_item.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Todo> todoList = Todo.todoList();
  List<Todo> _foundTodo = [];
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    _foundTodo = todoList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tdBGColor,
      appBar: _buildAppBar(),
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 15,
            ),
            child: Column(
              children: [
                searchBar(),
                Container(
                  alignment: Alignment.topLeft,
                  margin: const EdgeInsets.symmetric(vertical: 20),
                  child: const Text(
                    'All ToDos',
                    style: TextStyle(
                      color: tdBlack,
                      fontSize: 31,
                    ),
                  ),
                ),
                Expanded(
                  child: ListView(
                    children: [
                      for (Todo todo in _foundTodo.reversed)
                        TodoItem(todo: todo, handleDelete: _handleDelete),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    margin:
                        const EdgeInsets.only(bottom: 30, right: 20, left: 20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: const <BoxShadow>[
                        BoxShadow(
                          color: Colors.grey,
                          offset: Offset(0.0, 0.0),
                          blurRadius: 10.0,
                          spreadRadius: 0.0,
                        ),
                      ],
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: TextField(
                      controller: _controller,
                      decoration: const InputDecoration(
                        hintText: 'Add new todo item',
                        border: InputBorder.none,
                      ),
                      onChanged: null,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 30, right: 20),
                  child: ElevatedButton(
                    onPressed: () => _addTodoItem(context),
                    style: ButtonStyle(
                      backgroundColor:
                          const MaterialStatePropertyAll<Color>(tdBlue),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      minimumSize:
                          const MaterialStatePropertyAll<Size>(Size(60, 60)),
                      elevation: const MaterialStatePropertyAll<double>(10.0),
                    ),
                    child: const Text('+',
                        style: TextStyle(fontSize: 40, color: Colors.white)),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: tdBGColor,
      elevation: 0,
      leading: const IconButton(
        icon: Icon(Icons.menu, color: tdBlack, size: 30),
        onPressed: null,
      ),
      title: const Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          CircleAvatar(
            backgroundImage: AssetImage('assets/images/avatar.jpeg'),
          ),
        ],
      ),
    );
  }

  Widget searchBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextField(
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.all(0),
          prefixIcon: Icon(Icons.search, color: tdBlack, size: 20),
          prefixIconConstraints: BoxConstraints(
            maxHeight: 20,
            minWidth: 25,
          ),
          border: InputBorder.none,
          hintText: 'Search',
          hintStyle: TextStyle(color: tdGray),
        ),
        onChanged: (value) => _runFilter(value),
      ),
    );
  }

  void _runFilter(String enteredKeyword) {
    List<Todo> result = [];
    if (enteredKeyword.isEmpty) {
      result = todoList;
    } else {
      result = todoList
          .where((item) => item.todoText
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase()))
          .toList();
    }

    setState(() {
      _foundTodo = result;
    });
  }

  void _handleDelete(String id) {
    setState(() {
      todoList.removeWhere((todo) => todo.id == id);
    });
    _foundTodo = todoList;
  }

  void _addTodoItem(BuildContext context) {
    var uuid = const Uuid();
    if (_controller.text.isEmpty) {
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Todo text should not be empty'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'OK'),
              child: const Text('OK'),
            ),
          ],
        ),
      );
      return;
    }
    setState(() {
      todoList
          .add(Todo(id: uuid.v1(), todoText: _controller.text, isDone: false));
    });
    _controller.clear();
  }
}
