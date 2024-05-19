import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_list_project/item_model.dart';
import 'item_controller.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'GetX List Project',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    ItemListScreen(),
    PlaceholderScreen(),
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _showInfo() {
    Get.snackbar('Info', 'This is an info icon in the AppBar',
        snackPosition: SnackPosition.BOTTOM);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GetX List Project'),
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            icon: Icon(Icons.info_outline),
            onPressed: _showInfo,
          ),
        ],
      ),
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Items',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.white,
        onTap: _onItemTapped,
      ),
    );
  }
}

class ItemListScreen extends StatelessWidget {
  final ItemController itemController = Get.put(ItemController());
  final TextEditingController textController = TextEditingController();

  void _showUpdateDialog(BuildContext context, int index) {
    TextEditingController updateController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Update Item'),
          content: TextField(
            controller: updateController,
            decoration: InputDecoration(hintText: 'Enter new item name'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Get.back();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (updateController.text.isNotEmpty) {
                  itemController.items[index] = Item(updateController.text);
                }
                Get.back();
              },
              child: Text('Update'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Obx(() {
            return ListView.builder(
              itemCount: itemController.items.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(itemController.items[index].name),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit, color: Colors.blue),
                        onPressed: () {
                          _showUpdateDialog(context, index);
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          itemController.removeItem(index);
                        },
                      ),
                    ],
                  ),
                );
              },
            );
          }),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: textController,
                  decoration: InputDecoration(
                    labelText: 'Item Name',
                    labelStyle: TextStyle(color: Colors.blue),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                  ),
                ),
              ),
              IconButton(
                icon: Icon(Icons.add, color: Colors.blue),
                onPressed: () {
                  if (textController.text.isNotEmpty) {
                    itemController.addItem(textController.text);
                    textController.clear();
                  }
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class PlaceholderScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'This is the settings screen',
        style: TextStyle(color: Colors.blue, fontSize: 18),
      ),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'This is the profile screen',
        style: TextStyle(color: Colors.blue, fontSize: 18),
      ),
    );
  }
}
