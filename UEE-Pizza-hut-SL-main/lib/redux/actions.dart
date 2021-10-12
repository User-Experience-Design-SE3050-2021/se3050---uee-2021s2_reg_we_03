import 'package:pizzahut/model/cart_item.dart';

class AddItemAction {
  final CartItem item;

  AddItemAction(this.item);
}

class RemoveItemAction {
  final CartItem item;

  RemoveItemAction(this.item);
}

class RemoveItemsAction {}
