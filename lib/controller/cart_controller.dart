import 'package:food_store/model/item_data_model.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  RxList cartItemList = [].obs;
  var counter = 0.obs;
  void incrementCounter(ItemData itemData) {
    counter++;
    if (itemData.quantity != null && itemData.quantity != 0) {
      itemData.quantity = itemData.quantity! + 1;
    } else {
      itemData.quantity = 1;
    }
    update();
    print('fist is -> ${itemData.quantity}');
  }

  void decrementCounter(ItemData itemData) {
    if (counter != 0) {
      counter--;
      if (itemData.quantity != null && itemData.quantity != 0) {
        itemData.quantity = itemData.quantity! - 1;
      }
      update();
    }
  }

  addToCart(ItemData itemData) {
    cartItemList.add(itemData);
  }

  removeToCart(ItemData itemData) {
    cartItemList.remove(itemData);
    update();
  }

  String countTotal() {
    int subtotal = 0;

    for (ItemData item in cartItemList) {
      if ((item).quantity != null) {
        subtotal += (item).itemPrice! * (item).quantity!;
      }
    }
    return subtotal.toString();
  }

  taxFees() {
    return int.parse(countTotal()) * 0.1;
  }

  total() {
    return int.parse(countTotal()) + taxFees();
  }
}
