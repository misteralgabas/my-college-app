import 'package:flutter/material.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Каталог товаров'),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _productCard(
            context,
            name: "Романовский Сырный",
            price: "1000₸",
            image: "assets/images/M_4870250370040_2.jfif",
            description: "Натуральный вкус, отличное качество.",
          ),
          _productCard(
            context,
            name: "ФЬЮСТИ 1 Л",
            price: "1500₸",
            image: "assets/images/images.jfif",
            description: "Современный дизайн и долговечность.",
          ),
          _productCard(
            context,
            name: "АЗИЯ 1 шт",
            price: "2000₸",
            image: "assets/images/M_5449000291257_1.jpg",
            description: "Лучшее соотношение цены и качества.",
          ),
        ],
      ),
    );
  }

  Widget _productCard(
      BuildContext context, {
        required String name,
        required String price,
        required String image,
        required String description,
      }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          Image.asset(image, fit: BoxFit.cover, height: 160, width: double.infinity),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 6),
                Text(description,
                    style: const TextStyle(fontSize: 14, color: Colors.grey)),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(price,
                        style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.teal)),
                    ElevatedButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('$name добавлен в корзину'),
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        "Купить",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
