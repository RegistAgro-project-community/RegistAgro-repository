import 'package:flutter/material.dart';
import 'package:projecto_registagro/Models/profile_ep/profile_modals_ep.dart';

class ProfileDetailsPage extends StatelessWidget {
  final ProfileModel profile;

  const ProfileDetailsPage({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(profile.name), 
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              spacing: 10,
              children: [
                CircleAvatar(
                  radius: 50,
                  child: Image.asset(
                    profile.profile,
                    width: double.infinity,
                    height: 220,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      profile.name,
                      style: Theme.of(context).textTheme.headlineSmall
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    Wrap(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: Text(
                            profile.name,
                            style: const TextStyle(
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
            const SizedBox(height: 24),
            const Text(
              "Sobre",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            const Text(
              "Este perfil representa um produtor local focado em produtos "
              "agrícolas frescos e de alta qualidade.",
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey
              ),
            ),

            SizedBox(
              height: 200,
              child: ListView.separated(
                padding: EdgeInsets.all(10),
                scrollDirection: Axis.horizontal,
                itemCount: 3,
                separatorBuilder: (_, __) => const SizedBox(width: 16),
                itemBuilder: (context, index) =>
                  Container(
                    width: 100,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.red, width: 3),
                      borderRadius: BorderRadius.circular(10)
                    ),
                  )
                ),
              ),
              SizedBox(
              height: 200,
              child: ListView.separated(
                padding: EdgeInsets.all(10),
                scrollDirection: Axis.horizontal,
                itemCount: 3,
                separatorBuilder: (_, __) => const SizedBox(width: 16),
                itemBuilder: (context, index) =>
                  Container(
                    width: 100,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.amber, width: 3),
                      borderRadius: BorderRadius.circular(10)
                      ),
                  )
                ),
              ),
          ],
        ),
      ),
    );
  }
}
