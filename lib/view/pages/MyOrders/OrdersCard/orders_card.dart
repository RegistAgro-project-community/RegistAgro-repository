import 'package:flutter/material.dart';
import 'package:projecto_registagro/view/pages/MyOrders/ModalDetailsBottomSheet/modal_details_bottomsheet.dart';
import 'package:projecto_registagro/view/pages/MyOrders/ModalTackingBottomSheet/modal_traking_bottomsheet.dart';
import 'package:projecto_registagro/view/pages/MyOrders/ObjectListOrders/object_data.dart';

class OrderCard extends StatelessWidget {
  final Order order;
  const OrderCard({super.key, required this.order});

  MaterialColor _setColor(Order color) {
    switch (color.status) {
      case "pendent":
        return Colors.amber;
      case "confirmed":
        return Colors.green;
      case "canceled":
        return Colors.red;
      case "rejected":
        return Colors.red;
      case "ongoing":
        return Colors.blue;
      default:
        return Colors.amber;
    }
  }

  String _setDescription(Order order){
    switch (order.status) {
      case "pendent":
        return "O pedido precisa da confirmação \nde ${order.farm.name}.";
      case "confirmed":
        return "O pedido foi confirmado \npor ${order.farm.name}";
      case "canceled":
        return "Você cancelou este pedido";
      case "rejected":
        return "O pedido foi rejeitado \npor ${order.farm.name}";
      case "ongoing":
        return "O pedido está em andamento";
      default:
        return "Caregando...";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.topRight,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: _setColor(order).withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                order.status,
                style: TextStyle(
                  color: _setColor(order),
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
                child: order.farm.profile != "" && order.farm.profile.isNotEmpty
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          order.farm.profile,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Icon(
                              Icons.image_not_supported, 
                              color: Colors.grey
                            );
                          },
                        ),
                      )
                    : Icon(Icons.image, color: Colors.grey),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    order.farm.name,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    _setDescription(order),
                    style: TextStyle(color: Colors.grey, fontSize: 15),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 12),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {
                if (order.status == 'ongoing' || order.status == "pendent") {
                  showTrackingBottomSheet(context, order);
                } else {
                  showDetailsBottomSheet(context, order);
                }
              },
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: Text(
                order.status == 'ongoing' ? 'Acompanhar' : 'Ver detalhes',
                style: const TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
