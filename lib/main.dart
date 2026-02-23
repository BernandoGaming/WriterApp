import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const WriterApp());
}

class WriterApp extends StatelessWidget {
  const WriterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        textTheme: GoogleFonts.interTextTheme(),
        scaffoldBackgroundColor: const Color(0xFFFDFBF7), // Cream Background
      ),
      home: const DashboardScreen(),
    );
  }
}

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const Icon(Icons.menu, color: Color(0xFF1E293B)),
        title: Text(
          'Writer',
          style: GoogleFonts.inter(fontWeight: FontWeight.bold, color: const Color(0xFF1E293B)),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: CircleAvatar(
              radius: 18,
              backgroundColor: Colors.grey[300],
              backgroundImage: const NetworkImage('https://i.pravatar.cc/150?u=nando'),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Text(
              'Good Morning, Alex',
              style: GoogleFonts.serif(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF0F172A),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Ready to continue your story?',
              style: TextStyle(color: Colors.grey[600], fontSize: 16),
            ),
            const SizedBox(height: 30),
            
            // Stats Row
            Row(
              children: [
                _buildStatCard(
                  title: 'Daily Words',
                  value: '1,250',
                  subValue: '/ 2k goal',
                  percentage: '+12%',
                  icon: Icons.edit_note,
                  progress: 0.62,
                  accentColor: const Color(0xFFBE8450),
                ),
                const SizedBox(width: 15),
                _buildStatCard(
                  title: 'Current Streak',
                  value: '12',
                  subValue: 'Days',
                  percentage: '',
                  icon: Icons.local_fire_department,
                  progress: 0,
                  isStreak: true,
                  accentColor: Colors.orange,
                ),
              ],
            ),
            
            const SizedBox(height: 30),
            _buildSectionHeader('Up Next', 'View All'),
            const SizedBox(height: 15),
            
            // Task Card
            _buildTaskCard(),
            
            const SizedBox(height: 30),
            _buildSectionHeader('Recent Documents', null),
            const SizedBox(height: 15),
            
            // Documents Grid
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              mainAxisSpacing: 15,
              crossAxisSpacing: 15,
              childAspectRatio: 0.75,
              children: [
                _buildDocCard('The Glass Hotel', 'Chapter 3 • 2h ago', Colors.brown, 'https://picsum.photos/200/300?random=1'),
                _buildDocCard('Character Notes', 'Yesterday', const Color(0xFF1E293B), null, isIdea: true),
              ],
            ),
            const SizedBox(height: 100), // Spacing for FAB
          ],
        ),
      ),
      
      // Floating Action Button
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        margin: const EdgeInsets.only(top: 30),
        child: FloatingActionButton(
          onPressed: () {},
          backgroundColor: const Color(0xFF0F172A),
          shape: const CircleBorder(),
          elevation: 4,
          child: const Icon(Icons.add, color: Colors.white, size: 30),
        ),
      ),
      
      // Bottom Navigation
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 8,
        color: Colors.white,
        child: SizedBox(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(Icons.dashboard, 'Dashboard', true),
              _buildNavItem(Icons.check_circle_outline, 'Tasks', false),
              const SizedBox(width: 40), // Space for FAB
              _buildNavItem(Icons.bar_chart, 'Stats', false),
              _buildNavItem(Icons.settings, 'Settings', false),
            ],
          ),
        ),
      ),
    );
  }

  // --- WIDGET HELPERS ---

  Widget _buildStatCard({required String title, required String value, required String subValue, required String percentage, required IconData icon, required double progress, bool isStreak = false, required Color accentColor}) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        height: 150,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: const Color(0xFFEADDC5).withOpacity(0.5)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(color: accentColor.withOpacity(0.1), borderRadius: BorderRadius.circular(10)),
                  child: Icon(icon, color: accentColor, size: 20),
                ),
                if (percentage.isNotEmpty)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, py: 2),
                    decoration: BoxDecoration(color: Colors.green[50], borderRadius: BorderRadius.circular(10)),
                    child: Text(percentage, style: const TextStyle(color: Colors.green, fontSize: 10, fontWeight: FontWeight.bold)),
                  )
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(color: Colors.grey[500], fontSize: 12)),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Text(value, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF1E293B))),
                    const SizedBox(width: 4),
                    Text(subValue, style: TextStyle(fontSize: 10, color: Colors.grey[400])),
                  ],
                ),
                if (progress > 0) ...[
                  const SizedBox(height: 8),
                  LinearProgressIndicator(value: progress, backgroundColor: Colors.grey[100], color: accentColor, minHeight: 4),
                ] else if (isStreak) ...[
                  const SizedBox(height: 8),
                  const Text('Keep the fire burning!', style: TextStyle(color: Colors.orange, fontSize: 10, fontWeight: FontWeight.w500)),
                ]
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title, String? action) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF1E293B))),
        if (action != null) Text(action, style: const TextStyle(color: Color(0xFFBE8450), fontWeight: FontWeight.bold, fontSize: 14)),
        if (action == null) const Icon(Icons.grid_view, color: Colors.grey, size: 20),
      ],
    );
  }

  Widget _buildTaskCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFEADDC5).withOpacity(0.5)),
      ),
      child: Row(
        children: [
          Container(
            height: 50, width: 50,
            decoration: BoxDecoration(color: const Color(0xFFFDFBF7), borderRadius: BorderRadius.circular(12), border: Border.all(color: const Color(0xFFEADDC5))),
            child: const Icon(Icons.calendar_today, color: Color(0xFFBE8450)),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Finish Outline: Project Al...', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(color: Colors.red[50], borderRadius: BorderRadius.circular(6)),
                      child: const Text('• Due Tomorrow', style: TextStyle(color: Colors.red, fontSize: 10, fontWeight: FontWeight.bold)),
                    ),
                    const SizedBox(width: 8),
                    Text('Chapter 4', style: TextStyle(color: Colors.grey[400], fontSize: 12)),
                  ],
                )
              ],
            ),
          ),
          const Icon(Icons.chevron_right, color: Colors.grey),
        ],
      ),
    );
  }

  Widget _buildDocCard(String title, String date, Color color, String? imgUrl, {bool isIdea = false}) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image: imgUrl != null ? DecorationImage(image: NetworkImage(imgUrl), fit: BoxFit.cover) : null,
        color: imgUrl == null ? color : null,
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [Colors.transparent, Colors.black.withOpacity(0.8)]),
        ),
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), borderRadius: BorderRadius.circular(8)),
              child: Icon(isIdea ? Icons.lightbulb : Icons.description, color: Colors.white, size: 16),
            ),
            const SizedBox(height: 8),
            Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)),
            Text(date, style: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 10)),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, bool isActive) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: isActive ? const Color(0xFFBE8450) : Colors.grey[400]),
        Text(label, style: TextStyle(fontSize: 10, color: isActive ? const Color(0xFFBE8450) : Colors.grey[400])),
      ],
    );
  }
}
