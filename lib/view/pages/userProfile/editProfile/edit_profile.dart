import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:projecto_registagro/components/TopNotifications/top_notification.dart';
import 'package:projecto_registagro/repositories/products.dart';
import 'package:projecto_registagro/repositories/storage.dart';
import 'package:projecto_registagro/view/pages/userProfile/userModal/user_modal.dart';

class EditProfileScreen extends StatefulWidget {
  final UserModel user;

  const EditProfileScreen({super.key, required this.user});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  bool _isEditing = false;

  late TextEditingController _nameCtrl;
  late TextEditingController _provinceCtrl;
  late TextEditingController _adressCtrl;
  late TextEditingController _bioCtrl;

  @override
  void initState() {
    super.initState();
    _nameCtrl = TextEditingController(text: widget.user.name);
    _provinceCtrl = TextEditingController(text: widget.user.province);
    _adressCtrl = TextEditingController(text: widget.user.adress);
    _bioCtrl = TextEditingController(text: widget.user.bio);
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _provinceCtrl.dispose();
    _adressCtrl.dispose();
    _bioCtrl.dispose();
    super.dispose();
  }

  void _saveChanges() async {
    if (_nameCtrl.text.trim().isEmpty ||
        _provinceCtrl.text.trim().isEmpty ||
        _adressCtrl.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Todos os campos são obrigatórios.'),
          backgroundColor: Colors.red[400],
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      );
      return;
    }

    final updated = widget.user.copyWith(
      name: _nameCtrl.text.trim(),
      province: _provinceCtrl.text.trim(),
      adress: _adressCtrl.text.trim(),
    );

    setState(() => _isEditing = false);

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Center(child: CircularProgressIndicator()),
    );

    try {
      final tokenMap = await TokenStorage().readToken();
      if (tokenMap.containsKey("error") || tokenMap["token"] == null) {
        ProductsRepositories().handleAuthError(
          context,
          tokenMap["error"] ?? "Faça Login novamente",
        );

        throw Exception("Não autenticado");
      }

      final dio = Dio(
        BaseOptions(
          headers: {
            'Content-Type': 'application/json',
            'authorization': "Bearer ${tokenMap['token']}",
          },
        ),
      );

      final response = await dio.put(
        "https://api-registagro.onrender.com/users/update",
        data: {
          "name": updated.name,
          "province": updated.province,
          "adress": updated.adress,
        },
      );

      Navigator.of(context).pop();

      String message = response.data['message'];

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              Icon(Icons.check_circle, color: Colors.white, size: 20),
              SizedBox(width: 10),
              Text(message),
            ],
          ),
          backgroundColor: const Color.fromARGB(255, 11, 121, 35),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      );

      Navigator.pop(context, updated);
    } on DioException catch (e) {
      Navigator.of(context).pop();

      String message = "";

      switch (e.response?.statusCode) {
        case 401 || 403 || 500:
          message = e.response?.data["error"] ?? "Sessão expirada";

          ProductsRepositories().handleAuthError(context, message);
          break;
        default:
          showTopNotification(
            context,
            title: "Error",
            description: message,
            backgroundColor: Colors.red.shade700,
            icon: Icons.error_outline,
          );
          break;
      }

      throw Exception(message);
    } catch (e) {
      Navigator.of(context).pop();

      showTopNotification(
        context,
        title: "Error",
        description: "Ocorreu um erro inesperado",
        backgroundColor: Colors.amber,
        icon: Icons.error_outline,
      );

      rethrow;
    }
  }

  void _cancelEditing() {
    _nameCtrl.text = widget.user.name;
    _provinceCtrl.text = widget.user.province;
    _adressCtrl.text = widget.user.adress;
    _bioCtrl.text = widget.user.bio;
    setState(() => _isEditing = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F4F4),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Color.fromARGB(255, 4, 136, 9),
            size: 20,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Detalhes do Perfil',
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Colors.black87,
          ),
        ),
        centerTitle: true,
        actions: [
          if (!_isEditing)
            Padding(
              padding: const EdgeInsets.only(right: 12),
              child: TextButton.icon(
                onPressed: () => setState(() => _isEditing = true),
                icon: const Icon(
                  Icons.edit_outlined,
                  size: 18,
                  color: Color.fromARGB(255, 4, 136, 9),
                ),
                label: const Text(
                  'Editar',
                  style: TextStyle(
                    color: Color.fromARGB(255, 4, 136, 9),
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const SizedBox(height: 8),
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.10),
                        blurRadius: 5,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: CircleAvatar(
                    radius: 42,
                    backgroundColor: Colors.white,
                    backgroundImage: widget.user.photoPath != ""
                        ? NetworkImage(widget.user.photoPath!)
                        : null,
                    child: widget.user.photoPath == ""
                        ? const Icon(
                            Icons.person,
                            size: 52,
                            color: Color.fromARGB(255, 4, 136, 9),
                          )
                        : null,
                  ),
                ),
                if (_isEditing)
                  GestureDetector(
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: const Text('Selecionar foto em breve...'),
                          behavior: SnackBarBehavior.floating,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      );
                    },
                    child: Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 4, 136, 9),
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2.5),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.15),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.camera_alt,
                        color: Colors.white,
                        size: 18,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 32),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 16,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(20),
              child: Column(
                spacing: 16,
                children: [
                  _buildField(
                    label: 'Nome Completo',
                    controller: _nameCtrl,
                    icon: Icons.person_outline,
                    enabled: _isEditing,
                    keyboardType: TextInputType.name,
                  ),
                  _buildField(
                    label: 'Província',
                    controller: _provinceCtrl,
                    icon: Icons.location_city,
                    enabled: _isEditing,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  _buildField(
                    label: 'Endereço',
                    controller: _adressCtrl,
                    icon: Icons.location_city_outlined,
                    enabled: _isEditing,
                    keyboardType: TextInputType.phone,
                  ),
                  _buildField(
                    label: 'Bio',
                    controller: _bioCtrl,
                    icon: Icons.info_outline,
                    enabled: _isEditing,
                    maxLines: 3,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            if (_isEditing) ...[
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    _saveChanges();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 4, 124, 8),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    'Guardar Alterações',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: _cancelEditing,
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.grey[700],
                    side: BorderSide(color: Colors.grey[300]!),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text(
                    'Cancelar',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildField({
    required String label,
    required TextEditingController controller,
    required IconData icon,
    required bool enabled,
    int maxLines = 1,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: Colors.grey[500],
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          enabled: enabled,
          maxLines: maxLines,
          keyboardType: keyboardType,
          style: const TextStyle(
            fontFamily: 'Inter',
            fontSize: 15,
            color: Colors.black87,
            fontWeight: FontWeight.w500,
          ),
          decoration: InputDecoration(
            prefixIcon: Icon(
              icon,
              color: enabled
                  ? const Color.fromARGB(255, 4, 136, 9)
                  : Colors.grey[400],
              size: 20,
            ),
            filled: true,
            fillColor: enabled
                ? const Color.fromARGB(255, 246, 255, 246)
                : const Color(0xFFF9F9F9),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(
                color: Color.fromARGB(255, 169, 233, 172),
                width: 1.5,
              ),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(
                color: Color.fromARGB(255, 29, 126, 32),
                width: 2,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
