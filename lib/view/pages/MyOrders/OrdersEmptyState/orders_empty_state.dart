import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.shopping_bag_outlined,
            size: 120,
            color: Colors.green[300],
          ),
          const SizedBox(height: 24),
          const Text(
            'Faça o seu pedido',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Siga estes passos simples para fazer seu pedido de forma rápida e segura.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
              height: 1.4,
            ),
          ),
          const SizedBox(height: 40),
          SizedBox(
            width: MediaQuery.sizeOf(context).width * 0.8.w,
            height: 40.h,
            child: ElevatedButton.icon(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Iniciar novo pedido...')),
                );
              },
              icon: const Icon(
                Icons.add, 
                size: 28, 
                color: Colors.white,
              ),
              label: const Text(
                'Fazer pedido',
                style: TextStyle(
                  fontSize: 18, 
                  fontWeight: FontWeight.w600, 
                  color: Colors.white
                ),
              ),
               style: ElevatedButton.styleFrom(
                backgroundColor:  const Color(0xFF61983D),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.r),
                ),
                elevation: 0,
              ),
            ),
          ),
        ],
      ),
    );
  }