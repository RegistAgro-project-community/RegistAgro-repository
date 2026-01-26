import 'package:flutter/material.dart';
import 'package:projecto_registagro/data/products_ep/products_data_ep.dart';
import 'widgets/productCard_ep/product_card.dart';

class HomeState extends StatelessWidget {
  const HomeState({super.key});
  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: const Color.fromARGB(255, 11, 121, 35),
      body: Stack(children: [_buildHeader(context), _buildBody()]),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          spacing: 20,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  spacing: 4,
                  children: [
                    const CircleAvatar(
                      radius: 22,
                      backgroundColor: Colors.transparent,
                      backgroundImage: AssetImage(
                        "assets/images/logobranca.png",
                      ),
                    ),
                    Text(
                      "RegistAgro",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Badge(
                  isLabelVisible: true,
                  backgroundColor: Colors.orange,
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.notifications_outlined,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                ),
              ],
            ),
            _buildSearch(),
          ],
        ),
      ),
    );
  }

  Widget _buildSearch() {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.25),
        borderRadius: BorderRadius.circular(100),
      ),
      child: const TextField(
        decoration: InputDecoration(
          hintText: "Pesquisar...",
          hintStyle: TextStyle(color: Colors.white70),
          prefixIcon: Icon(Icons.search, color: Colors.white70),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 14),
        ),
      ),
    );
  }

  Widget _buildBody() {
    return Container(
      margin: const EdgeInsets.only(top: 210),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            sectionTitle("Produtos"),
            SizedBox(
              height: 200,
              child: ListView.separated(
                padding: EdgeInsets.all(10),
                scrollDirection: Axis.horizontal,
                itemCount: products.length,
                separatorBuilder: (_, __) => const SizedBox(width: 16),
                itemBuilder: (context, index) =>
                    ProductCard(product: products[index]),
              ),
            ),
            const SizedBox(height: 14),
            sectionTitle("Melhores frutos"),
            SizedBox(
              height: 200,
              child: ListView.separated(
                padding: EdgeInsets.all(10),
                scrollDirection: Axis.horizontal,
                itemCount: products.length,
                separatorBuilder: (_, __) => const SizedBox(width: 16),
                itemBuilder: (context, index) =>
                    ProductCard(product: products[index]),
              ),
            ),
            const SizedBox(height: 24),
            sectionTitle("Produtos"),
            SizedBox(
              height: 200,
              child: ListView.separated(
                padding: EdgeInsets.all(10),
                scrollDirection: Axis.horizontal,
                itemCount: products.length,
                separatorBuilder: (_, __) => const SizedBox(width: 16),
                itemBuilder: (context, index) =>
                    ProductCard(product: products[index]),
              ),
            ),
            const SizedBox(height: 24),
            sectionTitle("Melhores frutos"),
            SizedBox(
              height: 200,
              child: ListView.separated(
                padding: EdgeInsets.all(10),
                scrollDirection: Axis.horizontal,
                itemCount: products.length,
                separatorBuilder: (_, __) => const SizedBox(width: 16),
                itemBuilder: (context, index) =>
                    ProductCard(product: products[index]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget sectionTitle(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        TextButton(
          onPressed: () {},
          child: Text("ver tudo", style: TextStyle(color: Colors.green)),
        ),
      ],
    );
  }

  Widget productsGrid(List products) {
    return SizedBox(
      height: 200,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: products.length,
        separatorBuilder: (context, index) => const SizedBox(width: 16),
        itemBuilder: (context, index) {
          return ProductCard(product: products[index]);
        },
      ),
    );
  }
}
