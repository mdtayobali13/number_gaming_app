import 'package:flutter/material.dart';
import 'package:number_gaminng_app/routes/app_routes.dart';
import 'package:number_gaminng_app/routes/app_routes_key.dart';
import 'package:number_gaminng_app/screens/game_play_screen/game_play_screen.dart';

class ChallengeScreen extends StatefulWidget {
  const ChallengeScreen({super.key});

  @override
  State<ChallengeScreen> createState() => _ChallengeScreenState();
}

class _ChallengeScreenState extends State<ChallengeScreen> {
  int selectedTabIndex = 0; // 0 = Friends, 1 = Pending
  TextEditingController searchController = TextEditingController();

  final List<Map<String, dynamic>> friendsList = [
    {"name": "Rafi Ahmed", "username": "@rafi123", "status": "Online", "isOnline": true, "avatarColor": const Color(0xFFFF7043)},
    {"name": "Hasan", "username": "@hasan_bg", "status": "Online", "isOnline": true, "avatarColor": const Color(0xFF26A69A)},
    {"name": "Sami", "username": "@sami99", "status": "Offline", "isOnline": false, "avatarColor": const Color(0xFF42A5F5)},
    {"name": "Nadia", "username": "@nadia_m", "status": "Offline", "isOnline": false, "avatarColor": const Color(0xFFEC407A)},
    {"name": "Nahid", "username": "@nahid_pro", "status": "Offline", "isOnline": false, "avatarColor": const Color(0xFFA1887F)},
    {"name": "Jannat", "username": "@jannat_7", "status": "Offline", "isOnline": false, "avatarColor": const Color(0xFFAB47BC)},
  ];

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void startChallengeWithFriend(String friendName) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const GamePlayScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final search = searchController.text.trim().toLowerCase();
    final filteredFriends = friendsList.where((f) {
      final name = (f['name'] as String).toLowerCase();
      final username = (f['username'] as String).toLowerCase();
      return name.contains(search) || username.contains(search);
    }).toList();

