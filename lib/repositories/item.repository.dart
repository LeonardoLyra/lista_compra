import 'package:lista_compra/models/item.model.dart';

class ItemRepository {
  // ignore: deprecated_member_use
  static List<Item> itens = List<Item>();

  ItemRepository() {
    if (itens.isEmpty) {
      itens.add(
          Item(nome: 'Macarão', qtdItem: 2, emFalta: false, marcado: true));
      itens.add(Item(nome: 'Sabonete', qtdItem: 3, marcado: true));
      itens.add(Item(nome: 'Leite', qtdItem: 4, emFalta: true, marcado: false));
      itens.add(Item(nome: 'Detergente', qtdItem: 2, marcado: true));
      itens.add(
          Item(nome: 'Manteiga', qtdItem: 3, emFalta: true, marcado: false));
      itens.add(Item(nome: 'Arroz', qtdItem: 4, marcado: true));
      itens.add(
          Item(nome: 'Feijão', qtdItem: 2, emFalta: false, marcado: false));
      itens.add(Item(nome: 'Farinha', qtdItem: 3, marcado: true));
      itens.add(Item(nome: 'Ovo', qtdItem: 4, emFalta: true, marcado: false));
      itens.add(Item(nome: 'Sal', qtdItem: 2, emFalta: false, marcado: false));
      itens.add(Item(nome: 'Batata', qtdItem: 3, marcado: true));
      itens
          .add(Item(nome: 'Açúcar', qtdItem: 4, emFalta: true, marcado: false));
    }
  }

  void create(Item item) {
    itens.add(item);
  }

  List<Item> read() {
    var aux;
    for (var i = 0; i < (itens.length); i++) {
      if (itens[i].marcado == false) {
        if (i == 0) {
          continue;
        } else {
          for (var j = 0; j < i; j++) {
            aux = itens[j];
            itens[j] = itens[i];
            itens[i] = aux;
          }
        }
      }
    }
    return itens;
  }

  void delete(String id) {
    final item = itens.singleWhere((i) => i.id == id);
    itens.remove(item);
  }

  void update(Item newItem, Item oldItem) {
    final item = itens.singleWhere((i) => i.id == oldItem.id);
    item.nome = newItem.nome;
    item.qtdItem = newItem.qtdItem;
    item.emFalta = newItem.emFalta;
  }
}
