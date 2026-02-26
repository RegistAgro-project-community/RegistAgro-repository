import 'package:elegant_notification/elegant_notification.dart';
import 'package:elegant_notification/resources/arrays.dart';
import 'package:flutter/material.dart';
import 'package:projecto_registagro/Models/product_ep/product_modals_ep.dart';
import 'package:projecto_registagro/view/pages/main_page/home_screen/paymentScreen/payment_screen.dart';

class ProductDetailsPage extends StatefulWidget {
  final Product data;

  const ProductDetailsPage({super.key, required this.data});

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
              onPressed: () {
                if (cartCount == 0) {
                  ElegantNotification.error(
                    title: const Text(
                      "Ups! Carrinho vazio!",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Inter',
                      ),
                    ),
                    description: const Text(
                      "Adicione produtos ao carrinho!",
                      style: TextStyle(
                        fontFamily: 'Inter',
                        color: Colors.grey
                      ),
                    ),
                    icon: const SizedBox(),
                    height: 75,
                    width: MediaQuery.of(context).size.width * .9,
                    animation: AnimationType.fromTop,
                  ).show(context);
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CheckoutPage()),
                  );
                }
              },
              child: Text(
                "Comprar",
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
    } else if (stockStatus == "vazio") {
      backgroundColor = Colors.red;
      text = "Sem stock";
    } else if (stockStatus == "pendente") {
      backgroundColor = Colors.amber;
      text = "Pendente";
    } else {
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
    final product = widget.data;
    //final farm = widget.data.farm;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: ListTile(
          contentPadding: EdgeInsets.only(left: 10),
          title: Text(
            "Detalhes do produto",
            style: TextStyle(fontSize: 20, color: Colors.white),
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
              tag: product,
              child: Center(
                child: Container(
                  width: double.infinity,
                  height: 375,
                  decoration: BoxDecoration(color: Colors.white),
                  padding: const EdgeInsets.symmetric(vertical: 48),
                  child: Image.network(product.photo as String, fit: BoxFit.cover),
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
                            product.name,
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            product.name,
                            style: const TextStyle(
                              fontSize: 15,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        product.price!,
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
                    product.description!,
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
                          Text("Preço:", style: TextStyle(fontSize: 16)),
                          const Text(
                            "Categoria:",
                            style: TextStyle(fontSize: 16),
                          ),
                          const Text(
                            "Quantidade:",
                            style: TextStyle(fontSize: 16),
                          ),
                          const Text(
                            "Estoque:",
                            style: TextStyle(fontSize: 16),
                          ),
                          const Text(
                            "Transporte:",
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                      Column(
                        spacing: 6,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            product.price!,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black54,
                            ),
                          ),
                          Text(
                            product.type!,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black54,
                            ),
                          ),
                          Text(
                            product.qtd!,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black54,
                            ),
                          ),
                          Text(
                            product.unit!,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black54,
                            ),
                          ),
                          Text(
                            product.transport!,
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
                            foregroundColor: const Color.fromARGB(
                              255,
                              11,
                              121,
                              35,
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            side: BorderSide.none,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(5),
                              ),
                            ),
                          ),
                          onPressed: () {
                            //Navigator.push(
                           //   context,
                              //MaterialPageRoute(
                              //  builder: (_) => //(profile: farm),
                             // ),
                           // );
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: const Row(
                              spacing: 10,
                              children: [
                                CircleAvatar(
                                  radius: 22,
                                  backgroundColor: Color(0xFFF5F5F5),
                                  backgroundImage: AssetImage(
                                    "assets/images/icone.png",
                                  ),
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
