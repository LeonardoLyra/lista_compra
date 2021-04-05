import 'dart:convert';

import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:lista_compra/models/item.model.dart';
import 'package:lista_compra/repositories/item.repository.dart';

enum EmFalta { Sim, Nao }

EmFalta _value = EmFalta.Sim;

class AddPage extends StatefulWidget {
  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  final _formKey = GlobalKey<FormState>();

  final _item = Item();

  final _repository = ItemRepository();

  onSave(BuildContext context) {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      _repository.create(_item);
      Navigator.of(context).pop(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_value == EmFalta.Sim) {
      _item.emFalta = true;
    } else {
      _item.emFalta = false;
    }
    return Scaffold(
      backgroundColor: Color.fromARGB(124, 226, 206, 165),
      appBar: AppBar(
        leading: BackButton(
          color: Colors.white,
        ),
        title: Text(
          "Adicionar Item a lista",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Color.fromARGB(1000, 199, 159, 78),
        shadowColor: Color.fromARGB(1000, 255, 255, 230),
        actions: [
          FlatButton(
            child: Text(
              "Salvar",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            onPressed: () => onSave(context),
          ),
        ],
      ),
      body: Container(
        margin: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(
                  labelText: "Nome do item",
                  border: OutlineInputBorder(),
                ),
                onSaved: (value) => _item.nome = value,
                validator: (value) =>
                    value.isEmpty ? "Campo Obrigatório" : null,
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: "Quantidade do item",
                  border: OutlineInputBorder(),
                ),
                onSaved: (value) => _item.qtdItem = int.parse(value),
                validator: (value) =>
                    value.isEmpty ? "Campo Obrigatório" : null,
              ),
              SizedBox(
                height: 40,
              ),
              Text(
                "Item está em falta?",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              RadioListTile<EmFalta>(
                title: const Text('Sim'),
                value: EmFalta.Sim,
                groupValue: _value,
                activeColor: Color.fromARGB(1000, 199, 159, 78),
                onChanged: (EmFalta value) {
                  setState(() {
                    _value = value;
                  });
                },
              ),
              RadioListTile<EmFalta>(
                title: const Text('Não'),
                value: EmFalta.Nao,
                groupValue: _value,
                activeColor: Color.fromARGB(1000, 199, 159, 78),
                onChanged: (EmFalta value) {
                  setState(() {
                    _value = value;
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
