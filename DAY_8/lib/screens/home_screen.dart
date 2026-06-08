import 'package:flutter/material.dart';
import '../models/user.dart';
import '../routes/app_routes.dart';
import '../widgets/app_drawer.dart';
import '../widgets/custom_bottom_nav.dart';

/// Home Screen
/// This is the main screen of the application demonstrating:
/// - Basic Navigation (push/pop)
/// - Passing data forward
/// - Receiving data backward
/// - Navigation Drawer integration
/// - Bottom Navigation Bar integration
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Sample user for demonstrating data passing
  final User sampleUser = User(
    name: 'John Doe',
    age: 28,
    email: 'john@example.com',
    city: 'New York',
  );

  // Store returned data from other screens
  String? returnedMessage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Navigation Showcase'),
        centerTitle: true,
        elevation: 0,
      ),
      drawer: const AppDrawer(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Welcome Section
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '👋 Welcome to Navigation Showcase!',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'This app demonstrates all major Flutter navigation concepts and best practices.',
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Basic Navigation Section
            _buildSectionTitle('Feature 1: Basic Navigation (push/pop)'),
            const SizedBox(height: 12),
            _buildNavigationCard(
              title: 'Navigate to Details Screen',
              description:
                  'Demonstrates Navigator.push() and MaterialPageRoute',
              onTap: () {
                // Feature 1: Basic Navigation
                // Navigator.push() creates a new route and pushes it onto the stack
                // This shows the transitions and back button functionality
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const DetailsScreen(),
                  ),
                );
              },
            ),
            const SizedBox(height: 24),

            // Data Forward Section
            _buildSectionTitle('Feature 2: Passing Data Forward'),
            const SizedBox(height: 12),
            _buildNavigationCard(
              title: 'Pass User Data to Details Screen',
              description: 'Send User object to another screen',
              onTap: () {
                // Feature 2: Passing Data Forward
                // We pass the sampleUser object through constructor
                // Navigator passes it to the destination screen
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailsScreen(user: sampleUser),
                  ),
                );
              },
            ),
            const SizedBox(height: 24),

            // Data Backward Section
            _buildSectionTitle('Feature 3: Returning Data Backward'),
            const SizedBox(height: 12),
            _buildNavigationCard(
              title: 'Open Form & Get Result',
              description: 'Return data from Form Screen using pop()',
              onTap: () async {
                // Feature 3: Returning Data Backward
                // Navigator.push() returns a Future<dynamic>
                // The result is what we pop with in the destination screen
                final result = await Navigator.push<String>(
                  context,
                  MaterialPageRoute(builder: (context) => const FormScreen()),
                );

                // Store the returned data
                if (result != null) {
                  setState(() {
                    returnedMessage = result;
                  });
                }
              },
            ),
            if (returnedMessage != null) ...[
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.green),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '✅ Data Returned:',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text(returnedMessage!),
                  ],
                ),
              ),
            ],
            const SizedBox(height: 24),

            // Named Routes Section
            _buildSectionTitle('Feature 4: Named Routes'),
            const SizedBox(height: 12),
            _buildNavigationCard(
              title: 'Navigate using Named Routes',
              description: 'Use pushNamed() for centralized route management',
              onTap: () {
                // Feature 4: Named Routes
                // Named routes are defined in main.dart routes map
                // This approach is useful for larger applications
                Navigator.pushNamed(
                  context,
                  AppRoutes.profile,
                  arguments: sampleUser,
                );
              },
            ),
            const SizedBox(height: 24),

            // TabBar Navigation Section
            _buildSectionTitle('Feature 7: TabBar Navigation'),
            const SizedBox(height: 12),
            _buildNavigationCard(
              title: 'View TabBar Navigation Demo',
              description: 'Explore News, Sports, and Technology tabs',
              onTap: () {
                // Feature 7: TabBar Navigation
                // Navigate to TabBar demo screen using push
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const TabBarScreen()),
                );
              },
            ),
            const SizedBox(height: 24),

            // Nested Navigation Section
            _buildSectionTitle('Feature 8: Nested Navigation'),
            const SizedBox(height: 12),
            _buildNavigationCard(
              title: 'Explore Nested Navigation',
              description: 'Independent navigation stacks per tab',
              onTap: () {
                // Feature 8: Nested Navigation
                // Navigate to nested navigation demo
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const NestedNavigationScreen(),
                  ),
                );
              },
            ),
            const SizedBox(height: 24),

            // Info Section
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.blue),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'ℹ️ Navigation Tips:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text('• Use drawer menu for different navigation patterns'),
                  Text('• Bottom navigation bar demonstrates tab switching'),
                  Text('• Back button restores previous screen state'),
                ],
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
      bottomNavigationBar: const CustomBottomNav(),
    );
  }

  /// Helper widget to build section titles
  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
    );
  }

  /// Helper widget to build navigation cards
  Widget _buildNavigationCard({
    required String title,
    required String description,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        title: Text(title),
        subtitle: Text(description),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}

/// Details Screen
/// Demonstrates receiving data from previous screen and basic pop navigation
class DetailsScreen extends StatelessWidget {
  final User? user;

  const DetailsScreen({Key? key, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Details Screen'), elevation: 0),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Information Card
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Navigation Concept: Basic Navigation',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'This screen was reached using Navigator.push() with MaterialPageRoute. The back button will call Navigator.pop() automatically.',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            if (user != null) ...[
              // User Data Display
              const Text(
                'Passed User Data:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              Card(
                elevation: 1,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildInfoRow('Name:', user!.name),
                      const SizedBox(height: 12),
                      _buildInfoRow('Age:', user!.age.toString()),
                      const SizedBox(height: 12),
                      _buildInfoRow('Email:', user!.email),
                      const SizedBox(height: 12),
                      _buildInfoRow('City:', user!.city),
                    ],
                  ),
                ),
              ),
            ] else ...[
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.orange.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.orange),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '⚠️ No User Data',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Go back and select "Pass User Data to Details Screen" to see data passing in action.',
                    ),
                  ],
                ),
              ),
            ],
            const SizedBox(height: 24),

            // Code Example
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Code Example:',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.black87,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Text(
                        'Navigator.push(\n  context,\n  MaterialPageRoute(\n    builder: (context) => DetailsScreen(user: data),\n  ),\n);',
                        style: TextStyle(
                          fontFamily: 'Courier',
                          color: Colors.white,
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Navigation Help
            Center(
              child: Column(
                children: [
                  const Text(
                    'How to go back:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  ElevatedButton.icon(
                    onPressed: () {
                      // Feature 1: Pop navigation
                      // Navigator.pop() removes current route from stack
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back),
                    label: const Text('Back to Home'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Helper to build info rows
  Widget _buildInfoRow(String label, String value) {
    return Row(
      children: [
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.grey,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(child: Text(value)),
      ],
    );
  }
}

/// Form Screen
/// Demonstrates returning data from a screen
class FormScreen extends StatefulWidget {
  const FormScreen({Key? key}) : super(key: key);

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  late TextEditingController _messageController;

  @override
  void initState() {
    super.initState();
    _messageController = TextEditingController();
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Form Screen'), elevation: 0),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Information
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Navigation Concept: Returning Data',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 12),
                    Text(
                      'Enter a message below and submit. The data will be returned to the home screen using Navigator.pop(context, data).',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Form
            const Text(
              'Enter Your Message:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _messageController,
              decoration: InputDecoration(
                hintText: 'Type something...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                prefixIcon: const Icon(Icons.message),
              ),
              maxLines: 4,
            ),
            const SizedBox(height: 24),

            // Submit Button
            Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  final message = _messageController.text.trim();

                  if (message.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Please enter a message')),
                    );
                    return;
                  }

                  // Feature 3: Return data backward
                  // Navigator.pop() can take a second argument
                  // This data is returned to the calling screen
                  Navigator.pop(context, 'Message: "$message"');
                },
                icon: const Icon(Icons.send),
                label: const Text('Submit & Return Data'),
              ),
            ),
            const SizedBox(height: 24),

            // Code Example
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'How to return data:',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.black87,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Text(
                        'Navigator.pop(context, data);',
                        style: TextStyle(
                          fontFamily: 'Courier',
                          color: Colors.white,
                          fontSize: 11,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// TabBar Screen
/// Demonstrates TabBar and TabBarView navigation
class TabBarScreen extends StatefulWidget {
  const TabBarScreen({Key? key}) : super(key: key);

  @override
  State<TabBarScreen> createState() => _TabBarScreenState();
}

class _TabBarScreenState extends State<TabBarScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    // Create a TabController with 3 tabs
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TabBar Navigation'),
        elevation: 0,
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'News', icon: Icon(Icons.newspaper)),
            Tab(text: 'Sports', icon: Icon(Icons.sports_basketball)),
            Tab(text: 'Tech', icon: Icon(Icons.computer)),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // News Tab
          _buildTabContent(
            title: 'News',
            icon: Icons.newspaper,
            items: [
              'Breaking News: Flutter 4.0 Released',
              'Google Announces New AI Features',
              'Tech Industry Updates',
            ],
          ),
          // Sports Tab
          _buildTabContent(
            title: 'Sports',
            icon: Icons.sports_basketball,
            items: [
              'Championship Game Results',
              'Latest Team Rankings',
              'Player Highlights',
            ],
          ),
          // Technology Tab
          _buildTabContent(
            title: 'Technology',
            icon: Icons.computer,
            items: [
              'New Programming Languages',
              'Cloud Computing Trends',
              'Mobile Development News',
            ],
          ),
        ],
      ),
    );
  }

  /// Helper to build tab content
  Widget _buildTabContent({
    required String title,
    required IconData icon,
    required List<String> items,
  }) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: items.length,
      itemBuilder: (context, index) {
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: ListTile(
            leading: Icon(icon),
            title: Text(items[index]),
            trailing: const Icon(Icons.arrow_forward_ios, size: 14),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Opened: ${items[index]}')),
              );
            },
          ),
        );
      },
    );
  }
}