    return Scaffold(
      backgroundColor: const Color(0xFF0D0B38),
      body: SafeArea(
        child: Column(
          children: [
            // Top App Bar Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      if (Navigator.canPop(context)) {
                        AppRoutes.instance.pop();
                      } else {
                        AppRoutes.instance.go(AppRoutesKey.instance.homeScreen);
                      }
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                  const Expanded(
                    child: Text(
                      "Challenge a Friend",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ),
                  const SizedBox(width: 48),
                ],
              ),
            ),

            const SizedBox(height: 8),

            // Main White Container Card
            Expanded(
              child: Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(28),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(28),
                  child: Column(
                    children: [
                      const SizedBox(height: 16),

                      // Segmented Tab Selector (Friends | Pending)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Container(
                          height: 48,
                          decoration: BoxDecoration(
                            color: const Color(0xFFF1F5F9),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Row(
                            children: [
                              // Friends Tab
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selectedTabIndex = 0;
                                    });
                                  },
                                  child: AnimatedContainer(
                                    duration: const Duration(milliseconds: 200),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: selectedTabIndex == 0
                                          ? Colors.white
                                          : Colors.transparent,
                                      borderRadius: BorderRadius.circular(14),
                                      boxShadow: selectedTabIndex == 0
                                          ? [
                                              BoxShadow(
                                                color: Colors.black.withOpacity(0.06),
                                                blurRadius: 8,
                                                offset: const Offset(0, 2),
                                              ),
                                            ]
                                          : [],
                                    ),
                                    child: Text(
                                      "Friends",
                                      style: TextStyle(
                                        color: selectedTabIndex == 0
                                            ? const Color(0xFF4F46E5)
                                            : const Color(0xFF64748B),
                                        fontSize: 15,
                                        fontWeight: selectedTabIndex == 0
                                            ? FontWeight.bold
                                            : FontWeight.w600,
                                        fontFamily: 'Poppins',
                                      ),
                                    ),
                                  ),
                                ),
                              ),

                              // Pending Tab
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selectedTabIndex = 1;
                                    });
                                  },
                                  child: AnimatedContainer(
                                    duration: const Duration(milliseconds: 200),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: selectedTabIndex == 1
                                          ? Colors.white
                                          : Colors.transparent,
                                      borderRadius: BorderRadius.circular(14),
                                      boxShadow: selectedTabIndex == 1
                                          ? [
                                              BoxShadow(
                                                color: Colors.black.withOpacity(0.06),
                                                blurRadius: 8,
                                                offset: const Offset(0, 2),
                                              ),
                                            ]
                                          : [],
                                    ),
                                    child: Text(
                                      "Pending",
                                      style: TextStyle(
                                        color: selectedTabIndex == 1
                                            ? const Color(0xFF4F46E5)
                                            : const Color(0xFF64748B),
                                        fontSize: 15,
                                        fontWeight: selectedTabIndex == 1
                                            ? FontWeight.bold
                                            : FontWeight.w600,
                                        fontFamily: 'Poppins',
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 16),

                      // Search Input Field
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Container(
                          height: 48,
                          decoration: BoxDecoration(
                            color: const Color(0xFFF8FAFC),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: const Color(0xFFE2E8F0)),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 14),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.search_rounded,
                                color: Color(0xFF94A3B8),
                                size: 22,
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: TextField(
                                  controller: searchController,
                                  onChanged: (v) {
                                    setState(() {});
                                  },
                                  style: const TextStyle(
                                    color: Color(0xFF0F172A),
                                    fontSize: 14,
                                    fontFamily: 'Poppins',
                                  ),
                                  decoration: const InputDecoration(
                                    hintText: "Search by username or email",
                                    hintStyle: TextStyle(
                                      color: Color(0xFF94A3B8),
                                      fontSize: 14,
                                      fontFamily: 'Poppins',
                                    ),
                                    border: InputBorder.none,
                                    isDense: true,
                                  ),
                                ),
                              ),
                              if (searchController.text.isNotEmpty)
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      searchController.clear();
                                    });
                                  },
                                  child: const Icon(
                                    Icons.close_rounded,
                                    color: Color(0xFF94A3B8),
                                    size: 18,
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 12),

                      // List Items
                      Expanded(
                        child: selectedTabIndex == 0
                            ? ListView.separated(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0, vertical: 8.0),
                                itemCount: filteredFriends.length,
                                separatorBuilder: (context, index) => const Divider(
                                  color: Color(0xFFF1F5F9),
                                  height: 16,
                                ),
                                itemBuilder: (context, index) {
                                  final friend = filteredFriends[index];
                                  return _FriendListTile(
                                    name: friend['name'],
                                    username: friend['username'],
                                    status: friend['status'],
                                    isOnline: friend['isOnline'],
                                    avatarColor: friend['avatarColor'],
                                    onChallenge: () {
                                      startChallengeWithFriend(friend['name']);
                                    },
                                  );
                                },
                              )
                            : const Center(
                                child: Text(
                                  "No pending requests",
                                  style: TextStyle(
                                    color: Color(0xFF94A3B8),
                                    fontSize: 15,
                                    fontFamily: 'Poppins',
                                  ),
                                ),
                              ),
                      ),

                      // Bottom Info Banner
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        color: const Color(0xFFF8FAFC),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(Icons.info_outline_rounded,
                                color: Color(0xFF6366F1), size: 18),
                            SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                "Challenge will be sent as a notification and they can accept or decline.",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Color(0xFF64748B),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'Poppins',
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Friend List Tile Component
class _FriendListTile extends StatelessWidget {
  final String name;
  final String username;
  final String status;
  final bool isOnline;
  final Color avatarColor;
  final VoidCallback onChallenge;

  const _FriendListTile({
    required this.name,
    required this.username,
    required this.status,
    required this.isOnline,
    required this.avatarColor,
    required this.onChallenge,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Avatar Badge
        Stack(
          children: [
            CircleAvatar(
              radius: 24,
              backgroundColor: avatarColor.withOpacity(0.2),
              child: Icon(
                Icons.person_rounded,
                color: avatarColor,
                size: 28,
              ),
            ),
            if (isOnline)
              Positioned(
                right: 0,
                bottom: 0,
                child: Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: const Color(0xFF10B981),
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                ),
              ),
          ],
        ),

        const SizedBox(width: 14),

        // Friend Details
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: const TextStyle(
                  color: Color(0xFF0F172A),
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins',
                ),
              ),
              Text(
                username,
                style: const TextStyle(
                  color: Color(0xFF64748B),
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Poppins',
                ),
              ),
            ],
          ),
        ),

        // Send Challenge Button
        SizedBox(
          height: 38,
          child: ElevatedButton(
            onPressed: onChallenge,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF4F46E5),
              elevation: 2,
              shadowColor: const Color(0xFF4F46E5).withOpacity(0.3),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16),
            ),
            child: const Text(
              "Send Challenge",
              style: TextStyle(
                color: Colors.white,
                fontSize: 13,
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins',
              ),
            ),
          ),
        ),
      ],
    );
  }
}
