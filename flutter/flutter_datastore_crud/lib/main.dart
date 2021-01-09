import 'package:flutter/material.dart';
import 'amplifyconfiguration.dart';
import 'models/ModelProvider.dart';
import 'models/SexyObject.dart';
import 'package:amplify_core/amplify_core.dart';
import 'package:amplify_datastore/amplify_datastore.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _amplify = Amplify();

  final _sexyId = "sexy";

  @override
  void initState() {
    super.initState();
    _configureAmplify();
  }

  void _configureAmplify() {
    final provider = ModelProvider();
    final dataStorePlugin = AmplifyDataStore(modelProvider: provider);

    _amplify.addPlugin(dataStorePlugins: [dataStorePlugin]);
    _amplify.configure(amplifyconfig);

    print('Amplify configured');
  }

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

  void create() async {
    final sexyObject = SexyObject(
        id: _sexyId, value: "Dont you wish your object was hot like me?");

    try {
      await Amplify.DataStore.save(sexyObject);

      print('Saved ${sexyObject.toString()}');
    } catch (e) {
      print(e);
    }
  }

  void readAll() async {
    try {
      final sexyObjects = await Amplify.DataStore.query(SexyObject.classType);

      print(sexyObjects.toString());
    } catch (e) {
      print(e);
    }
  }

  Future<SexyObject> readById() async {
    try {
      final sexyObjects = await Amplify.DataStore.query(SexyObject.classType,
          where: SexyObject.ID.eq(_sexyId));

      if (sexyObjects.isEmpty) {
        print("No objects with ID: $_sexyId");
        return null;
      }

      final sexyObject = sexyObjects.first;

      print(sexyObject.toString());

      return sexyObject;
    } catch (e) {
      print(e);
      throw e;
    }
  }

  void update() async {
    try {
      final sexyObject = await readById();

      final updatedObject =
          sexyObject.copyWith(value: sexyObject.value + ' [UPDATED]');

      await Amplify.DataStore.save(updatedObject);

      print('Updated object to ${updatedObject.toString()}');
    } catch (e) {
      print(e);
    }
  }

  void delete() async {
    try {
      final myObject = await readById();

      await Amplify.DataStore.delete(myObject);

      print('Deleted object with ID: ${myObject.id}');
    } catch (e) {
      print(e);
    }
  }
}
