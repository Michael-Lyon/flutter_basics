import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'package:todo/ui/todos_screen/todos_screen_viewmodel.dart';

class TodoScreenView extends StatelessWidget {
  const TodoScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<TodoScreenViewModel>.reactive(
      viewModelBuilder: () => TodoScreenViewModel(),
      builder: (context, model, _) => Scaffold(
        appBar: AppBar(
          title: const Text("Flutter StaOkayycked Practice Todo"),
        ),
        body: ListView(
          padding: const EdgeInsets.symmetric(vertical: 16),
          children: [
            if (model.todos.isEmpty)
              const Opacity(
                  opacity: 0.5,
                  child: Column(children: [
                    SizedBox(
                      height: 64,
                    ),
                    Icon(Icons.emoji_food_beverage_outlined, size: 48),
                    SizedBox(
                      height: 16,
                    ),
                    Text("No todos yet. Click + to add a new one")
                  ])),
            ...model.todos.map((todo) {
              return ListTile(
                leading: IconButton(
                  icon: Icon(
                      todo.completed ? Icons.task_alt : Icons.circle_outlined),
                  onPressed: () => model.toggleStatus(todo.id),
                ),
                title: TextField(
                  controller: TextEditingController(text: todo.content),
                  decoration: null,
                  focusNode: model.getFocusNode(todo.id),
                  maxLines: null,
                  onChanged: (text) => model.updateTodoContent(todo.id, text),
                  style: TextStyle(
                      fontSize: 20,
                      decoration:
                          todo.completed ? TextDecoration.lineThrough : null),
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.horizontal_rule),
                  onPressed: () => model.removeTodo(todo.id),
                ),
              );
            }),
          ],
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: model.newTodo, child: const Icon(Icons.add)),
      ),
    );
  }
}
