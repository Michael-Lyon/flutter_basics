import 'dart:convert';
import 'dart:js_interop';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shopping_list/data/categories.dart';

import 'package:shopping_list/models/grocery_item.dart';
import 'package:shopping_list/widgets/new_item.dart';

class GroceryList extends StatefulWidget {
  const GroceryList({super.key});

  @override
  State<GroceryList> createState() => _GroceryListState();
}

class _GroceryListState extends State<GroceryList> {
  // how to get an infomation being passed from the screen on top of this one
  // final List<GroceryItem> _groceryItems = [...groceryItems];
  //
  List<GroceryItem> _groceryItems = [];
  var _isLoading = true;
  String? _error;

  void fetchGrocery() async {
    var url =  Uri.https('flutter-prep-d8e18-default-rtdb.firebaseio.com',
        '/shopping-list.json');
    final List<GroceryItem> loadedItems = [];

    var response = await http.get(url);

    if (response.statusCode == 200) {
      var responseData = json.decode(response.body);

      responseData.forEach((itemId, itemData) {
        final category = categories.entries
            .firstWhere(
                (catItem) => catItem.value.title == itemData['category'])
            .value;

        var fetchedItem = GroceryItem(
            id: itemId,
            name: itemData['name'],
            quantity: itemData['quantity'],
            category: category);

        loadedItems.add(fetchedItem);
      });
      _isLoading = false;
      setState(() {
        _groceryItems = loadedItems;
      });
    } else {
      _error = "Error loading data please try again";
      _isLoading = false;
    }
  }

  void _addItem() async {
    final newItem = await Navigator.of(context).push<GroceryItem>(
      MaterialPageRoute(
        builder: (ctx) => const NewItem(),
      ),
    );

    if (newItem == null) {
      return;
    }

    setState(() {
      _groceryItems.add(newItem);
    });
  }

  @override
  void initState() {
    super.initState();
    // fetchGrocery();
  }

  @override
  Widget build(BuildContext context) {
    Widget content = const Center(child: Text('No items added yet.'));

    if (_isLoading) {
      content = const Center(child: CircularProgressIndicator());
    }

    if (_groceryItems.isNotEmpty) {
      content = ListView.builder(
        itemCount: _groceryItems.length,
        itemBuilder: (context, index) => Dismissible(
          background:
              Container(color: Colors.red), // This line adds a red background
          key: ValueKey(_groceryItems[index].id),
          onDismissed: (direction) {
            setState(() {
              _groceryItems.remove(_groceryItems[index]);
            });
          },
          child: ListTile(
            title: Text(_groceryItems[index].name),
            leading: Container(
              width: 24,
              height: 24,
              color: _groceryItems[index].category.color,
            ),
            trailing: Text(
              _groceryItems[index].quantity.toString(),
            ),
          ),
        ),
      );
    }

    if (_error != null) {
      content = const Center(child: Text('Error loading data.'));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Grocery List"),
        actions: [
          IconButton(
            onPressed: () {
              _addItem();
            },
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: content,
    );
  }
}
