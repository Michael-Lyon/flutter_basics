import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'package:todo/app/locator.dart';
import 'package:todo/models/todo.dart';
import 'package:todo/services/todos.service.dart';

class TodoScreenViewModel extends ReactiveViewModel {
  final _firstTodoFocusNode = FocusNode();
  final _todosService = locator<TodoService>();
  late final toggleStatus = _todosService.toggleStatus;
  late final removeTodo = _todosService.removeTodo;
  late final updateTodoContent = _todosService.updateTodoContent;

  List<Todo> get todos => _todosService.todos;

  void newTodo() {
    _todosService.newTodo();
    _firstTodoFocusNode.requestFocus();
  }

  FocusNode? getFocusNode(String id) {
    final index = todos.indexWhere((todo) => todo.id == id);
    return index == 0 ? _firstTodoFocusNode : null;
  }

  @override
  List<ListenableServiceMixin> get _listenableServices => [_todosService];
}
