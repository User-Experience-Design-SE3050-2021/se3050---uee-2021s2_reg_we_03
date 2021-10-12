import 'package:pizzahut/model/cart_item.dart';
import 'package:pizzahut/redux/actions.dart';

List<CartItem> cartItemsReducer(List<CartItem> items, dynamic action) {
  if (action is AddItemAction) {
    return addItem(items, action);
  } else if (action is RemoveItemAction) {
    return removeItem(items, action);
  }

  return items;
}

List<CartItem> addItem(List<CartItem> items, AddItemAction action) {
  return new List.from(items)..add(action.item);
}

List<CartItem> removeItem(List<CartItem> items, RemoveItemAction action) {
  return new List.from(items)..remove(action.item);
}
