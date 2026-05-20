import 'package:flutter/material.dart';
import 'package:projecto_registagro/components/TopNotifications/top_notification.dart';
import 'package:projecto_registagro/repositories/orders.dart';
import 'package:projecto_registagro/view/pages/MyOrders/ModalDetailsBottomSheet/modal_details_bottomsheet.dart';
import 'package:projecto_registagro/view/pages/MyOrders/ModalTackingBottomSheet/modal_traking_bottomsheet.dart';
import 'package:projecto_registagro/view/pages/MyOrders/ObjectListOrders/object_data.dart';

class OrderCard extends StatefulWidget {
  final Order order;
  const OrderCard({super.key, required this.order});

  @override
  State<OrderCard> createState() => _OrderCardState();
}

class _OrderCardState extends State<OrderCard> {
  late String _currentStatus;

  @override
  void initState() {
    super.initState();
    _currentStatus = widget.order.status;
  }

  MaterialColor _setColor(String status) {
    switch (status) {
      case "pendent":
        return Colors.amber;
      case "delivered":
        return Colors.green;
      case "confirmed":
        return Colors.green;
      case "rejected":
        return Colors.red;
      case "ongoing":
        return Colors.blue;
      case "incollection":
        return Colors.blue;
      default:
        return Colors.amber;
    }
  }

  String _setDescription(String status) {
    switch (status) {
      case "pendent":
        return "O pedido precisa da confirmação \nde ${widget.order.farm.name}.";
      case "delivered":
        return "O pedido foi entregue \npor ${widget.order.farm.name}";
      case "confirmed":
        return "O seu pedido foi confirmado";
      case "canceled":
        return "Você cancelou este pedido";
      case "rejected":
        return "O pedido foi rejeitado \npor ${widget.order.farm.name}";
      case "ongoing":
        return "O pedido está em andamento";
      case "incollection":
        return "O pedido está em coleta";
      default:
        return "Carregando...";
    }
  }

  String _setStatus(String status) {
    switch (status) {
      case "pendent":
        return "pendente";
      case "delivered":
        return "entregue";
      case "confirmed":
        return "confirmado";
      case "canceled":
        return "cancelado";
      case "rejected":
        return "rejeitado";
      case "ongoing":
        return "em andamento";
      case "incollection":
        return "em coleta";
      default:
        return status;
    }
  }

  void _confirmDelivery() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Confirmar entrega"),
        content: const Text(
          "Tem certeza que deseja confirmar a entrega deste pedido?",
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text("Cancelar"),
          ),
          ElevatedButton(
            onPressed: () async {
              /*final order = OrdersRepositories();
              try {
                final List<OrderProof> proof = await order.confirmOrder(
                  context,
                  widget.order.id,
                );

                print(proof);
              } on Exception catch (e) {
                showTopNotification(
                  context,
                  title: "Error",
                  description: e.toString(),
                  backgroundColor: Colors.amber,
                  icon: Icons.error_outline,
                );
              }*/
              //Navigator.pop(ctx);
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
            child: const Text(
              "Confirmar",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isOngoing = _currentStatus == 'ongoing';
    final bool isIncollection = _currentStatus == 'incollection';
    final bool isDelivered = _currentStatus == 'delivered';

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            // ignore: deprecated_member_use
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        spacing: 8,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.topRight,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                // ignore: deprecated_member_use
                color: _setColor(_currentStatus).withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                _setStatus(_currentStatus),
                style: TextStyle(
                  color: _setColor(_currentStatus),
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                ),
              ),
            ),
          ),
          Row(
            spacing: 6,
            children: [
              Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.grey[300],
                ),
                child:
                    widget.order.farm.profile != "" &&
                        widget.order.farm.profile.isNotEmpty
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          widget.order.farm.profile,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return const Icon(
                              Icons.image_not_supported,
                              color: Colors.grey,
                            );
                          },
                        ),
                      )
                    : const Icon(Icons.image, color: Colors.grey),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.order.farm.name,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    _setDescription(_currentStatus),
                    style: const TextStyle(color: Colors.grey, fontSize: 15),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () {
                  if (isOngoing || isIncollection || isDelivered) {
                    showTrackingBottomSheet(context, widget.order);
                  } else {
                    showDetailsBottomSheet(context, widget.order);
                  }
                },
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: Text(
                  isOngoing || isIncollection ? 'Acompanhar' : 'Ver detalhes',
                  style: const TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

              if (isDelivered) ...[
                const SizedBox(width: 16),
                TextButton(
                  onPressed: _confirmDelivery,
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: const Text(
                    'Confirmar entrega',
                    style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}
