import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Amplify CRUD',
      theme: ThemeData(visualDensity: VisualDensity.adaptivePlatformDensity),
      home: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // CREATE
          FlatButton(
              onPressed: () => create(),
              child: Text('Create'),
              color: Colors.green,
              textColor: Colors.white),

          // READ ALL
          FlatButton(
              onPressed: () => readAll(),
              child: Text('Read ALL'),
              color: Colors.blue,
              textColor: Colors.white),

          // READ BY ID
          FlatButton(
              onPressed: () => readById(),
              child: Text('Read BY ID'),
              color: Colors.cyan,
              textColor: Colors.white),

          // UPDATE
          FlatButton(
              onPressed: () => update(),
              child: Text('Update'),
              color: Colors.orange,
              textColor: Colors.white),

          // DELETE
          FlatButton(
              onPressed: () => delete(),
              child: Text('Delete'),
              color: Colors.red,
              textColor: Colors.white),
        ],
      ),
    );
  }

  void create() {}

  void readAll() {}

  void readById() {}

  void update() {}

  void delete() {}
}
