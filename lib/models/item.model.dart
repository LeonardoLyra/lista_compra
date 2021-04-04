import 'package:uuid/uuid.dart';

class Item {
  String id = Uuid().v4();
  String nome = "";
  int qtdItem = 0;
  bool emFalta = false;
  bool marcado = false;

  Item({this.nome, this.qtdItem, this.marcado = false, this.emFalta = false});
}
