import 'package:flutter/material.dart';

class PrivacyPolicyBottomSheet extends StatelessWidget {
  const PrivacyPolicyBottomSheet({super.key});

  static const _sections = [
    {
      'icon': Icons.info_outline,
      'title': '1. Informações que Coletamos',
      'content':
          'Coletamos as seguintes informações quando usas a nossa aplicação:\n\n'
          '• Nome completo e foto de perfil\n'
          '• Endereço de email e número de telemóvel\n'
          '• Preferências e configurações da conta\n'
          '• Dados de utilização e interações com a app\n'
          '• Informações do dispositivo (modelo, sistema operativo)',
    },
    {
      'icon': Icons.settings_outlined,
      'title': '2. Como Usamos os Teus Dados',
      'content':
          'Utilizamos os teus dados para:\n\n'
          '• Personalizar a tua experiência na aplicação\n'
          '• Enviar notificações relevantes e atualizações\n'
          '• Melhorar os nossos serviços continuamente\n'
          '• Prestar suporte técnico eficaz\n'
          '• Garantir a segurança da tua conta',
    },
    {
      'icon': Icons.share_outlined,
      'title': '3. Partilha de Dados',
      'content':
          'A tua privacidade é a nossa prioridade:\n\n'
          '• Nunca vendemos os teus dados pessoais a terceiros\n'
          '• Partilhamos dados apenas com prestadores de serviços essenciais\n'
          '• Todos os parceiros estão sujeitos a acordos de confidencialidade\n'
          '• Podes solicitar os teus dados a qualquer momento',
    },
    {
      'icon': Icons.shield_outlined,
      'title': '4. Segurança',
      'content':
          'Implementamos medidas robustas de segurança:\n\n'
          '• Encriptação SSL/TLS em todas as comunicações\n'
          '• Armazenamento seguro com encriptação AES-256\n'
          '• Autenticação de dois fatores disponível\n'
          '• Auditorias de segurança regulares\n'
          '• Monitorização contínua contra acessos não autorizados',
    },
    {
      'icon': Icons.people_outline,
      'title': '5. Os Teus Direitos',
      'content':
          'Tens os seguintes direitos sobre os teus dados:\n\n'
          '• Aceder aos teus dados pessoais\n'
          '• Corrigir informações incorretas\n'
          '• Solicitar a eliminação da tua conta\n'
          '• Portabilidade dos dados\n'
          '• Retirar o consentimento a qualquer momento',
    },
    {
      'icon': Icons.contact_mail_outlined,
      'title': '6. Contacto',
      'content':
          'Para qualquer questão relacionada com privacidade:\n\n'
          '📧 privacidade@tuaapp.com\n'
          '📍 Luanda, Angola\n\n'
          'Respondemos em até 72 horas úteis.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.75,
      minChildSize: 0.50,
      maxChildSize: 0.96,
      expand: false,
      builder: (context, scrollController) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
          ),
          child: Column(
            children: [
              // Handle bar
              Padding(
                padding: const EdgeInsets.only(top: 14),
                child: Container(
                  width: 42,
                  height: 5,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 44,
                          height: 44,
                          decoration: const BoxDecoration(
                            color: Color(0xFFE8EEF9),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.privacy_tip_outlined,
                            color: Color(0xFF0D47A1),
                            size: 24,
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Política de Privacidade',
                                style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontSize: 19,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black87,
                                ),
                              ),
                              Text(
                                'Última atualização: 16 de Fevereiro de 2026',
                                style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontSize: 12,
                                  color: Colors.grey[500],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF0F4FF),
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: const Color(0xFFBDD0F5)),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.verified_outlined, 
                            color: Color(0xFF0D47A1), 
                            size: 18
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              'Comprometemo-nos a proteger os teus dados e a tua privacidade.',
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 13,
                                color: Colors.blue[900],
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    Divider(color: Colors.grey[100]),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  controller: scrollController,
                  padding: const EdgeInsets.fromLTRB(24, 8, 24, 32),
                  itemCount: _sections.length,
                  itemBuilder: (context, index) {
                    final section = _sections[index];
                    return _SectionItem(
                      icon: section['icon'] as IconData,
                      title: section['title'] as String,
                      content: section['content'] as String,
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _SectionItem extends StatefulWidget {
  final IconData icon;
  final String title;
  final String content;

  const _SectionItem({
    required this.icon,
    required this.title,
    required this.content,
  });

  @override
  State<_SectionItem> createState() => _SectionItemState();
}

class _SectionItemState extends State<_SectionItem> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: const Color(0xFFF9FAFB),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: _expanded ? const Color(0xFFBDD0F5) : Colors.transparent,
          width: 1.5,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () => setState(() => _expanded = !_expanded),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          color: _expanded ? const Color(0xFFE8EEF9) : const Color(0xFFEEEEEE),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          widget.icon,
                          color: _expanded ? const Color(0xFF0D47A1) : Colors.grey[500],
                          size: 18,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          widget.title,
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: _expanded ? const Color(0xFF0D47A1) : Colors.black87,
                          ),
                        ),
                      ),
                      AnimatedRotation(
                        turns: _expanded ? 0.5 : 0,
                        duration: const Duration(milliseconds: 200),
                        child: Icon(
                          Icons.keyboard_arrow_down,
                          color: Colors.grey[400],
                          size: 22,
                        ),
                      ),
                    ],
                  ),
                  AnimatedCrossFade(
                    firstChild: const SizedBox.shrink(),
                    secondChild: Padding(
                      padding: const EdgeInsets.only(top: 14),
                      child: Text(
                        widget.content,
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 13.5,
                          color: Colors.grey[700],
                          height: 1.6,
                        ),
                      ),
                    ),
                    crossFadeState: _expanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
                    duration: const Duration(milliseconds: 220),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}