/// Nested Navigation Screen
/// Demonstrates independent navigation stacks per tab
class NestedNavigationScreen extends StatefulWidget {
  const NestedNavigationScreen({Key? key}) : super(key: key);

  @override
  State<NestedNavigationScreen> createState() => _NestedNavigationScreenState();
}

class _NestedNavigationScreenState extends State<NestedNavigationScreen> {
  int _selectedIndex = 0;

  // Navigation stacks for each tab
  final List<List<String>> _navigationStacks = [
    ['Home Tab - Screen A'], // Home tab stack
    ['Search Tab - Home'], // Search tab stack
  ];

  void _pushToStack(int tabIndex, String screenName) {
    setState(() {
      _navigationStacks[tabIndex].add(screenName);
    });
  }

  void _popFromStack(int tabIndex) {
    if (_navigationStacks[tabIndex].length > 1) {
      setState(() {
        _navigationStacks[tabIndex].removeLast();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nested Navigation Demo'),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // Pop from nested stack or go back
            if (_navigationStacks[_selectedIndex].length > 1) {
              _popFromStack(_selectedIndex);
            } else {
              Navigator.pop(context);
            }
          },
        ),
      ),
      body: Column(
        children: [
          // Display current screen
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Current Screen:',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            _navigationStacks[_selectedIndex].last,
                            style: const TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Navigation Stack:',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  ..._navigationStacks[_selectedIndex].asMap().entries.map((e) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Row(
                        children: [
                          Text('${e.key + 1}. ${e.value}'),
                          if (e.key ==
                              _navigationStacks[_selectedIndex].length - 1)
                            const SizedBox(width: 8),
                          if (e.key ==
                              _navigationStacks[_selectedIndex].length - 1)
                            const Chip(label: Text('Current')),
                        ],
                      ),
                    );
                  }),
                  const SizedBox(height: 24),
                  if (_selectedIndex == 0) ...[
                    ElevatedButton(
                      onPressed: () => _pushToStack(0, 'Home Tab - Screen B'),
                      child: const Text('Go to Screen B'),
                    ),
                  ] else ...[
                    ElevatedButton(
                      onPressed: () => _pushToStack(1, 'Search Tab - Details'),
                      child: const Text('Go to Search Details'),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
        ],
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}
