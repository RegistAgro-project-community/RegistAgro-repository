import 'package:flutter/material.dart';

class NotificationModel {
  final String id;
  final String title;
  final String message;
  final String time;
  final NotificationType type;
  bool isRead;

  NotificationModel({
    required this.id,
    required this.title,
    required this.message,
    required this.time,
    required this.type,
    this.isRead = false,
  });
}

enum NotificationType { order, promo, alert, info }

final List<NotificationModel> _demoNotifications = [
  NotificationModel(
    id: '1',
    title: 'Novo pedido recebido!',
    message: 'Você tem um novo pedido de 50kg de mandioca. Confirme para prosseguir.',
    time: 'Agora mesmo',
    type: NotificationType.order,
    isRead: false,
  ),
  NotificationModel(
    id: '2',
    title: 'Promoção especial 🌿',
    message: 'Desconto de 20% em fertilizantes esta semana. Aproveite!',
    time: 'Há 30 min',
    type: NotificationType.promo,
    isRead: false,
  ),
  NotificationModel(
    id: '3',
    title: 'Alerta de estoque',
    message: 'Seu produto "Milho Amarelo" está com estoque baixo. Apenas 5 unidades restantes.',
    time: 'Há 2 horas',
    type: NotificationType.alert,
    isRead: false,
  ),
  NotificationModel(
    id: '4',
    title: 'Pedido entregue com sucesso',
    message: 'O pedido #1023 foi entregue ao comprador. Obrigado!',
    time: 'Ontem, 14:30',
    type: NotificationType.order,
    isRead: true,
  ),
  NotificationModel(
    id: '5',
    title: 'Bem-vindo ao RegistAgro',
    message: 'Complete seu perfil para obter mais visibilidade para os seus produtos.',
    time: '2 dias atrás',
    type: NotificationType.info,
    isRead: true,
  ),
  NotificationModel(
    id: '6',
    title: 'Nova avaliação recebida',
    message: 'Um cliente avaliou o seu produto "Feijão Frade" com 5 estrelas!',
    time: '3 dias atrás',
    type: NotificationType.info,
    isRead: true,
  ),
];

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  late List<NotificationModel> _notifications;

  @override
  void initState() {
    super.initState();
    _notifications = List.from(_demoNotifications);
  }

  int get _unreadCount => _notifications.where((n) => !n.isRead).length;

  void _markAllAsRead() {
    setState(() {
      for (var n in _notifications) {
        n.isRead = true;
      }
    });
  }

  void _markAsRead(NotificationModel notification) {
    setState(() {
      notification.isRead = true;
    });
  }

  void _deleteNotification(NotificationModel notification) {
    setState(() {
      _notifications.remove(notification);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B7923),
      body: Column(
        children: [
          _buildHeader(context),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
              ),
              child: _notifications.isEmpty
                  ? _buildEmptyState()
                  : _buildNotificationList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
        child: Row(
          children: [
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 18),
              ),
            ),
            const SizedBox(width: 14),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Notificações",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (_unreadCount > 0)
                  Text(
                    "$_unreadCount não lida(s)",
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.8),
                      fontSize: 13,
                    ),
                  ),
              ],
            ),
            const Spacer(),
            if (_unreadCount > 0)
              TextButton(
                onPressed: _markAllAsRead,
                style: TextButton.styleFrom(
                  backgroundColor: Colors.white.withOpacity(0.2),
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const Text(
                  "Marcar todas",
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildNotificationList() {
    final unread = _notifications.where((n) => !n.isRead).toList();
    final read = _notifications.where((n) => n.isRead).toList();

    return ListView(
      padding: const EdgeInsets.symmetric(vertical: 8),
      children: [
        if (unread.isNotEmpty) ...[
          _buildGroupLabel("Novas"),
          ...unread.map((n) => _buildNotificationTile(n)),
        ],
        if (read.isNotEmpty) ...[
          _buildGroupLabel("Anteriores"),
          ...read.map((n) => _buildNotificationTile(n)),
        ],
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildGroupLabel(String label) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 4),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w700,
          color: Colors.grey.shade500,
          letterSpacing: 0.8,
        ),
      ),
    );
  }

  Widget _buildNotificationTile(NotificationModel notification) {
    final typeData = _getTypeData(notification.type);

    return Dismissible(
      key: Key(notification.id),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        color: Colors.red.shade400,
        child: const Icon(Icons.delete_outline, color: Colors.white),
      ),
      onDismissed: (_) => _deleteNotification(notification),
      child: GestureDetector(
        onTap: () => _markAsRead(notification),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: notification.isRead ? Colors.white : typeData['bgColor'] as Color,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: notification.isRead
                  ? Colors.grey.shade100
                  : (typeData['color'] as Color).withOpacity(0.2),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Ícone
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: (typeData['color'] as Color).withOpacity(0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  typeData['icon'] as IconData,
                  color: typeData['color'] as Color,
                  size: 22,
                ),
              ),
              const SizedBox(width: 12),

              // Conteúdo
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            notification.title,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: notification.isRead
                                  ? FontWeight.w500
                                  : FontWeight.bold,
                              color: Colors.grey.shade800,
                            ),
                          ),
                        ),
                        if (!notification.isRead)
                          Container(
                            width: 8,
                            height: 8,
                            decoration: const BoxDecoration(
                              color: Color(0xFF0B7923),
                              shape: BoxShape.circle,
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      notification.message,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade500,
                        height: 1.4,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 6),
                    Text(
                      notification.time,
                      style: TextStyle(
                        fontSize: 11,
                        color: (typeData['color'] as Color),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.notifications_off_outlined, size: 72, color: Colors.grey.shade300),
          const SizedBox(height: 16),
          Text(
            "Sem notificações",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade400,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "Você está em dia!",
            style: TextStyle(fontSize: 13, color: Colors.grey.shade400),
          ),
        ],
      ),
    );
  }

  Map<String, dynamic> _getTypeData(NotificationType type) {
    switch (type) {
      case NotificationType.order:
        return {
          'icon': Icons.shopping_bag_outlined,
          'color': const Color(0xFF0B7923),
          'bgColor': const Color(0xFFF0FBF3),
        };
      case NotificationType.promo:
        return {
          'icon': Icons.local_offer_outlined,
          'color': Colors.orange,
          'bgColor': const Color(0xFFFFF8F0),
        };
      case NotificationType.alert:
        return {
          'icon': Icons.warning_amber_rounded,
          'color': Colors.red,
          'bgColor': const Color(0xFFFFF0F0),
        };
      case NotificationType.info:
        return {
          'icon': Icons.info_outline,
          'color': Colors.blue,
          'bgColor': const Color(0xFFF0F6FF),
        };
    }
  }
}