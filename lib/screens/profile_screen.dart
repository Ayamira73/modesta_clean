import 'package:flutter/material.dart';
import 'splash_screen.dart';
import 'quiz_screen.dart';

// Екран 6: Профил на потребителя
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _notificationsOn = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A2E),
      appBar: AppBar(
        backgroundColor: const Color(0xFF12122A),
        elevation: 0,
        title: const Text(
          'Profile',
          style: TextStyle(color: Color(0xFFE8D5B7), fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFFE8D5B7)),
          onPressed: () => Navigator.pop(context),
        ),
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [

            // Горна секция - профилна информация
            Container(
              width: double.infinity,
              color: const Color(0xFF12122A),
              padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
              child: Column(
                children: [

                  // Профилна снимка
                  Stack(
                    children: [
                      const CircleAvatar(
                        radius: 52,
                        backgroundColor: Color(0xFF2D2D44),
                        child: Icon(Icons.person, size: 56, color: Color(0xFFE8D5B7)),
                      ),
                      // Бутон за смяна на снимка
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: GestureDetector(
                          onTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Opening gallery...')),
                            );
                          },
                          child: Container(
                            width: 32,
                            height: 32,
                            decoration: const BoxDecoration(
                              color: Color(0xFFE8D5B7),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.edit,
                              size: 16,
                              color: Color(0xFF1A1A2E),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // Потребителско ime
                  const Text(
                    'Sofia Ivanova',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),

                  const SizedBox(height: 4),

                  // Хандъл
                  const Text(
                    '@sofia.style',
                    style: TextStyle(fontSize: 14, color: Color(0xFF888888)),
                  ),

                  const SizedBox(height: 20),

                  // Статистики
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildStat('24', 'Outfits'),
                      const SizedBox(width: 40),
                      _buildStat('312', 'Followers'),
                      const SizedBox(width: 40),
                      _buildStat('98', 'Following'),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Секция настройки
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  const Text(
                    'Account Settings',
                    style: TextStyle(
                      color: Color(0xFF888888),
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                    ),
                  ),

                  const SizedBox(height: 12),

                  // Редактирай профил
                  _buildSettingsRow(
                    icon: Icons.edit_outlined,
                    title: 'Edit Profile',
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Edit Profile')),
                      );
                    },
                  ),

                  const SizedBox(height: 8),

                  // Известия (с Switch)
                  Container(
                    height: 56,
                    decoration: BoxDecoration(
                      color: const Color(0xFF2D2D44),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.notifications_outlined,
                          color: Color(0xFFE8D5B7),
                          size: 22,
                        ),
                        const SizedBox(width: 16),
                        const Expanded(
                          child: Text(
                            'Notifications',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ),
                        Switch(
                          value: _notificationsOn,
                          activeColor: const Color(0xFFE8D5B7),
                          onChanged: (val) {
                            setState(() => _notificationsOn = val);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  val ? 'Notifications ON' : 'Notifications OFF',
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 8),

                  // Стилови предпочитания
                  _buildSettingsRow(
                    icon: Icons.tune_outlined,
                    title: 'Style Preferences',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const QuizScreen()),
                      );
                    },
                  ),

                  const SizedBox(height: 24),

                  const Text(
                    'Other',
                    style: TextStyle(
                      color: Color(0xFF888888),
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                    ),
                  ),

                  const SizedBox(height: 12),

                  // Log Out
                  GestureDetector(
                    onTap: () {
                      // Изчистваме историята и отиваме към Splash
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => const SplashScreen()),
                            (route) => false,
                      );
                    },
                    child: Container(
                      height: 56,
                      decoration: BoxDecoration(
                        color: const Color(0xFF2D2D44),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: const Row(
                        children: [
                          Icon(Icons.logout, color: Colors.redAccent, size: 22),
                          SizedBox(width: 16),
                          Text(
                            'Log Out',
                            style: TextStyle(color: Colors.redAccent, fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 32),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Помощен метод: статистика (брой + надпис)
  Widget _buildStat(String number, String label) {
    return Column(
      children: [
        Text(
          number,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xFFE8D5B7),
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: const TextStyle(fontSize: 12, color: Color(0xFF888888)),
        ),
      ],
    );
  }

  // Помощен метод: ред в настройките
  Widget _buildSettingsRow({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 56,
        decoration: BoxDecoration(
          color: const Color(0xFF2D2D44),
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            Icon(icon, color: const Color(0xFFE8D5B7), size: 22),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
            const Icon(Icons.chevron_right, color: Color(0xFF555555)),
          ],
        ),
      ),
    );
  }
}