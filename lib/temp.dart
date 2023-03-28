@override
Widget build(BuildContext context) {
  Widget body;
  if (_isLoggedIn) { // Replace _isLoggedIn with your own logic
    body = _widgetOptions[_selectedIndex];
  } else {
    body = LoginPage();
  }

  return Scaffold(
    appBar: AppBar(
      title: const Text('My Food Tracker'),
    ),
    body: body,
    bottomNavigationBar: BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.track_changes),
          label: 'Tracking',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.more_horiz),
          label: 'More',
        ),
      ],
      currentIndex: _selectedIndex,
      onTap: _onItemTapped,
    ),
  );
}
