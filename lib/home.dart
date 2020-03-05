import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController _txtController = TextEditingController();

  List _taskList = [];

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> _getFile() async {
    final path = await _localPath;
    return File('$path//dados.json');

//
//    Directory directory = await getApplicationDocumentsDirectory();
//
//    return File( "${directory.path}/dados.json" );
  }

  _saveFile() async {
    var file = await _getFile();
    String data = json.encode(_taskList);
    file.writeAsString(data);
  }

  _addtask() async {
    String typedText = _txtController.text;

    Map<String, dynamic> task = Map();
    task["title"] = typedText;
    task["done"] = false;

    setState(() {
      _taskList.add(task);
    });

    _txtController.clear();

    this._saveFile();
  }

  _readFile() async {
    try {
      final file = await _getFile();
      return file.readAsString();
    } catch (e) {
      print('erro: ' + e.toString());
      return null;
    }
  }

  @override
  void initState() {
    super.initState();

    _saveFile();

    this._readFile().then((data) {
      setState(() {
        _taskList = json.decode(data);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    _saveFile();
//    print("itens: ${ _taskList.toString() }");

    return Scaffold(
      appBar: AppBar(
        title: Text("Lista Tarefas"),
        backgroundColor: Colors.purple,
      ),
      body: Container(
          child: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(10.0),
              itemCount: _taskList.length,
              itemBuilder: createListItem,
            ),
          )
        ],
      )),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.purple,
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text('Adcionar tarefa'),
                  content: TextField(
                    keyboardType: TextInputType.text,
                    decoration:
                        InputDecoration(labelText: "Digite a sua tarefa"),
                    onChanged: (text) {},
                    controller: _txtController,
                  ),
                  actions: <Widget>[
                    FlatButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text(
                        'Cancelar',
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                      textColor: Colors.grey,
                    ),
                    FlatButton(
                      onPressed: () {
                        _addtask();
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Salvar',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                );
              });
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Widget createListItem(context, index) {
    final item = _taskList[index]['title'];

    return Dismissible(
        key: Key(item),
        direction: DismissDirection.endToStart,
        background: Container(
          color: Colors.red,
          padding: EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Icon(
                Icons.delete,
                color: Colors.white,
              )
            ],
          ),
        ),
        onDismissed: (direction) {

          // Remove item from list
          _taskList.removeAt(index);
          _saveFile();

        },
        child: CheckboxListTile(
            title: Text(_taskList[index]["title"]),
            value: _taskList[index]["done"],
            activeColor: Colors.purple,
            onChanged: (newState) {
              setState(() {
                _taskList[index]['done'] = newState;
              });

              _saveFile();
            }));
  }
}
