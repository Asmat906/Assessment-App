import 'package:flutter/material.dart';
import 'package:makeup_browser/assets/colors.dart';
import 'package:makeup_browser/view%20model/product_viewmodel.dart';
import 'package:makeup_browser/view/product_details.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<ProductViewModel>(context);

    if (viewModel.isLoading) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Products',style: TextStyle(color: white),),
        backgroundColor: primary_color,
        ),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    if (viewModel.errorMessage != null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text(
          "MakeUp Products",
          style: TextStyle(
            fontSize: 16,color: white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: primary_color
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                viewModel.errorMessage!,
                style: const TextStyle(color: Colors.red, fontSize: 18),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => viewModel.fetchProducts(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: primary_color,
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  textStyle: const TextStyle(fontSize: 16),
                ),
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      );
    }

    final products = viewModel.products;

    return Scaffold(backgroundColor: wheat.withOpacity(.8),
      appBar: AppBar(
                  title: const Text(
          "MakeUp Products",
          style: TextStyle(
            fontSize: 16,color: white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: primary_color
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(8.0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: MediaQuery.of(context).size.width > 600 ? 3 : 2,
          mainAxisSpacing: 10.0,
          crossAxisSpacing: 10.0,
          childAspectRatio: 0.75,
        ),
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];

          return GestureDetector(onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductDetailsScreen(product: product),
                ),
              );
          },
            child: Card(color: white,
              elevation: 6.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              shadowColor: Colors.black.withOpacity(0.1),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(12.0)),
                    child: Image.network(
                      product['thumbnail'] ?? '',
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: 160,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      product['title'] ?? '',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.black87,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      '\$${product['price']?.toStringAsFixed(2) ?? ''}',
                      style: const TextStyle(
                        color: Colors.green,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0),
                  //   child: Text(
                  //     product['description'] ?? '',
                  //     style: TextStyle(fontSize: 12, color: Colors.black54),
                  //     maxLines: 2,
                  //     overflow: TextOverflow.ellipsis,
                  //   ),
                  // ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
