import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff6f6f9),
      appBar: AppBar(
        title: Text(
          "Profile",
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xff4338CA),
        elevation: 0,
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 34),
          CircleAvatar(
            radius: 48,
            backgroundColor: Colors.indigo.shade100,
            child: Icon(Icons.person, size: 58, color: Colors.indigo.shade600),
          ),
          const SizedBox(height: 16),
          Text(
            "Xhevdet Ferizi",
            style: GoogleFonts.poppins(
                fontWeight: FontWeight.bold,
                fontSize: 22,
                color: Colors.indigo.shade700),
          ),
          const SizedBox(height: 5),
          Text(
            "ferizixhevdet@gmail.com",
            style: GoogleFonts.poppins(
                color: Colors.grey.shade600, fontSize: 16),
          ),
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 34.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _statCard(Icons.account_balance_wallet_rounded, "Balance", "€3,250"),
                _statCard(Icons.trending_up, "Income", "€4,000"),
                _statCard(Icons.trending_down, "Expenses", "€750"),
              ],
            ),
          ),
          const SizedBox(height: 40),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28.0),
            child: Column(
              children: [
                ListTile(
                  leading: Icon(Icons.settings, color: Colors.indigo.shade400),
                  title: Text("Settings", style: GoogleFonts.poppins(fontWeight: FontWeight.w500)),
                  onTap: () {},
                ),
                ListTile(
                  leading: Icon(Icons.exit_to_app, color: Colors.red.shade400),
                  title: Text("Log Out", style: GoogleFonts.poppins(fontWeight: FontWeight.w500, color: Colors.red.shade400)),
                  onTap: () {
                    Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _statCard(IconData icon, String title, String value) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      color: Colors.white,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 13),
        child: Column(
          children: [
            Icon(icon, size: 26, color: Colors.indigo),
            const SizedBox(height: 5),
            Text(value, style: GoogleFonts.poppins(fontWeight: FontWeight.w700)),
            Text(title, style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey.shade600)),
          ],
        ),
      ),
    );
  }
}
