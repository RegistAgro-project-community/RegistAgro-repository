import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:projecto_registagro/Models/product_ep/product_modals_ep.dart';
import 'package:projecto_registagro/components/TopNotifications/top_notification.dart';
import 'package:projecto_registagro/repositories/payment.dart';
import 'package:projecto_registagro/view/pages/main_page/main_page.dart';

class CheckoutPage extends StatefulWidget {
  final Product product;
  final String adress;
  final double farmValue;
  final double carrierValue;
  final double registagroValue;
  final double total;
  final int qtd;

  const CheckoutPage({
    super.key,
    required this.product,
    required this.adress,
    required this.farmValue,
    required this.carrierValue,
    required this.registagroValue,
    required this.total,
    required this.qtd,
  });

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  String paymentMethod = "";
  String deliveryAddress = "Luanda, Angola - Av. 21 de Janeiro";

  final TextEditingController _addressController = TextEditingController();

  void _addNewAddress() async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Adicionar Novo Endereço"),
        content: TextField(
          controller: _addressController,
          decoration: const InputDecoration(
            hintText: "Digite seu novo endereço...",
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              _addressController.clear();
              Navigator.pop(context);
            },
            child: const Text("Cancelar"),
          ),
          ElevatedButton(
            onPressed: () {
              if (_addressController.text.trim().isNotEmpty) {
                setState(() {
                  deliveryAddress = _addressController.text.trim();
                });
              }
              _addressController.clear();
              Navigator.pop(context);
            },
            child: const Text("Salvar"),
          ),
        ],
      ),
    );
  }

  Future<void> _confirmOrder() async {
    final random = Random();

    int quantity = random.nextInt(12) + 1;
    List<int> numbers = List.generate(quantity, (_) => random.nextInt(10));
    String numbersText = numbers.join();

    if (paymentMethod.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Escolha um método de pagamento!"),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (paymentMethod != "Pagamento por referência") {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Método inválido! Só é permitido pagamento por referência.",
          ),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    //todo: Gerando referência
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(strokeWidth: 4, color: Colors.white),
            SizedBox(height: 15),
            Text(
              "A gerar referência...",
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontFamily: 'Inter',
              ),
            ),
          ],
        ),
      ),
    );

    try {
      final reference = await PaymentRepo().getReference(
        context,
        widget.product.farm!.id,
        widget.product.name,
        widget.qtd,
        "kg",
      );

      //todo: Copiar referência
      await showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text(
            "Referência de pagamento",
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              fontFamily: 'Inter',
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Use este número para efectuar o pagamento:",
                style: TextStyle(fontSize: 13, fontFamily: 'Inter'),
              ),
              const SizedBox(height: 20),
              SelectableText(
                reference,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () async {
                await Clipboard.setData(ClipboardData(text: numbersText));
                Navigator.pop(context);
                //todo: Processando pagamento
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (_) => const Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CircularProgressIndicator(
                          strokeWidth: 4,
                          color: Colors.white,
                        ),
                        SizedBox(height: 15),
                        Text(
                          "Efectuando pagamento...",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontFamily: 'Inter',
                          ),
                        ),
                      ],
                    ),
                  ),
                );

                try {
                  final message = await PaymentRepo().pay(context, reference);

                  Navigator.pop(context);
                  if (!context.mounted) return;

                  //todo: Sucesso
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (_) => AlertDialog(
                      title: const Text("Pedido Confirmado"),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.check_circle, color: Colors.green, size: 70),
                          SizedBox(height: 12),
                          Text(
                            message,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (_) => MainPage()),
                            );
                          },
                          child: const Text("Ok"),
                        ),
                      ],
                    ),
                  );
                } catch (e) {
                  Navigator.pop(context);
                  if (!context.mounted) return;

                  showTopNotification(
                    context,
                    title: "Error",
                    description: e.toString(),
                    backgroundColor: Colors.red.shade700,
                    icon: Icons.error_outline,
                  );
                }

              },
              child: const Text("Copiar"),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Fechar"),
            ),
          ],
        ),
      );
    } catch (e) {
      Navigator.pop(context);
      if (!context.mounted) return;

      showTopNotification(
        context,
        title: "Error",
        description: e.toString(),
        backgroundColor: Colors.red.shade700,
        icon: Icons.error_outline,
      );
    }

    Navigator.pop(context);
    if (!context.mounted) return;
  }

  Widget buildBottomBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5)],
      ),
      child: Row(
        children: [
          Text(
            "Total: AOA ${widget.total}",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontSize: 18,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 11, 153, 42),
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
              onPressed: _confirmOrder,
              child: const Text(
                "Pagar",
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF6F6F6),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        title: const Text(
          "Confirmação de compra",
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _section(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Endereço de Entrega",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    widget.adress,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Colors.black38,
                    ),
                  ),
                  const SizedBox(height: 8),
                  InkWell(
                    onTap: _addNewAddress,
                    child: Text(
                      "+ Adicionar Novo Endereço",
                      style: TextStyle(color: Colors.blue.shade600),
                    ),
                  ),
                ],
              ),
            ),

            _section(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.product.farm!.name,
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Container(
                        height: 70,
                        width: 70,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.grey[300],
                        ),
                        child:
                            widget.product.farm!.profile != "" &&
                                widget.product.farm!.profile.isNotEmpty
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.network(
                                  widget.product.farm!.profile,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Icon(
                                      Icons.image_not_supported,
                                      color: Colors.grey,
                                    );
                                  },
                                ),
                              )
                            : Icon(Icons.image),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Frutas frescas de origem nacional...",
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: 6),
                            Text(
                              "AOA ${widget.farmValue}",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            _section(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Método de pagamento",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                  ),
                  _radio("Pagamento por referência"),
                  _radio("Pagamento com Cartão"),
                  _radio("Pagamento com PayPal"),
                ],
              ),
            ),

            _section(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    Resumerow("Resumo da compra:", ""),
                    Divider(),
                    Resumerow(
                      "Frete:",
                      "AOA ${widget.carrierValue}",
                      bold: true,
                    ),
                    Resumerow(
                      "Quantidade total:",
                      "${widget.qtd}kg",
                      bold: true,
                    ),
                    SizedBox(height: 10),
                    Resumerow(
                      "RegistAgro:",
                      "AOA ${widget.registagroValue}",
                      bold: true,
                    ),
                    SizedBox(height: 10),
                    Resumerow(
                      "Total da compra:",
                      "AOA ${widget.total}",
                      bold: true,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(child: buildBottomBar()),
    );
  }

  Widget _radio(String value) {
    return RadioListTile(
      value: value,
      groupValue: paymentMethod,
      onChanged: (v) => setState(() => paymentMethod = v.toString()),
      title: Text(value),
      dense: true,
    );
  }

  Widget _section({required Widget child}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(bottom: 9),
      color: Colors.white,
      child: child,
    );
  }
}

class Resumerow extends StatelessWidget {
  final String label;
  final String value;
  final bool bold;

  const Resumerow(this.label, this.value, {this.bold = false, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Text(
            value,
            style: TextStyle(fontWeight: bold ? FontWeight.bold : null),
          ),
        ],
      ),
    );
  }
}
