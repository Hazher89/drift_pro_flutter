import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const DriftProApp());
}

class DriftProApp extends StatelessWidget {
  const DriftProApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DriftPro',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF2196F3), // Professional blue
          brightness: Brightness.light,
        ),
        textTheme: GoogleFonts.interTextTheme(),
      ),
      debugShowCheckedModeBanner: false,
      home: const DriftProHomePage(),
    );
  }
}

class DriftProHomePage extends StatefulWidget {
  const DriftProHomePage({super.key});

  @override
  State<DriftProHomePage> createState() => _DriftProHomePageState();
}

class _DriftProHomePageState extends State<DriftProHomePage> {
  int _selectedIndex = 0;

  static const List<Widget> _pages = <Widget>[
    DashboardPage(),
    EmployeesPage(),
    MessagesPage(),
    ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'DriftPro',
          style: GoogleFonts.inter(
            fontWeight: FontWeight.w600,
            fontSize: 24,
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {
              // TODO: Implement notifications
            },
          ),
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            onPressed: () {
              // TODO: Implement settings
            },
          ),
        ],
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: _onItemTapped,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.dashboard_outlined),
            selectedIcon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          NavigationDestination(
            icon: Icon(Icons.people_outline),
            selectedIcon: Icon(Icons.people),
            label: 'Employees',
          ),
          NavigationDestination(
            icon: Icon(Icons.message_outlined),
            selectedIcon: Icon(Icons.message),
            label: 'Messages',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Velkommen tilbake!',
            style: GoogleFonts.inter(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Her er en oversikt over dagens aktiviteter',
            style: GoogleFonts.inter(
              fontSize: 16,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 24),
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              children: [
                _buildDashboardCard(
                  context,
                  'Ansatte',
                  '24',
                  Icons.people,
                  Colors.blue,
                ),
                _buildDashboardCard(
                  context,
                  'Meldinger',
                  '12',
                  Icons.message,
                  Colors.green,
                ),
                _buildDashboardCard(
                  context,
                  'Oppgaver',
                  '8',
                  Icons.task_alt,
                  Colors.orange,
                ),
                _buildDashboardCard(
                  context,
                  'Rapporter',
                  '3',
                  Icons.analytics,
                  Colors.purple,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDashboardCard(
    BuildContext context,
    String title,
    String value,
    IconData icon,
    Color color,
  ) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 40,
              color: color,
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: GoogleFonts.inter(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            Text(
              title,
              style: GoogleFonts.inter(
                fontSize: 14,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class EmployeesPage extends StatelessWidget {
  const EmployeesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Ansatte',
            style: GoogleFonts.inter(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: 5, // Placeholder data
              itemBuilder: (context, index) {
                return Card(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      child: Text(
                        'A${index + 1}',
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                    title: Text('Ansatt ${index + 1}'),
                    subtitle: Text('ansatt${index + 1}@driftpro.no'),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {
                      // TODO: Navigate to employee details
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class MessagesPage extends StatelessWidget {
  const MessagesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Meldinger kommer snart!',
        style: TextStyle(fontSize: 18),
      ),
    );
  }
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          const CircleAvatar(
            radius: 50,
            backgroundColor: Colors.blue,
            child: Icon(
              Icons.person,
              size: 50,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Administrator',
            style: GoogleFonts.inter(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'admin@driftpro.no',
            style: GoogleFonts.inter(
              fontSize: 16,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 32),
          ListTile(
            leading: const Icon(Icons.edit),
            title: const Text('Rediger profil'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.security),
            title: const Text('Sikkerhet'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logg ut'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
