import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Food Tracker',
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Meal> _meals = [];

  void _addMeal(String name, int calories, File? image) {
    setState(() {
      _meals.add(ImageMeal(
          name: name, calories: calories, timestamp: DateTime.now(), image: image));
    });
    Navigator.pop(context); // Close the dialog
  }

  Future<void> _showAddMealDialog() async {
    String name = '';
    int calories = 0;
    File? image;

    final picker = ImagePicker();

    final imageSource = await showDialog<ImageSource>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add Meal'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: InputDecoration(labelText: 'Meal Name'),
                onChanged: (value) {
                  name = value;
                },
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Calories'),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  calories = int.tryParse(value) ?? 0;
                },
              ),
              ElevatedButton(
                onPressed: () => Navigator.pop(context, ImageSource.camera),
                child: Text('Capture from camera'),
              ),
              ElevatedButton(
                onPressed: () => Navigator.pop(context, ImageSource.gallery),
                child: Text('Select from gallery'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                _addMeal(name, calories,image);
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );

    if (imageSource != null) {
      final pickedFile = await picker.pickImage(source: imageSource);
      if (pickedFile != null) {
        image = File(pickedFile.path);
      }
    }

    // showDialog(
    //     context: context,
    //     builder: (BuildContext context) {
    //       return AlertDialog(
    //         title: Text('Add Meal'),
    //         content: Column(
    //           mainAxisSize: MainAxisSize.min,
    //           children: [
    //             TextField(
    //               decoration: InputDecoration(labelText: 'Meal Name'),
    //               onChanged: (value) {
    //                 name = value;
    //               },
    //             ),
    //             TextField(
    //               decoration: InputDecoration(labelText: 'Calories'),
    //               keyboardType: TextInputType.number,
    //               onChanged: (value) {
    //                 calories = int.tryParse(value) ?? 0;
    //               },
    //             ),
    //             SizedBox(height: 16.0),
    //             if (image != null) Image.file(image),
    //           ],
    //         ),
    //         actions: [
    //           TextButton(
    //             onPressed: () {
    //               Navigator.pop(context); // Close the dialog
    //             },
    //             child: Text('Cancel'),
    //           ),
    //           ElevatedButton(
    //             onPressed: () {
    //               _addMeal(name, calories, image);
    //             },
    //             child: Text('Add'),
    //           ),
    //         ],
    //       );
    //     });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Food Tracker'),
      ),
      body: ListView.builder(
        itemCount: _meals.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(_meals[index].name),
            subtitle: Text('${_meals[index].calories} calories'),
            trailing: Text(
              _meals[index].timestamp.toString(),
              style: TextStyle(fontSize: 12.0),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddMealDialog,
        child: Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Image.asset('assets/home_icon.png', width: 24, height: 24),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Image.asset('assets/tracking_icon.png', width: 24, height: 24),
            label: 'Tracking',
          ),
          BottomNavigationBarItem(
            icon: Image.asset('assets/friends_icon.png', width: 24, height: 24),
            label: 'Friends',
          ),
          BottomNavigationBarItem(
            icon: Image.asset('assets/more_icon.png', width: 24, height: 24),
            label: 'More',
          ),
        ],
        currentIndex: 0,
        selectedItemColor: Colors.blue,
        onTap: (index) {
          switch (index) {
            case 0:
            // Navigate to home page
              break;
            case 1:
            // Navigate to tracking page
              break;
            case 2:
            // Navigate to friends page
              break;
            case 3:
            // Navigate to more page
              break;
          }
        },
      ),
    );
  }
}

class Meal {
  final String name;
  final int calories;
  final DateTime timestamp;

  Meal({required this.name, required this.calories, required this.timestamp});
}
class ImageMeal extends Meal {
  final File? image;

  ImageMeal({
    required String name,
    required int calories,
    required DateTime timestamp,
    this.image,
  }) : super(name: name, calories: calories, timestamp: timestamp);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: image != null ? Image.file(image!) : null,
      title: Text(name),
      subtitle: Text('$calories calories'),
      trailing: Text(
        timestamp.toString(),
        style: TextStyle(fontSize: 12.0),
      ),
    );
  }
}




// Widget build(BuildContext context) {
//   return ListTile(
//     leading: image != null ? Image.file(image!) : null,
//     title: Text(name),
//     subtitle: Text('$calories calories'),
//     trailing: Text(
//       timestamp.toString(),
//       style: TextStyle(fontSize: 12.0),
//     ),
//   );
// }