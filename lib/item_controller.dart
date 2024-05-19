import 'package:get/get.dart';
import 'item_model.dart';

class ItemController extends GetxController {
  var items = <Item>[].obs;

  void addItem(String name) {
    items.add(Item(name));
  }

  void removeItem(int index) {
    items.removeAt(index);
  }
}