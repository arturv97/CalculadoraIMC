import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _infoText = "Informe os dados!";

  void _resetFields() {
    weightController.text = "";
    heightController.text = "";
    setState(() {
      _infoText = "Informe os dados!";
    });
  }

  void _calculate() {
    setState(() {
      double weight = double.parse(weightController.text);
      double height = double.parse(heightController.text) / 100;
      double imc = weight / (height * height);
      print(imc);
      if (imc < 17.0) {
        _infoText = "Muito abaixo do peso (${imc.toStringAsPrecision(3)})";
      } else if (imc < 18.5) {
        _infoText = "Abaixo do peso (${imc.toStringAsPrecision(3)})";
      } else if (imc < 25.0) {
        _infoText = "Peso normal (${imc.toStringAsPrecision(3)})";
      } else if (imc < 30.0) {
        _infoText = "Acima do peso (${imc.toStringAsPrecision(3)})";
      } else if (imc < 35.0) {
        _infoText = "Obesidade Grau I (${imc.toStringAsPrecision(3)})";
      } else if (imc < 40.0) {
        _infoText = "Obesidade Grau II (${imc.toStringAsPrecision(3)})";
      } else {
        _infoText = "Obesidade Grau III (${imc.toStringAsPrecision(3)})";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculadora de IMC"),
        centerTitle: true,
        backgroundColor: Colors.deepPurple[700],
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _resetFields,
          )
        ],
      ),
      backgroundColor: Colors.deepPurple[100],
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Icon(
                Icons.person,
                size: 100,
                color: Colors.deepPurple[500],
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: "Peso (kg)",
                    labelStyle: TextStyle(color: Colors.deepPurple[700])),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.deepPurple, fontSize: 20.0),
                controller: weightController,
                validator: (value){
                  if(value == null || value.isEmpty){
                    return "Insira o peso!";
                  }
                },
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: "Altura (cm)",
                    labelStyle: TextStyle(color: Colors.deepPurple[700])),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.deepPurple, fontSize: 20.0),
                controller: heightController,
                validator: (value){
                  if(value == null || value.isEmpty){
                    return "Insira a altura!";
                  }
                },
              ),
              Padding(
                  child: Container(
                    height: 45.0,
                    child: RaisedButton(
                      onPressed: (){
                        if(_formKey.currentState!.validate()){
                          _calculate();
                        }
                      },
                      child: Text(
                        "Calcular",
                        style: TextStyle(color: Colors.white, fontSize: 15.0),
                      ),
                      // textColor: Colors.red,
                      color: Colors.deepPurple,
                    ),
                  ),
                  padding: EdgeInsets.only(top: 10.0, bottom: 10.0)),
              Text(
                _infoText,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.deepPurple[700], fontSize: 18.0),
              )
            ],
          ),
        ),
      ),
    );
  }
}
