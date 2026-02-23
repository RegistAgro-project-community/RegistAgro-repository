import 'package:flutter/material.dart';
import 'package:projecto_registagro/view/pages/MyOrders/ModalDetailsBottomSheet/modal_details_bottomsheet.dart';
import 'package:projecto_registagro/view/pages/MyOrders/ModalTackingBottomSheet/modal_traking_bottomsheet.dart';
import 'package:projecto_registagro/view/pages/MyOrders/ObjectListOrders/object_data.dart';

class OrderCard extends StatelessWidget {
  final Order order;
  const OrderCard({super.key, required this.order});

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
                color: order.statusColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                order.status,
                style: TextStyle(
                  color: order.statusColor,
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
                child: const Icon(Icons.image, color: Colors.grey,),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    order.storeName,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    order.description,
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 15
                    ),
                  )
                ],
              ),
              
            ],
          ),
          
          
      const SizedBox(height: 12),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {
                if (order.status == 'Pending') {
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
                order.status == 'Pending' ? 'Acompanhar' : 'Ver detalhes',
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