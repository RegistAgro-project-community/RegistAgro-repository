import 'package:flutter/material.dart';
import 'package:projecto_registagro/Models/profile_ep/profile_modals_ep.dart';
import 'profile_details_card.dart';

class ProfileCard extends StatelessWidget {
  final ProfileModel profile;
  final String adress;

  const ProfileCard({super.key, required this.profile, required this.adress});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ProfileDetailsPage(profile: profile, adress: adress,),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 12),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: Image.asset(profile.profile, fit: BoxFit.cover)),

            const SizedBox(height: 10),

            Text(
              profile.name,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),

            const SizedBox(height: 4),

            Text(
              profile.name,
              style: const TextStyle(color: Colors.grey, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
