import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  final List<Map<String, String>> _cart = [];

  void addToCart(Map<String, String> product) {
    setState(() {
      _cart.add(product);
    });
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      const HomePage(),
      ProductListPage(onAddToCart: addToCart),
      CartPage(cartItems: _cart),
    ];

    return Scaffold(
      body: SafeArea(child: pages[_currentIndex]),
      bottomNavigationBar: NavigationBar(
        height: 70,
        selectedIndex: _currentIndex,
        onDestinationSelected: (index) => setState(() => _currentIndex = index),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home), label: "Главная"),
          NavigationDestination(icon: Icon(Icons.shopping_bag), label: "Товары"),
          NavigationDestination(icon: Icon(Icons.shopping_cart), label: "Корзина"),
        ],
      ),
    );
  }
}

//
// === Главная страница ===
//
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: size.height * 0.2,
              width: size.width * 0.4,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/logo.png"),
                  fit: BoxFit.contain,
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "Добро пожаловать в ALGABAS!",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            const Text(
              "Покупай лучшие товары по выгодным ценам",
              style: TextStyle(color: Colors.grey),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

//
// === Каталог товаров ===
//
class ProductListPage extends StatelessWidget {
  final Function(Map<String, String>) onAddToCart;
  const ProductListPage({super.key, required this.onAddToCart});

  final List<Map<String, String>> products = const [
    {
      "name": "СЫРНЫЙ РОМАНОВСКИЙ",
      "description": "Описание товара 1 — качественный git init
      и надежный.",
      "price": "1000₸",
      "image": "assets/images/product1.jpg"
    },
    {
      "name": "Товар 2",
      "description": "Описание товара 2 — отличное решение для дома.",
      "price": "1500₸",
      "image": "assets/images/product2.jpg"
    },
    {
      "name": "Товар 3",
      "description": "Описание товара 3 — стиль и комфорт.",
      "price": "2000₸",
      "image": "assets/images/product3.jpg"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Каталог")),
      body: GridView.builder(
        padding: const EdgeInsets.all(12),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 9 / 16,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
        ),
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ProductDetailPage(
                    product: product,
                    onAddToCart: onAddToCart,
                  ),
                ),
              );
            },
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 3,
              clipBehavior: Clip.hardEdge,
              child: Column(
                children: [
                  Expanded(
                    flex: 6,
                    child: Image.asset(
                      product["image"]!,
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(product["name"]!,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16)),
                          Text(product["price"]!,
                              style: const TextStyle(
                                  color: Colors.teal,
                                  fontWeight: FontWeight.w600)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

//
// === Детали товара ===
//
class ProductDetailPage extends StatelessWidget {
  final Map<String, String> product;
  final Function(Map<String, String>) onAddToCart;

  const ProductDetailPage({
    super.key,
    required this.product,
    required this.onAddToCart,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(product["name"]!)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 9 / 16,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  product["image"]!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              product["name"]!,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(product["description"]!,
                style: const TextStyle(fontSize: 16, color: Colors.grey)),
            const SizedBox(height: 20),
            Text("Цена: ${product["price"]!}",
                style: const TextStyle(
                    fontSize: 20, fontWeight: FontWeight.bold, color: Colors.teal)),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  onAddToCart(product);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('${product["name"]} добавлен в корзину'),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text("Добавить в корзину",
                    style: TextStyle(color: Colors.white)),
              ),
            )
          ],
        ),
      ),
    );
  }
}

//
// === Корзина покупок ===
//
class CartPage extends StatelessWidget {
  final List<Map<String, String>> cartItems;
  const CartPage({super.key, required this.cartItems});

  @override
  Widget build(BuildContext context) {
    int total = cartItems.fold(
        0, (sum, item) => sum + int.parse(item["price"]!.replaceAll("₸", "")));

    return Scaffold(
      appBar: AppBar(title: const Text("Корзина")),
      body: cartItems.isEmpty
          ? const Center(
        child: Text("Ваша корзина пуста",
            style: TextStyle(fontSize: 18, color: Colors.grey)),
      )
          : Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                final item = cartItems[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    leading: Image.asset(item["image"]!,
                        width: 50, fit: BoxFit.cover),
                    title: Text(item["name"]!),
                    subtitle: Text(item["price"]!),
                  ),
                );
              },
            ),
          ),
          Container(
            padding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            color: Colors.grey[100],
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Итого:",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    Text("$total₸",
                        style: const TextStyle(
                            fontSize: 18, color: Colors.teal)),
                  ],
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                          title: const Text("Покупка завершена"),
                          content: const Text(
                              "Спасибо за покупку! Ваш заказ оформлен."),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text("ОК"),
                            )
                          ],
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: const Text(
                      "Оформить покупку",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
