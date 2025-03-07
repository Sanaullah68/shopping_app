import 'package:flutter/material.dart';
import 'package:shopping_app/global_variable.dart';
import 'package:shopping_app/widgets/product_card.dart';
import 'package:shopping_app/pages/product_details_page.dart';

class ProductList extends StatefulWidget {
  const ProductList({super.key});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  final List<String> filters = [
    'All',
    'Adidas',
    'Nike',
    'Bata',
    'Puma',
  ];
  late String salectedFilter;

  @override
  void initState() {
    super.initState();
    salectedFilter = filters[0];
  }

  @override
  Widget build(BuildContext context) {
    const border = OutlineInputBorder(
      borderSide: BorderSide(
        color: Color.fromRGBO(225, 225, 225, 1),
      ),
      borderRadius: BorderRadius.horizontal(
        left: Radius.circular(50),
      ),
    );
    return SafeArea(
      child: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text("Shoes\nCollection",
                    style: Theme.of(context).textTheme.titleLarge),
              ),
              const Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    hintText: 'search',
                    border: border,
                    enabledBorder: border,
                    focusedBorder: border,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 120,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final filter = filters[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: GestureDetector(
                    onTap: () {
                      setState(
                        () {
                          salectedFilter = filter;
                        },
                      );
                    },
                    child: Chip(
                      label: Text(filter),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 15,
                      ),
                      backgroundColor: salectedFilter == filter
                          ? Theme.of(context).colorScheme.primary
                          : const Color.fromRGBO(245, 247, 249, 1),
                      labelStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      side: const BorderSide(
                        color: Color.fromRGBO(245, 247, 249, 1),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                );
              },
              itemCount: filters.length,
            ),
          ),
          Expanded(
            child: LayoutBuilder(builder: (context, constraints) {
              if (constraints.maxWidth > 800) {
                return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.8,
                  ),
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    final product = products[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) {
                            return ProductDetailsPage(
                              products: product,
                            );
                          }),
                        );
                      },
                      child: ProductCard(
                        title: product['title'] as String,
                        price: product['price'] as double,
                        image: product['imageUrl'] as String,
                        backgroundColor: index % 2 == 0
                            ? const Color.fromRGBO(216, 240, 253, 1)
                            : const Color.fromRGBO(245, 247, 249, 1),
                      ),
                    );
                  },
                );
              } else {
                return ListView.builder(
                  itemBuilder: (context, index) {
                    final product = products[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) {
                            return ProductDetailsPage(
                              products: product,
                            );
                          }),
                        );
                      },
                      child: ProductCard(
                        title: product['title'] as String,
                        price: product['price'] as double,
                        image: product['imageUrl'] as String,
                        backgroundColor: index % 2 == 0
                            ? const Color.fromRGBO(216, 240, 253, 1)
                            : const Color.fromRGBO(245, 247, 249, 1),
                      ),
                    );
                  },
                  itemCount: products.length,
                );
              }
            }),
          ),
        ],
      ),
    );
  }
}
