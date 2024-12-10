import 'package:hive/hive.dart';
import 'package:makeup_browser/model/cart_item_model.dart';

class CartItemAdapter extends TypeAdapter<CartItem> {
  @override
  final int typeId = 0; // Unique type ID for this adapter

  @override
  CartItem read(BinaryReader reader) {
    return CartItem(
      title: reader.readString(),
      price: reader.readDouble(),
      quantity: reader.readInt(),
      thumbnail: reader.readString(),
    );
  }

  @override
  void write(BinaryWriter writer, CartItem obj) {
    writer.writeString(obj.title);
    writer.writeDouble(obj.price);
    writer.writeInt(obj.quantity);
    writer.writeString(obj.thumbnail);
  }
}
