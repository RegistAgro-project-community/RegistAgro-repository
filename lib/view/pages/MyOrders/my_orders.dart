import 'package:flutter/material.dart';
import 'package:projecto_registagro/view/pages/MyOrders/ObjectListOrders/object_data.dart';
import 'package:projecto_registagro/view/pages/MyOrders/OrdersCard/orders_card.dart';
import 'package:projecto_registagro/view/pages/MyOrders/OrdersEmptyState/orders_empty_state.dart';

class MyOrderScreen extends StatefulWidget {
  List<Order> orders;
  MyOrderScreen({super.key, required this.orders});

  @override
  State<MyOrderScreen> createState() => _MyOrderScreenState();
}

class _MyOrderScreenState extends State<MyOrderScreen> {
  final bool hasOrders = true;

  List<Order> _filteredOrders = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _filteredOrders = widget.orders;
    _searchController.addListener(_filterOrders);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterOrders() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredOrders = widget.orders.where((order) {
        return order.id.toLowerCase().contains(query) ||
            order.farm.name.toLowerCase().contains(query);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsetsGeometry.only(top: 30),
          child: hasOrders ? _buildOrderList() : buildEmptyState(context),
        ),
      ),
    );
  }

  Widget _buildOrderList() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
          child: TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: 'Pesquisar...',
              hintStyle: TextStyle(color: Colors.grey),
              prefixIcon: const Icon(Icons.search, color: Colors.grey),
              suffixIcon: const Icon(Icons.filter_list, color: Colors.grey),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(100),
                borderSide: BorderSide.none,
              ),
              contentPadding: const EdgeInsets.symmetric(vertical: 4),
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            itemCount: _filteredOrders.length,
            itemBuilder: (context, index) {
              final order = _filteredOrders[index];
              return OrderCard(order: order);
            },
          ),
        ),
      ],
    );
  }
}
