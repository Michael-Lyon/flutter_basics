import 'package:flutter/material.dart';

@immutable
class Todo {
  const Todo({
    required this.id,
    required this.description,
    required this.completed,
  });

  //  ALL PROPERTIES SHOULD BE FIANL
  final String id;
  final String description;
  final bool completed;

  // Implement a method that allows cloning the Todo with different content
  Todo copyWith({String? id, String? description, bool? completed}){
    return Todo(
      id: id ?? this.id,
      description: description ?? this.description,
      completed: completed ?? this.completed,
    );
  }
}
