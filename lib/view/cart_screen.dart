import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:makeup_browser/assets/colors.dart';
import 'package:makeup_browser/model/cart_item_model.dart';
import 'package:nb_utils/nb_utils.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cartBox = Hive.box<CartItem>('cartBox');

    return Scaffold(
        backgroundColor: wheat,
      appBar: AppBar(
        title: const Text(
          "Your Cart",
          style: TextStyle(
            fontSize: 16,
            color: white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: primary_color
      ),
      body: ValueListenableBuilder(
        valueListenable: cartBox.listenable(),
        builder: (context, Box<CartItem> box, _) {
          if (box.isEmpty) {
            return const Center(
              child: Text('Your cart is empty!'),
            );
          }

          return ListView.builder(
            itemCount: box.length,
            itemBuilder: (context, index) {
              final cartItem = box.getAt(index);

              return ListTile(tileColor: white,enabled: true,
                leading: Image.network(cartItem?.thumbnail ?? ''),
                title: Text(cartItem?.title ?? '',style: const TextStyle(fontSize: 15,),),
                subtitle: Text(
                  '\$${(cartItem?.price ?? 0.0) * (cartItem?.quantity ?? 1)}',
               style: const TextStyle(fontSize: 13,color: greenColor), ),
                trailing: IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    box.deleteAt(index);
                  },
                ),
              ).paddingBottom(8);
            },
          ).paddingAll(20);
        },
      ),
    );
  }
}
