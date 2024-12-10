import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:makeup_browser/model/cart_item_adopter.dart';
import 'package:makeup_browser/model/cart_item_model.dart'; 
import 'package:makeup_browser/view%20model/product_viewmodel.dart';
import 'package:makeup_browser/view/splash_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
      Hive.registerAdapter(CartItemAdapter()); 

  await Hive.initFlutter();
  await Hive.openBox<CartItem>('cartBox'); 

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProductViewModel()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final viewModel = Provider.of<ProductViewModel>(context, listen: false);
      viewModel.fetchProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
