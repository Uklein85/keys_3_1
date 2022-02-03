import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async{
  runApp(new MaterialApp(
    title: 'Сохраняем на экране',
    home: new Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var _sharedPrefrencesTextValue = new TextEditingController();
  String _savedData = "";
  @override
  void initState() {
    super.initState();
    _loadSavedData();
  }

  _loadSavedData() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      if(sharedPreferences.getString('data') != null && sharedPreferences.getString('data')!.isNotEmpty){
        _savedData = sharedPreferences.getString('data')!;
      }else{
        _savedData = "Empty SP";
      }
    });
  }

  _saveData(String message) async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString("data", message);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text('Сохранение текста'),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),

      body: new Container(
        padding: const EdgeInsets.all(13.4),
        alignment: Alignment.topCenter,
        child: new ListTile(
          title: new TextField(
            controller: _sharedPrefrencesTextValue,
            decoration: new InputDecoration(labelText: 'Написать текст'),
          ),
          subtitle: new FlatButton(
              onPressed: (){
                _saveData(_sharedPrefrencesTextValue.text);
              },
              child: new Column(
                children: <Widget>[
                  new Text('Сохранить'),
                  new Padding(padding: new EdgeInsets.all(14.5)),
                  new Text(_savedData),
                ],
              )),
        ),
      ),

    );
  }
}