import 'package:flutter/material.dart';
import 'package:projecto_registagro/components/google_maps/location_provider.dart';
import 'package:projecto_registagro/components/google_maps/maps_screen.dart';
import 'package:projecto_registagro/view/pages/MyOrders/ObjectListOrders/object_data.dart';
import 'package:provider/provider.dart';


void showTrackingBottomSheet(BuildContext context, Order order) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) {
      return DraggableScrollableSheet(
        initialChildSize: 0.5,
        minChildSize: 0.3,
        maxChildSize: 0.9,
        builder: (context, scrollController) {
          return LayoutBuilder(
            builder: (context, constraints) {
              final totalHeight = constraints.maxHeight;

              return Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(20)
                  ),
                ),
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Colors.black12,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Acompanhamento do Pedido',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.close, 
                              size: 20,
                              color: Colors.redAccent,
                            ),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    Expanded(
                      child: ListView(
                        controller: scrollController,
                        padding: EdgeInsets.zero,
                        children: [
                          SizedBox(
                            height: totalHeight * 0.75,
                            child: const MapScreen(),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                
                                Consumer<SourceLocationProvider>(
                                  builder: (context, loc, _) => Container(
                                    padding: const EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                      color: Colors.grey[100],
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Row(
                                      children: [
                                        const Icon(Icons.location_on, color: Colors.green),
                                        const SizedBox(width: 8),
                                        Expanded(
                                          child: Text(
                                            loc.isLoading
                                                ? 'A obter localização...'
                                                : loc.currentAddress.isNotEmpty
                                                    ? loc.currentAddress
                                                    : 'Localização não disponível',
                                            style: const TextStyle(fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      );
    },
  );
}