import 'package:flutter/material.dart';

class SlideBarPage extends StatefulWidget {
  const SlideBarPage({super.key});

  @override
  State<SlideBarPage> createState() => _SlideBarPageState();
}

class _SlideBarPageState extends State<SlideBarPage> {
  int _selectedIndex = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tabCount = 3;
    final indicatorWidth = 120.0;
    final indicatorHeight = 44.0;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Animated tab bar with sliding indicator
              SizedBox(
                height: indicatorHeight + 12,
                width: double.infinity,
                child: Stack(
                  alignment: Alignment.centerLeft,
                  children: [
                    // Animated indicator
                    AnimatedAlign(
                      alignment: Alignment(
                          -1.0 + (_selectedIndex * 2 / (tabCount - 1)), 0),
                      duration: const Duration(milliseconds: 1000),
                      curve: Curves.easeInOut,
                      child: Container(
                        width: indicatorWidth,
                        height: indicatorHeight,
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(28),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.red.withOpacity(0.2),
                              blurRadius: 12,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // Tab buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildTabButton(0, Icons.mail, 'Applied Job'),
                        _buildTabButton(1, Icons.favorite, 'Favorites'),
                        _buildTabButton(
                            2, Icons.auto_awesome, 'AI-Matching Job'),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              // Content area with PageView
              Expanded(
                child: PageView(
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() {
                      _selectedIndex = index;
                    });
                  },
                  children: [
                    _buildContentPage('Applied Job', Icons.mail, Colors.red),
                    _buildContentPage('Favorites', Icons.favorite, Colors.pink),
                    _buildContentPage(
                        'AI-Matching Job', Icons.auto_awesome, Colors.blue),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTabButton(int index, IconData icon, String label) {
    final isActive = _selectedIndex == index;
    return GestureDetector(
      onTap: () {
        _pageController.animateToPage(
          index,
          duration: const Duration(milliseconds: 350),
          curve: Curves.easeInOut,
        );
        setState(() {
          _selectedIndex = index;
        });
      },
      child: Container(
        width: 120,
        height: 44,
        alignment: Alignment.center,
        color: Colors.transparent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 20,
              color: isActive ? Colors.white : Colors.grey[600],
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                color: isActive ? Colors.white : Colors.grey[600],
                fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContentPage(String title, IconData icon, Color color) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(25),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: color.withOpacity(0.2),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Icon(
              icon,
              size: 70,
              color: color,
            ),
          ),
          const SizedBox(height: 30),
          Text(
            title,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: color,
              letterSpacing: 1.0,
            ),
          ),
          const SizedBox(height: 15),
          Text(
            'This is the $title page content',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
              height: 1.5,
            ),
          ),
          const SizedBox(height: 40),
          FloatingActionButton.extended(
            onPressed: () {
              _showSnackBar('Action on $title page');
            },
            backgroundColor: color,
            elevation: 8,
            icon: const Icon(Icons.add, color: Colors.white),
            label: const Text(
              'Action',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check_circle, color: Colors.white),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                message,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        backgroundColor: Colors.green,
        elevation: 8,
        margin: const EdgeInsets.all(16),
      ),
    );
  }
}
