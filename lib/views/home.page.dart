import 'package:flutter/material.dart';
import 'package:lista_compra/models/item.model.dart';
import 'package:lista_compra/repositories/item.repository.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final repository = ItemRepository();

  List<Item> itens;

  bool canEdit = false;

  @override
  initState() {
    super.initState();
    this.itens = repository.read();
  }

  Future<bool> confirmarExclusao() async {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (_) {
          return AlertDialog(
            title: Text("Confirma a exclusão?"),
            actions: [
              FlatButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text("Não"),
              ),
              FlatButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: Text("Sim"),
              ),
            ],
          );
        });
  }

  Widget adicionarItem(BuildContext context) {
    return FloatingActionButton(
      onPressed: () async {
        var result = await Navigator.of(context).pushNamed('/add');
        if (result != null && result == true) {
          setState(() => this.itens = repository.read());
        }
      },
      child: Icon(
        Icons.add,
        color: Colors.white,
      ),
      backgroundColor: Color.fromARGB(1000, 199, 159, 78),
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(124, 226, 206, 165),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(1000, 199, 159, 78),
        shadowColor: Color.fromARGB(124, 226, 206, 165),
        title: Text(
          "Lista de Compras",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(
              Icons.edit,
              color: Colors.white,
            ),
            onPressed: () => setState(() => canEdit = !canEdit),
          ),
        ],
      ),
      resizeToAvoidBottomInset: true,
      body: ListView.builder(
        padding: EdgeInsets.fromLTRB(50, 0, 50, 0),
        itemCount: repository.read().length,
        itemBuilder: (_, indice) {
          var item = itens[indice];
          if (itens.isEmpty) {
            Text("Lista Vazia, clique no mais para iniciar as Compras!");
          } else {}
          return Dismissible(
            key: Key(item.id),
            background: Container(
              color: Colors.red,
            ),
            onDismissed: (_) {
              repository.delete(item.id);
              setState(() => this.itens = repository.read());
            },
            confirmDismiss: (_) {
              return confirmarExclusao();
            },
            child: CheckboxListTile(
              contentPadding: EdgeInsets.fromLTRB(50, 10, 50, 20),
              subtitle: Text(
                "Quantidade: " + item.qtdItem.toString(),
                style: TextStyle(
                  color: Colors.black,
                  decoration: item.marcado
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
                ),
              ),
              activeColor: Color.fromARGB(1000, 199, 159, 78),
              value: item.marcado,
              title: Row(
                children: [
                  canEdit
                      ? IconButton(
                          icon: Icon(
                            Icons.edit,
                            color: Color.fromARGB(1000, 199, 159, 78),
                            size: 20,
                          ),
                          onPressed: () async {
                            var result = await Navigator.of(context)
                                .pushNamed("/edit", arguments: item);
                            if (result) {
                              setState(() => this.itens = repository.read());
                            }
                          },
                        )
                      : Container(),
                  Text(
                    item.emFalta ? "!" + item.nome : item.nome,
                    style: TextStyle(
                      color: item.emFalta ? Colors.red : Colors.black,
                      decoration: item.marcado
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                    ),
                  ),
                ],
              ),
              onChanged: (value) {
                setState(() {
                  item.marcado = value;
                  if (item.marcado == true) {
                    item.emFalta = false;
                  }
                });
                this.itens = repository.read();
              },
            ),
          );
        },
      ),
      floatingActionButton: adicionarItem(context),
    );
  }
}
