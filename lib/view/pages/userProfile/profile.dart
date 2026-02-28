import 'package:flutter/material.dart';
import 'package:projecto_registagro/repositories/profile.dart';
import 'package:projecto_registagro/view/pages/userProfile/changepassword/change_password_screen.dart';
import 'package:projecto_registagro/view/pages/userProfile/editProfile/edit_profile.dart';
import 'package:projecto_registagro/view/pages/userProfile/privacePolicy/privace_policy.dart';
import 'package:projecto_registagro/view/pages/userProfile/suportScreen/support_screen.dart';
import 'package:projecto_registagro/view/pages/userProfile/userModal/user_modal.dart';

class ProfileScreen extends StatefulWidget {
  final String? name;
  final String? email;
  final String? phone;
  final String? photo;
  final String? province;
  final String? adress;

  const ProfileScreen({
    super.key,
    this.name,
    this.email,
    this.phone,
    this.photo,
    this.province,
    this.adress,
  });

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  UserModel user = UserModel(
    name: 'Elias Manuell',
    email: 'eliasmanuell@gmail.com',
    phone: '+244 923 456 789',
    bio: 'Apaixonado por tecnologia e inovação.',
    province: "Luanda",
    adress: "Kalemba 2/Rua A",
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F4F4),
      body: Stack(children: [_buildHeader(), _buildBody()]),
    );
  }

  Widget _buildHeader() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 80, 24, 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: CircleAvatar(
                radius: 42,
                backgroundColor: Colors.white,
                backgroundImage: widget.photo != null
                    ? NetworkImage(widget.photo!)
                    : null,
                child: widget.photo == null
                    ? const Icon(
                        Icons.person,
                        size: 52,
                        color: Color(0xFF0D47A1),
                      )
                    : null,
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    widget.name ?? user.name,
                    style: const TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: Colors.black87,
                      letterSpacing: 0.1,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: const Color(0xFFE0E0E0)),
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Text(
                      widget.email ?? user.email,
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 13,
                        color: Colors.grey[800],
                        fontWeight: FontWeight.w500,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBody() {
    user = UserModel(
      name: widget.name ?? user.name,
      email: widget.email ?? user.email,
      phone: widget.phone ?? user.phone,
      bio: user.bio,
      province: widget.province ?? user.province,
      adress: widget.adress ?? user.adress,
      photoPath: widget.photo
    );

    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.60,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(36)),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 16,
              offset: Offset(0, -4),
            ),
          ],
        ),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(12, 38, 12, 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildMenuTile(
                icon: Icons.person_outline,
                title: 'Detalhes do Perfil',
                subtitle: 'Edita nome, foto, bio, telemóvel...',
                onTap: () async {
                  final updatedUser = await Navigator.push<UserModel>(
                    context,
                    MaterialPageRoute(
                      builder: (_) => EditProfileScreen(user: user),
                    ),
                  );
                  if (updatedUser != null) {
                    setState(() => user = updatedUser);
                  }
                },
              ),
              _buildMenuTile(
                icon: Icons.lock_outline,
                title: 'Alterar Senha',
                subtitle: 'Atualiza a tua palavra-passe',
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const ChangePasswordScreen(),
                  ),
                ),
              ),
              _buildMenuTile(
                icon: Icons.privacy_tip_outlined,
                title: 'Política de Privacidade',
                subtitle: 'Lê os termos de utilização e privacidade',
                onTap: () => showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(28),
                    ),
                  ),
                  builder: (_) => const PrivacyPolicyBottomSheet(),
                ),
              ),
              _buildMenuTile(
                icon: Icons.support_agent_outlined,
                title: 'Suporte',
                subtitle: 'Fala connosco ou envia um pedido',
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const SupportScreen()),
                ),
              ),
              const SizedBox(height: 80),
              Center(
                child: TextButton.icon(
                  onPressed: () => _showLogoutDialog(),
                  icon: const Icon(Icons.logout, color: Colors.red, size: 24),
                  label: const Text(
                    'Terminar Sessão',
                    style: TextStyle(
                      color: Colors.red,
                      fontFamily: 'Inter',
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 14,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
            child: Row(
              children: [
                Icon(icon, color: Colors.blue[900], size: 26),
                const SizedBox(width: 18),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 15.5,
                          color: Colors.black87,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        subtitle,
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 13,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(Icons.chevron_right, color: Colors.grey[400], size: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text(
          'Terminar sessão?',
          style: TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w700),
        ),
        content: const Text(
          'Tem a certeza que pretende terminar sessão?',
          style: TextStyle(fontFamily: 'Inter'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar', style: TextStyle(color: Colors.grey)),
          ),
          TextButton(
            onPressed: () async {
              final profile = Profile();
              await profile.logout(context);

              //Navigator.pop(context);
            },
            child: const Text('Sair', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
