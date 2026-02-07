import 'package:flutter/material.dart';
// c

// class _ProfileState extends State<Profile> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//        backgroundColor: Color(0xF4F4F4F4),
//        body:  SingleChildScrollView(
//         child: Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [

//                   const SizedBox(height: 32),
//                   // ElevatedButton.icon(
//                   //   onPressed: () {},
//                   //   icon: const Icon(Icons.edit),
//                   //   label: const Text(
//                   //     'Editar Perfil',
//                   //     style: TextStyle(fontFamily: 'Inter'),
//                   //   ),
//                   //   style: ElevatedButton.styleFrom(
//                   //     fixedSize: Size(200, 45),
//                   //     backgroundColor: Color(0xF4F4F4F4),
//                   //     shape: RoundedRectangleBorder(
//                   //       borderRadius: BorderRadius.circular(100),
//                   //       side: BorderSide(
//                   //         color: Colors.blue[900]!,
//                   //         width: sqrt1_2,
//                   //       )
//                   //     ),
//                   //   ),
//                   // ),
//                 ],
//               ),
//               const SizedBox(height: 48),
//               Container(
//                 width: double.infinity,
//                 decoration: BoxDecoration(
//                   color: Colors.amber
//                 ),
//                 child:
//                   ),
//             ],
//           ),
//         ),
//       );
//   }
// }

class ProfileState extends StatelessWidget {
  const ProfileState({super.key});
  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Color(0xF4F4F4F4),
      body: Stack(children: [_buildHeader(context), _buildBody()]),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 55),
        child: Column(
          spacing: 20,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              spacing: 5,
              children: [
                const CircleAvatar(
                  radius: 40,
                  child: Icon(Icons.person, size: 48),
                ),
                const SizedBox(height: 24),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Elias Manuell",
                      style: const TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 17,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 0.5),
                      decoration: BoxDecoration(
                        border: Border.all(color: Color(0xF4F4F4F4)),
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: Text(
                        "eliasmanuell@gmail.com",
                        style: const TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBody() {
    return Container(
      margin: const EdgeInsets.only(top: 200),
      height: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextButton(
                  onPressed: () => {},
                  child: Row(
                    children: [
                      Icon(Icons.person_2, color: Colors.blue[900]),
                      const SizedBox(width: 13),
                      const Text(
                        'Detalhes do Perfil',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 14,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                TextButton(
                  onPressed: () => {},
                  child: Row(
                    children: [
                      Icon(Icons.lock, color: Colors.blue[900]),
                      const SizedBox(width: 13),
                      const Text(
                        'Alterar Senha',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 14,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                TextButton(
                  onPressed: () => {},
                  child: Row(
                    children: [
                      Icon(Icons.privacy_tip_outlined, color: Colors.blue[900]),
                      const SizedBox(width: 16),
                      const Text(
                        'Privacy Policy',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 14,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                TextButton(
                  onPressed: () => {},
                  child: Row(
                    children: [
                      Icon(
                        Icons.support_agent_outlined,
                        color: Colors.blue[900],
                      ),
                      const SizedBox(width: 13),
                      const Text(
                        'Suporte',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 14,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                TextButton(
                  onPressed: () => {},
                  child: Row(
                    children: [
                      Icon(Icons.settings, color: Colors.blue[900]),
                      const SizedBox(width: 13),
                      const Text(
                        'Configurações',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 14,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                Center(
                  child: TextButton.icon(
                    onPressed: () {
                      // Navigator.pushAndRemoveUntil(
                      //   context,
                      //   MaterialPageRoute(builder: (_) => const LoginScreen()),
                      //   (Route<dynamic> route) => false, // remove todas as rotas anteriores
                      // );
                    },
                    icon: const Icon(Icons.logout, color: Colors.red),

                    label: const Text(
                      'Terminar Sessão',
                      style: TextStyle(color: Colors.red, fontFamily: 'Inter'),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
