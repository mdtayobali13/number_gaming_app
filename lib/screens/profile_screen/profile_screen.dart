import 'package:flutter/material.dart';
import 'package:number_gaminng_app/routes/app_routes.dart';
import 'package:number_gaminng_app/routes/app_routes_key.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0842),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Top Bar
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Profile",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  Container(
                    width: 42,
                    height: 42,
                    decoration: BoxDecoration(
                      color: const Color(0xFF1E1B4B),
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white.withOpacity(0.1)),
                    ),
                    child: const Icon(
                      Icons.settings_outlined,
                      color: Colors.white,
                      size: 22,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // User Profile Card
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  Container(
                    width: 96,
                    height: 96,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color(0xFF4F46E5).withOpacity(0.3),
                      border: Border.all(color: const Color(0xFF818CF8), width: 3),
                    ),
                    child: const Icon(
                      Icons.person_rounded,
                      color: Colors.white,
                      size: 60,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: const BoxDecoration(
                      color: Color(0xFF10B981),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.check_rounded,
                      color: Colors.white,
                      size: 14,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              // User Name & Handle
              const Text(
                "Tayob",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins',
                ),
              ),
              const SizedBox(height: 2),
              const Text(
                "@tayob_pro_guesser",
                style: TextStyle(
                  color: Color(0xFF94A3B8),
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Poppins',
                ),
              ),

              const SizedBox(height: 12),

              // Level Badge
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  "Level 2 • Master Guesser",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins',
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Gaming Statistics Grid (Wins, Win Rate, Total Played, Streak)
              Row(
                children: const [
                  Expanded(
                    child: _StatCard(
                      icon: Icons.emoji_events_rounded,
                      iconColor: Color(0xFFFFC837),
                      value: "24",
                      label: "Total Wins",
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: _StatCard(
                      icon: Icons.track_changes_rounded,
                      iconColor: Color(0xFF38B6FF),
                      value: "85%",
                      label: "Win Rate",
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              Row(
                children: const [
                  Expanded(
                    child: _StatCard(
                      icon: Icons.sports_esports_rounded,
                      iconColor: Color(0xFF10B981),
                      value: "28",
                      label: "Games Played",
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: _StatCard(
                      icon: Icons.local_fire_department_rounded,
                      iconColor: Color(0xFFFF52A8),
                      value: "5 Wins",
                      label: "Best Streak",
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 28),

              // Badges & Achievements Section
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Badges & Achievements",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins',
                  ),
                ),
              ),

              const SizedBox(height: 14),

              SizedBox(
                height: 85,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: const [
                    _BadgeItem(
                      emoji: "🥇",
                      title: "First Win",
                      bgColor: Color(0xFF1E1B4B),
                    ),
                    SizedBox(width: 12),
                    _BadgeItem(
                      emoji: "🔥",
                      title: "5-Streak",
                      bgColor: Color(0xFF1E1B4B),
                    ),
                    SizedBox(width: 12),
                    _BadgeItem(
                      emoji: "🎯",
                      title: "Bullseye",
                      bgColor: Color(0xFF1E1B4B),
                    ),
                    SizedBox(width: 12),
                    _BadgeItem(
                      emoji: "👑",
                      title: "Top Guesser",
                      bgColor: Color(0xFF1E1B4B),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 28),

              // Account Options List
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Column(
                  children: [
                    _ProfileOptionTile(
                      icon: Icons.person_outline_rounded,
                      iconColor: const Color(0xFF4F46E5),
                      title: "Edit Profile",
                      onTap: () {},
                    ),
                    const Divider(color: Color(0xFFF1F5F9), height: 1),
                    _ProfileOptionTile(
                      icon: Icons.notifications_outlined,
                      iconColor: const Color(0xFF0284C7),
                      title: "Notifications",
                      onTap: () {},
                    ),
                    const Divider(color: Color(0xFFF1F5F9), height: 1),
                    _ProfileOptionTile(
                      icon: Icons.volume_up_outlined,
                      iconColor: const Color(0xFF10B981),
                      title: "Sound & Music",
                      onTap: () {},
                    ),
                    const Divider(color: Color(0xFFF1F5F9), height: 1),
                    _ProfileOptionTile(
                      icon: Icons.logout_rounded,
                      iconColor: const Color(0xFFEF4444),
                      title: "Sign Out",
                      textColor: const Color(0xFFEF4444),
                      onTap: () {
                        AppRoutes.instance.go(AppRoutesKey.instance.signInScreen);
                      },
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}

/// Stat Card Component
class _StatCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String value;
  final String label;

  const _StatCard({
    required this.icon,
    required this.iconColor,
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1B4B),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.08)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.15),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: iconColor,
              size: 24,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins',
                  ),
                ),
                Text(
                  label,
                  style: const TextStyle(
                    color: Color(0xFF94A3B8),
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Poppins',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Badge Item Widget
class _BadgeItem extends StatelessWidget {
  final String emoji;
  final String title;
  final Color bgColor;

  const _BadgeItem({
    required this.emoji,
    required this.title,
    required this.bgColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFF6366F1).withOpacity(0.3)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            emoji,
            style: const TextStyle(fontSize: 26),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 11,
              fontWeight: FontWeight.bold,
              fontFamily: 'Poppins',
            ),
          ),
        ],
      ),
    );
  }
}

/// Profile Option Tile
class _ProfileOptionTile extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final Color? textColor;
  final VoidCallback onTap;

  const _ProfileOptionTile({
    required this.icon,
    required this.iconColor,
    required this.title,
    this.textColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: iconColor.withOpacity(0.12),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: iconColor, size: 20),
      ),
      title: Text(
        title,
        style: TextStyle(
          color: textColor ?? const Color(0xFF0F172A),
          fontSize: 15,
          fontWeight: FontWeight.w600,
          fontFamily: 'Poppins',
        ),
      ),
      trailing: const Icon(
        Icons.chevron_right_rounded,
        color: Color(0xFF94A3B8),
        size: 22,
      ),
    );
  }
}
