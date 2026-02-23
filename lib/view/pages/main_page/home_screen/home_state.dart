import 'package:flutter/material.dart';
import 'package:projecto_registagro/Models/product_ep/product_modals_ep.dart';
import 'package:projecto_registagro/repositories/products.dart';
import 'productCard_ep/product_card.dart';

final searchInputController = TextEditingController();

class HomeState extends StatefulWidget {
  const HomeState({super.key});

  @override
  State<HomeState> createState() => _HomeState();
}

class _HomeState extends State<HomeState> {
  List<Product> products = [];
  String? errorMessage;
  bool isloading = true;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadProducts();
    });
  }


  Future<void> _loadProducts() async {
    final productsClass = ProductsRepositories();

    try {
      final fetchedProducts = await productsClass.getProducts(context);

      if (context.mounted) {
        setState(() {
          if (fetchedProducts is List<Product>) {
            products = fetchedProducts;
          } else {
            errorMessage = fetchedProducts;
          }
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          errorMessage = e.toString();
        });
      }
    }
  }

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
    return Column(
      children: [
        Container(
          height: 50,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.25),
            borderRadius: BorderRadius.circular(100),
          ),
          child: const TextField(
            cursorColor: Colors.white,
            decoration: InputDecoration(
              hintText: "Pesquisar...",
              hintStyle: TextStyle(color: Colors.white70),
              prefixIcon: Icon(Icons.search, color: Colors.white70),
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(vertical: 14),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildErrorWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.info, size: 64, color: Colors.amber),
          const SizedBox(height: 16),
          Text(
            errorMessage ?? "Erro desconhecido",
            textAlign: TextAlign.center,
          ),
        ],
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
      child: errorMessage != null
          ? _buildErrorWidget()
          : SingleChildScrollView(
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
