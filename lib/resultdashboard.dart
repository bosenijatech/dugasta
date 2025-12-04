import 'package:flutter/material.dart';

class MachinePage extends StatelessWidget {
  const MachinePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple.shade100,
      body: Stack(
        children: [
          // Top gradient background
          Container(
            height: MediaQuery.of(context).size.height * 0.5,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFB56EFF), Color(0xFF914DFF)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(40)),
            ),
          ),

          // Back button
          Positioned(
            top: 50,
            left: 20,
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child:
                  const Icon(Icons.arrow_back, color: Colors.white, size: 30),
            ),
          ),

          // Content
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Score Circle
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withOpacity(0.2),
                  ),
                  child: Column(
                    children: const [
                      Text("Your Score",
                          style: TextStyle(color: Colors.white, fontSize: 18)),
                      SizedBox(height: 8),
                      Text("150pt",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 36,
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // Info Card
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: const [
                      BoxShadow(color: Colors.black12, blurRadius: 10)
                    ],
                  ),
                  child: Column(
                    children: const [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          InfoItem(
                              color: Colors.purple,
                              label: "100%",
                              subtitle: "Completion"),
                          InfoItem(
                              color: Colors.purple,
                              label: "20",
                              subtitle: "Total Question"),
                        ],
                      ),
                      SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          InfoItem(
                              color: Colors.green,
                              label: "13",
                              subtitle: "Correct"),
                          InfoItem(
                              color: Colors.red,
                              label: "07",
                              subtitle: "Wrong"),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),

                // Buttons Grid
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 20,
                    runSpacing: 20,
                    children: const [
                      ActionButton(icon: Icons.refresh, label: "Play Again"),
                      ActionButton(
                          icon: Icons.remove_red_eye, label: "Review Answer"),
                      ActionButton(icon: Icons.share, label: "Share Score"),
                      ActionButton(
                          icon: Icons.picture_as_pdf, label: "Generate PDF"),
                      ActionButton(icon: Icons.home, label: "Home"),
                      ActionButton(
                          icon: Icons.emoji_events, label: "Leaderboard"),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class InfoItem extends StatelessWidget {
  final Color color;
  final String label;
  final String subtitle;

  const InfoItem(
      {super.key,
      required this.color,
      required this.label,
      required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(label,
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: color)),
        const SizedBox(height: 4),
        Text(subtitle,
            style: const TextStyle(fontSize: 14, color: Colors.black87)),
      ],
    );
  }
}

class ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;

  const ActionButton({super.key, required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          backgroundColor: Colors.white,
          radius: 25,
          child: Icon(icon, color: Colors.deepPurple),
        ),
        const SizedBox(height: 8),
        Text(label, style: const TextStyle(fontSize: 14)),
      ],
    );
  }
}
