import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  List<String> _taskList = ["Rgt", "Ergito", "Vilanculos", "Rubildo"];

  _addtask() async {

  }

  @override
  Widget build(BuildContext context) {
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
                itemBuilder: (context, index){
                  return ListTile(
                    title: Text(_taskList[index]),
                  );
                },
              ),
            )
          ],
        )
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.purple,
        onPressed: () {

          showDialog(
            context: context,
            builder: (context){

              return AlertDialog(
                title: Text('Adcionar tarefa'),
                content: TextField(
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: "Digite a sua tarefa"
                  ),
                  onChanged: (text) {},
                ),
                actions: <Widget>[
                  FlatButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      'Cancelar',
                      style: TextStyle(
                        fontWeight: FontWeight.w500
                      ),
                    ),
                    textColor: Colors.grey,
                  ),
                  FlatButton(
                    onPressed: (){

                      // TODO: salvar

                      Navigator.pop(context);
                    },
                    child: Text(
                      'Salvar',
                      style: TextStyle(
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  )
                ],
              );

            }
          );

        },
        child: Icon(Icons.add),
      ),
    );
  }
}
