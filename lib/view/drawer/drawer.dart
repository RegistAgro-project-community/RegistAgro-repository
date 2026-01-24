import 'package:flutter/material.dart';

class DrawerContent extends StatelessWidget {
  const DrawerContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: true,
      top: false,
      child: Drawer(
        width: 500,
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
        child: Stack(
          children: [
            SafeArea(
             child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 32.0,
                      horizontal: 10,
                    ),
                    child: Hero(
                      tag: "drawerContent",
                      child: Material(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const CircleAvatar(
                              radius: 30,
                              backgroundColor: Color(0xFFE3E9F7),
                              child: Icon(
                                Icons.person,
                                size: 48,
                                color: Color(0xFF1976D2),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 16),
                                  Text(
                                    "Elias Manuell",
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF0A3D8F),
                                    ),
                                  ),
                                const SizedBox(height: 4),
                                Material(
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 6,
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                        100,
                                      ),
                                      border: Border.all(
                                        color: const Color(0xFFE3E5E9),
                                        width: 1,
                                      ),
                                    ),
                                    child: Text(
                                       'Gestor de Fabrica de Software',
                                        style: const TextStyle(
                                          fontSize: 11,
                                        ),
                                      ),
                                    ),
                                  ),
                                ]),
                              ],
                          )
                          )
                          )
                         ),
                
                          
                  Divider(height: 1, thickness: 0.5),
                  ListTile(
                    leading: const Icon(Icons.person_2_outlined),
                    title: const Text(
                      'Meu Perfil',
                      style: TextStyle(fontWeight: FontWeight.w400),
                    ),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: const Icon(Icons.menu),
                    title: const Text(
                      'Meus Pedidos',
                      style: TextStyle(fontWeight: FontWeight.w400),
                    ),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: const Icon(Icons.support_agent_outlined),
                    title: const Text(
                      'Suporte',
                      style: TextStyle(fontWeight: FontWeight.w400),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Funcionalidade em breve.'),
                        ),
                      );
                    },
                    hoverColor: const Color(0xFFF5F7FA),
                  ),
                  const Spacer(),
                  Container(
                    height: 80,
                    width: double.infinity,
                    color: const Color(0xFFF6F7F8),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 16,
                      ),
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFE3E5E9),
                          foregroundColor: Colors.black,
                          elevation: 0,
                          minimumSize: const Size.fromHeight(48),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        icon: const Icon(Icons.logout),
                        label: const Text(
                          'Sair',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        onPressed: () async {
                          showDialog(
                            context: context,
                            barrierDismissible: false,
                            barrierColor: Colors.black.withOpacity(0.5),
                            builder: (BuildContext modalContext) {
                              return const Center(
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 4,
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ),
              ]),
        )
       ] )
      )
      ); 
 }
}
