import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:river_practice/models/todo.dart';

const _todoList = [
  Todo(id: "A", description: "Simple Enough", completed: false),
  Todo(id: "B", description: "Learn Flutter", completed: false),
  Todo(id: "C", description: "Walk the dog", completed: true),
  Todo(id: "D", description: "Buy groceries", completed: false),
  Todo(id: "E", description: "Read a book", completed: true),
];


// The StateNotifier class that will be passed to our StateNotifierProvider.
// The class should not expose satte outside ot it's "state" property, which means
//  no public getters/properties
// The public methods on this class will be what will allow the UI to modify the state.

class TodosNotifier extends StateNotifier<List<Todo>> {
  TodosNotifier() : super(_todoList);

  // Add todos
  void addTodos(Todo todo) {
    // since the state is immutable we cant to state.add so we create a new
    //list with the new state and add it to the list.
    state = [...state, todo];
  }

  void removeTodos(String todoId) {
    state = [
      for (final todo in state)
        if (todo.id != todoId) todo,
    ];
  }

  // mark a todo as done
  void toggle(String todoId) {
    state = [
      for (final todo in state)
        // we're marking only the matching todo as completed
        if (todo.id == todoId)
          // Once more, since our state is immutable, we need to make a copy
          // of the todo. We're using our `copyWith` method implemented before
          // to help with that.
          todo.copyWith(completed: !todo.completed)
        else
          // other todos are not modified
          todo,
    ];
  }
}

// Finally, we are using StateNotifierProvider to allow the UI to interact with
// our TodosNotifier class.
final todosProvider = StateNotifierProvider<TodosNotifier, List<Todo>>((ref) {
  return TodosNotifier();
});
