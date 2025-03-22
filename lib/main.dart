import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // Root of the application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Shopping List', home: ShoppingListPage());
  }
}

// Model for a shopping item. Note: title is now mutable.
class ShoppingItem {
  String title;
  bool isBought;
  int id;

  ShoppingItem({required this.title, this.isBought = false, this.id = 0});
}

class ShoppingListPage extends StatefulWidget {
  @override
  _ShoppingListPageState createState() => _ShoppingListPageState();
}

class _ShoppingListPageState extends State<ShoppingListPage> {
  // Mutable category names.
  String bakeryCategoryName = 'Bakery';
  String dairyCategoryName = 'Dairy';
  String snacksCategoryName = 'Snacks';

  // Category lists.
  List<ShoppingItem> bakeryItems = [
    ShoppingItem(title: 'Bread', isBought: false, id: 1),
    ShoppingItem(title: 'Croissant', isBought: false, id: 2),
    ShoppingItem(title: 'Bagel', isBought: false, id: 3),
  ];

  List<ShoppingItem> dairyItems = [
    ShoppingItem(title: 'Milk', isBought: false, id: 4),
    ShoppingItem(title: 'Cheese', isBought: false, id: 5),
    ShoppingItem(title: 'Yogurt', isBought: false, id: 6),
  ];

  List<ShoppingItem> snacksItems = [
    ShoppingItem(title: 'Chips', isBought: false, id: 7),
    ShoppingItem(title: 'Cookies', isBought: false, id: 8),
    ShoppingItem(title: 'Candy', isBought: false, id: 9),
  ];

  // Toggle the item's bought status and reposition it within its category.
  void _toggleItem(List<ShoppingItem> items, int index) {
    setState(() {
      if (!items[index].isBought) {
        items[index].isBought = true;
        final item = items.removeAt(index);
        items.add(item);
      } else {
        items[index].isBought = false;
        final item = items.removeAt(index);
        items.insert(0, item);
      }
    });
  }

  // Open a dialog to edit the item's title.
  void _editItem(List<ShoppingItem> items, int index) {
    final controller = TextEditingController(text: items[index].title);
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Edit Item"),
          content: TextField(
            controller: controller,
            autofocus: true,
            decoration: const InputDecoration(hintText: "Enter new title"),
          ),
          actions: [
            TextButton(
              child: const Text("Cancel"),
              onPressed: () => Navigator.pop(context),
            ),
            TextButton(
              child: const Text("Save"),
              onPressed: () {
                setState(() {
                  items[index].title = controller.text;
                });
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  // Open a dialog to edit a category name.
  void _editCategory(String currentName, Function(String) onUpdate) {
    final controller = TextEditingController(text: currentName);
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Edit Category"),
          content: TextField(
            controller: controller,
            autofocus: true,
            decoration: const InputDecoration(
              hintText: "Enter new category name",
            ),
          ),
          actions: [
            TextButton(
              child: const Text("Cancel"),
              onPressed: () => Navigator.pop(context),
            ),
            TextButton(
              child: const Text("Save"),
              onPressed: () {
                setState(() {
                  onUpdate(controller.text);
                });
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  // Build a category section with a header (with edit icon) and list items.
  Widget _buildCategorySection(
    String categoryName,
    List<ShoppingItem> items,
    Function(String) onUpdateCategory,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Category header with an edit icon.
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                categoryName,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () => _editCategory(categoryName, onUpdateCategory),
              ),
            ],
          ),
        ),
        // List of items for this category.
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: items.length,
          itemBuilder: (context, index) {
            final item = items[index];
            return ListTile(
              title: Text(
                item.title,
                style: TextStyle(
                  decoration:
                      item.isBought
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                ),
              ),
              // Tapping the ListTile toggles the item's bought state.
              onTap: () => _toggleItem(items, index),
              // Pencil icon for editing the item.
              trailing: IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () => _editItem(items, index),
              ),
            );
          },
        ),
        const Divider(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Shopping List')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildCategorySection(bakeryCategoryName, bakeryItems, (newName) {
              bakeryCategoryName = newName;
            }),
            _buildCategorySection(dairyCategoryName, dairyItems, (newName) {
              dairyCategoryName = newName;
            }),
            _buildCategorySection(snacksCategoryName, snacksItems, (newName) {
              snacksCategoryName = newName;
            }),
          ],
        ),
      ),
    );
  }
}
