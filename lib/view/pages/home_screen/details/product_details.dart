import 'package:flutter/material.dart';
import 'package:projecto_registagro/Models/product_ep/product_modals_ep.dart';

class ProductDetailsPage extends StatefulWidget {
  final Product product;

  const ProductDetailsPage({super.key, required this.product});

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  bool showMore = false;
  int cartCount = 0;

  Widget buildBottomBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5)],
      ),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                IconButton(
                  onPressed: cartCount > 0
                      ? () {
                          setState(() {
                            cartCount--;
                          });
                        }
                      : null,
                  icon: const Icon(Icons.remove_outlined, color: Colors.grey),
                ),
                Text(
                  cartCount.toString(),
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      cartCount++;
                    });
                  },
                  icon: const Icon(Icons.add_outlined, color: Colors.grey),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 11, 153, 42),
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
              onPressed: () {},
              child: Text(
                "Comprar Agora",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget stockStatusBadge(String stockStatus) {
    Color backgroundColor;
    String text;

    if (stockStatus == "confirmado") {
      backgroundColor = const Color.fromARGB(255, 111, 212, 114);
      text = "Confirmado";
    } 
    else if (stockStatus == "vazio") {
      backgroundColor = Colors.red;
      text = "Sem stock";
    } 
    else if (stockStatus == "pendente") {
      backgroundColor = Colors.amber;
      text = "Pendente";
    } 
    else {
      backgroundColor = Colors.grey;
      text = "Desconhecido";
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final product = widget.product;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: ListTile(
          contentPadding: EdgeInsets.only(left: 40),
          title: Text(
            "Detalhes do produto",
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
          trailing: Badge(
            isLabelVisible: cartCount > 0  ,
            backgroundColor: Colors.orange,
            label: Text(
              cartCount.toString(),
              style: const TextStyle(color: Colors.white, fontSize: 10),
            ),
            child: IconButton(
              onPressed: () {
                print("Carrinho clicado!");
              },
              icon: const Icon(
                Icons.shopping_cart_outlined,
                color: Colors.white,
              ),
            ),
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 11, 121, 35),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: product.id,
              child: Center(
                child: Container(
                  width: double.infinity,
                  height: 375,
                  decoration: BoxDecoration(color: Colors.white),
                  padding: const EdgeInsets.all(100),
                  child: Image.asset(product.image, fit: BoxFit.cover),
                ),
              ),
            ),

            Container(
              padding: const EdgeInsets.all(20),
              width: double.infinity,
              decoration: BoxDecoration(color: Color(0xFFF5F5F5)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        spacing: 5,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product.title,
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            product.subTitle,
                            style: const TextStyle(
                              fontSize: 15,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        product.price,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 11, 121, 35),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "Descrição",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    product.description,
                    maxLines: showMore ? null : 3,
                    textAlign: TextAlign.justify,
                    overflow: showMore
                        ? TextOverflow.visible
                        : TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 14, color: Colors.black54),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        showMore = !showMore;
                      });
                    },
                    child: Text(
                      showMore ? "Ver menos..." : "Ver mais...",
                      style: const TextStyle(
                        color: Color.fromARGB(255, 11, 121, 35),
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        spacing: 6,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Origem:", style: TextStyle(fontSize: 16)),
                          const Text(
                            "Categoria:",
                            style: TextStyle(fontSize: 16),
                          ),
                          const Text(
                            "Quantidade:",
                            style: TextStyle(fontSize: 16),
                          ),
                          const Text(
                            "Estado do Stock:",
                            style: TextStyle(fontSize: 16),
                          ),
                          const Text(
                            "Transporte Recomendado:",
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                      Column(
                        spacing: 6,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            product.province,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black54,
                            ),
                          ),
                          Text(
                            product.category,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black54,
                            ),
                          ),
                          Text(
                            product.quantity,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black54,
                            ),
                          ),
                          stockStatusBadge(product.stockStatus),
                          Text(
                            product.recommendedTransport,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Column(
                    spacing: 10,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Produto fornecido por:",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            elevation: 0,
                            foregroundColor: const Color.fromARGB(255, 11, 121, 35),
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            side: BorderSide.none,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(5),
                              ),
                            ),
                          ),
                          onPressed: () {},
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: const Row(
                              spacing: 10,
                              children: [
                                CircleAvatar(
                                  radius: 22,
                                  backgroundColor: Color(0xFFF5F5F5),
                                  backgroundImage:
                                      AssetImage("assets/images/icone.png"),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Fazenda Filomena",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Color.fromARGB(255, 11, 121, 35),
                                      ),
                                    ),
                                    Text(
                                      "Ver perfil do fornecedor",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(child: buildBottomBar()),
    );
  }
}
