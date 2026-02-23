import 'package:flutter/material.dart';
import 'package:projecto_registagro/data/products_ep/products_data_ep.dart';
import 'package:projecto_registagro/view/pages/Store/incialStore/inicial_store.dart';
import 'package:projecto_registagro/view/pages/notifications/notifications_screen.dart';
import 'productCard_ep/product_card.dart';

class HomeState extends StatefulWidget {
  const HomeState({super.key});

  @override
  State<HomeState> createState() => _HomeStateState();
}

class _HomeStateState extends State<HomeState> {
  final TextEditingController _searchController = TextEditingController();
  List _filteredProducts = [];
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    _filteredProducts = products;
    _searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    final query = _searchController.text.toLowerCase().trim();
    setState(() {
      _isSearching = query.isNotEmpty;
      if (query.isEmpty) {
        _filteredProducts = products;
      } else {
        _filteredProducts = products
            .where(
              (p) =>
                  p.title.toLowerCase().contains(query) ||
                  (p.category.toLowerCase().contains(query)),
            )
            .toList();
      }
    });
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B7923),
      body: Stack(children: [_buildHeader(context), _buildBody(context)]),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              spacing: 8,
              children: [
                Row(
                  children: [
                    const CircleAvatar(
                      radius: 22,
                      backgroundColor: Colors.transparent,
                      backgroundImage: AssetImage(
                        "assets/images/logobranca.png",
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      "RegistAgro",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                _buildNotificationButton(context),
              ],
            ),
            const SizedBox(height: 20),
            _buildSearch(),
          ],
        ),
      ),
    );
  }

  Widget _buildNotificationButton(BuildContext context) {
    const int unreadCount = 3;

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const NotificationsPage()),
        );
      },
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.15),
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Icon(
              Icons.notifications_outlined,
              color: Colors.white,
              size: 26,
            ),
          ),
          if (unreadCount > 0)
            Positioned(
              top: -4,
              right: -4,
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: const BoxDecoration(
                  color: Colors.orange,
                  shape: BoxShape.circle,
                ),
                child: Text(
                  '$unreadCount',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildSearch() {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.20),
        borderRadius: BorderRadius.circular(100),
        border: Border.all(color: Colors.white.withOpacity(0.3)),
      ),
      child: TextField(
        controller: _searchController,
        cursorColor: Colors.white,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: "Pesquisar produtos...",
          hintStyle: const TextStyle(color: Colors.white60),
          prefixIcon: const Icon(Icons.search, color: Colors.white70),
          suffixIcon: _searchController.text.isNotEmpty
              ? IconButton(
                  icon: const Icon(
                    Icons.close,
                    color: Colors.white70,
                    size: 20,
                  ),
                  onPressed: () {
                    _searchController.clear();
                  },
                )
              : null,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 14),
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 195),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      child: _isSearching
          ? _buildSearchResults()
          : _buildNormalContent(context),
    );
  }

  Widget _buildSearchResults() {
    if (_filteredProducts.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.search_off, size: 64, color: Colors.grey.shade300),
            const SizedBox(height: 12),
            Text(
              'Nenhum produto encontrado',
              style: TextStyle(fontSize: 16, color: Colors.grey.shade500),
            ),
          ],
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${_filteredProducts.length} resultado(s) encontrado(s)',
            style: TextStyle(fontSize: 13, color: Colors.grey.shade500),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 0.82,
              ),
              itemCount: _filteredProducts.length,
              itemBuilder: (context, index) =>
                  ProductCard(product: _filteredProducts[index]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNormalContent(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Banner de boas-vindas
          _buildWelcomeBanner(),
          const SizedBox(height: 20),

          _buildSectionTitle(context, "Produtos", category: "produtos"),
          const SizedBox(height: 10),
          _buildHorizontalList(context, products),

          const SizedBox(height: 20),

          _buildSectionTitle(context, "Melhores Frutos", category: "frutos"),
          const SizedBox(height: 10),
          _buildHorizontalList(
            context,
            products.where((p) => p.category == 'fruto').toList().isNotEmpty
                ? products.where((p) => p.category == 'fruto').toList()
                : products,
          ),

          const SizedBox(height: 20),

          _buildSectionTitle(
            context,
            "Mais Vendidos",
            category: "mais_vendidos",
          ),
          const SizedBox(height: 10),
          _buildHorizontalList(context, products.reversed.toList()),

          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildWelcomeBanner() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF0B7923), Color(0xFF1AAD3C)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Bem-vindo! 👋",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "Explore os melhores produtos agrícolas",
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.85),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          const Icon(Icons.eco, color: Colors.white, size: 40),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(
    BuildContext context,
    String title, {
    required String category,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => InicialStore(
                  title: title,
                  products: category == 'frutos'
                      ? (products
                                .where((p) => p.category == 'fruto')
                                .toList()
                                .isNotEmpty
                            ? products
                                  .where((p) => p.category == 'fruto')
                                  .toList()
                            : products)
                      : category == 'mais_vendidos'
                      ? products.reversed.toList()
                      : products,
                ),
              ),
            );
          },
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            minimumSize: const Size(0, 0),
          ),
          child: const Text(
            "ver tudo →",
            style: TextStyle(
              color: Color(0xFF0B7923),
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHorizontalList(BuildContext context, List productList) {
    return SizedBox(
      height: 200,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        scrollDirection: Axis.horizontal,
        itemCount: productList.length,
        separatorBuilder: (_, __) => const SizedBox(width: 14),
        itemBuilder: (context, index) =>
            ProductCard(product: productList[index]),
      ),
    );
  }
}
