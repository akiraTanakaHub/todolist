import 'package:flutter/material.dart';
import 'package:todolist/constants/colors.dart';
import 'package:todolist/model/todo.dart';

class TodoItem extends StatefulWidget {
  const TodoItem({
    super.key,
    required this.todo,
    required this.handleDelete,
  });

  final Todo todo;
  final Function(String) handleDelete;

  @override
  State<TodoItem> createState() => _TodoItemState();
}

class _TodoItemState extends State<TodoItem> {
  void _onChange(bool? newValue) {
    setState(() {
      widget.todo.isDone = newValue!;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: ListTile(
        onTap: null,
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        leading:  Checkbox(
          onChanged: _onChange,
          value: widget.todo.isDone,
          side: MaterialStateBorderSide.resolveWith(
                (states) => const BorderSide(width: 2.0, color: Colors.deepPurple),
          ),
          activeColor: Colors.deepPurple,
        ),
        title: Text(
          widget.todo.todoText,
          style: TextStyle(
              fontSize: 16,
              color: tdBlack,
              decoration: widget.todo.isDone ? TextDecoration.lineThrough : null,
          ),
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete),
          onPressed: () => widget.handleDelete(widget.todo.id),
          style: ButtonStyle(
            iconColor: const MaterialStatePropertyAll<Color>(Colors.white),
            backgroundColor: const MaterialStatePropertyAll<Color>(tdRed),
            shape: MaterialStatePropertyAll<OutlinedBorder>(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(6))
            ),
          ),
        ),
      ),
    );
  }
}
