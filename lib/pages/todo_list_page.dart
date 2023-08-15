import 'package:flutter/material.dart';
import 'package:todolist/models/todo.dart';
import 'package:todolist/widgets/Todo_List_item.dart';

class TodoListPage extends StatefulWidget {
  const TodoListPage({super.key});

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  List<Todo> todos = [];
  Todo? deletedTodo;
  int? deletedTodoPos;

  final TextEditingController todoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: TextField(
                      controller: todoController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Adicionar uma tarefa',
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        String text = todoController.text;
                        setState(
                          () {
                            Todo newTodo =
                                new Todo(title: text, date: DateTime.now());
                            todos.add(newTodo);
                          },
                        );
                        todoController.clear();
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF00d7f3),
                          padding: const EdgeInsets.all(16)),
                      child: const Icon(
                        Icons.add,
                        size: 30,
                        color: Colors.white,
                      )),
                ],
              ),
              const SizedBox(
                height: 18,
              ),
              Flexible(
                child: ListView(shrinkWrap: true, children: [
                  for (Todo todo in todos)
                    TodoListItem(
                      todo: todo,
                      onDelete: onDelete,
                    ),
                ]),
              ),
              const SizedBox(
                height: 18,
              ),
              Row(
                children: [
                  Expanded(child: Text('Voce possui ${todos.length} tarefas')),
                  const SizedBox(
                    width: 8,
                  ),
                  ElevatedButton(
                      onPressed: showDeleteTodosConfirmationDialog,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF00d7f3),
                        padding: const EdgeInsets.all(14),
                      ),
                      child: Text('Limpar tudo'))
                ],
              )
            ],
          ),
        ),
      )),
    );
  }

  void onDelete(Todo todo) {
    deletedTodo = todo;
    deletedTodoPos = todos.indexOf(todo); // index

    setState(() {
      todos.remove(todo);
    });

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        '${todo.title} foi removido',
        style: const TextStyle(
          color: Color(0xff060708),
        ),
      ),
      backgroundColor: Colors.white,
      action: SnackBarAction(
          label: 'Desfazer',
          textColor: const Color(0xFF00d7f3),
          onPressed: () {
            setState(() {
              todos.insert(deletedTodoPos!, deletedTodo!);
            });
          }),
      duration: const Duration(seconds: 2),
    ));
  }

  void showDeleteTodosConfirmationDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Limpar tudo'),
        content: const Text('Tem certeza?'),
        actions: [
          TextButton(
            child: Text('Cancelar'),
            onPressed: () {
              Navigator.of(context).pop();
            },
            style: TextButton.styleFrom(
              backgroundColor: const Color(0xFF00d7f3),
            ),
          ),
          TextButton(
              child: Text('Limpar', style: TextStyle(color: Colors.white)),
              onPressed: () {
                Navigator.of(context).pop();
                deletedAllTodos();
              },
              style: TextButton.styleFrom(
                backgroundColor: Colors.red,
              ))
        ],
      ),
    );
  }

  deletedAllTodos() {
    setState(() {
      todos.clear();
    });
  }
}
