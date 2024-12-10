import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:makeup_browser/assets/colors.dart';
import 'package:makeup_browser/model/cart_item_model.dart';
import 'package:makeup_browser/view/cart_screen.dart';
import 'package:nb_utils/nb_utils.dart';

class ProductDetailsScreen extends StatefulWidget {
  final Map<String, dynamic> product;

  const ProductDetailsScreen({super.key, required this.product});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  int _quantity = 1;

double get _totalPrice => (_quantity * (widget.product['price']?.toDouble() ?? 0.0)).toDouble();

  void _increaseQuantity() {
    setState(() {
      _quantity++;
    });
  }

  void _goToCartScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CartScreen()),
    );
  }
  void _decreaseQuantity() {
    if (_quantity > 1) {
      setState(() {
        _quantity--;
      });
    }
  }

  void _addToCart() {
  }
//add to carttt

  void _addToCartFun() {
    final cartBox = Hive.box<CartItem>('cartBox');
    final cartItem = CartItem(
      title: widget.product['title'],
      price: widget.product['price']?.toDouble() ?? 0.0,
      quantity: _quantity,
      thumbnail: widget.product['thumbnail'],
    );
    cartBox.add(cartItem);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Added to Cart!')),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: wheat,
      appBar: AppBar(
        title: Text(
          widget.product['title'] ?? '',
          style: const TextStyle(
            fontSize: 16,
            color: white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: primary_color
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(  
                   color: white,
                               borderRadius: BorderRadius.circular(12.0),
),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12.0),
                  child: Image.network(
                    widget.product['thumbnail'] ?? '',
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * .35,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Text(
                    widget.product['title'] ?? '',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  '\$${_totalPrice.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.green,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                widget.product['description'] ?? '',
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black54,
                ),
                maxLines: 10,
                overflow: TextOverflow.ellipsis,
              ),const SizedBox(height: 20,),
              Container(padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: white, borderRadius: BorderRadius.circular(10),),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          onPressed: _decreaseQuantity,
                          icon: const Icon(Icons.remove, color: primary_color),
                        ),
                        Text('$_quantity', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        IconButton(
                          onPressed: _increaseQuantity,
                          icon: const Icon(Icons.add, color: primary_color),
                        ),
                      ],
                    ),
                    ElevatedButton(
                      onPressed: _addToCartFun,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primary_color,
                        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      ),
                      child: Text(
                        'Add to Cart',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
               const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _goToCartScreen,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              ),
              child: const Text(
                'View Cart',
                style: TextStyle(fontSize: 16,color: white, fontWeight: FontWeight.bold),
              ),
            ),
            ],
          ),
        ),
      ),
    );
  }
}
