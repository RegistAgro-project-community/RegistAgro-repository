// lib/utils/safe_notification.dart
// Notificação segura que sanitiza mensagens de erro do backend
// Substitui showTopNotification para evitar vazamento de dados sensíveis

import 'package:flutter/material.dart';

void showSafeNotification(
  BuildContext context, {
  required String title,
  String? description,
  Color backgroundColor = Colors.red,
  IconData icon = Icons.error_outline,
  Duration duration = const Duration(seconds: 3),
}) {
  // SEMPRE mensagem segura para erros 500/desconhecidos
  final safeDesc = description?.isNotEmpty == true
      ? _sanitize(description!)
      : 'Não foi possível concluir a solicitação.';

  final overlay = Overlay.of(context);
  final overlayEntry = OverlayEntry(
    builder: (_) => Positioned(
      top: 50,
      left: 16,
      right: 16,
      child: Material(
        color: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 6,
              ),
            ],
          ),
          child: Row(
            children: [
              Icon(icon, color: Colors.white, size: 26),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 1.5),
                    Text(
                      safeDesc,
                      style: const TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
  overlay.insert(overlayEntry);
  Future.delayed(duration, () => overlayEntry.remove());
}

String _sanitize(String input) {
  // Remover possíveis scripts, SQL, paths, HTML tags
  return input
      .replaceAll(RegExp(r'<[^>]*>'), '') // HTML tags
      .replaceAll(RegExp(r'(script|javascript|on\w+\s*=)', caseSensitive: false), '')
      .replaceAll(RegExp(r'(union|select|insert|delete|drop)\s', caseSensitive: false), '')
      .substring(0, input.length.clamp(0, 200));
}

// Versão para sucesso
void showSafeSuccessNotification(
  BuildContext context, {
  required String title,
  String? description,
  Duration duration = const Duration(seconds: 3),
}) {
  showSafeNotification(
    context,
    title: title,
    description: description,
    backgroundColor: Colors.green,
    icon: Icons.check_circle_outline,
    duration: duration,
  );
}

// Versão para aviso
void showSafeWarningNotification(
  BuildContext context, {
  required String title,
  String? description,
  Duration duration = const Duration(seconds: 3),
}) {
  showSafeNotification(
    context,
    title: title,
    description: description,
    backgroundColor: Colors.amber,
    icon: Icons.warning_amber_outlined,
    duration: duration,
  );
}

// Versão para info
void showSafeInfoNotification(
  BuildContext context, {
  required String title,
  String? description,
  Duration duration = const Duration(seconds: 3),
}) {
  showSafeNotification(
    context,
    title: title,
    description: description,
    backgroundColor: Colors.blue,
    icon: Icons.info_outline,
    duration: duration,
  );
}