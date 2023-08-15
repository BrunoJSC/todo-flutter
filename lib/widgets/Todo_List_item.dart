import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todolist/models/todo.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class TodoListItem extends StatelessWidget {
  const TodoListItem({super.key, required this.todo, required this.onDelete});

  final Todo todo;
  final Function(Todo) onDelete;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Slidable(
        actionPane: const SlidableStrechActionPane(),
        actionExtentRatio: 0.25,
        secondaryActions: [
          IconSlideAction(
            color: Colors.red,
            icon: Icons.delete,
            caption: 'Delete',
            onTap: () {
              onDelete(todo);
              print('Delete');
            },
          ),
          IconSlideAction(
            color: Colors.blue,
            icon: Icons.edit,
            caption: 'Editar',
            onTap: () {},
          )
        ],
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.grey[200],
          ),
          padding: const EdgeInsets.all(16),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            Text(
              DateFormat('dd/MM/yyyy - HH:mm').format(todo.date),
              style: const TextStyle(fontSize: 12),
            ),
            Text(
              todo.title,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ]),
        ),
      ),
    );
  }
}
