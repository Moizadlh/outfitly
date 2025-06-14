import 'package:flutter/material.dart';

class CreateOutfitScreen extends StatefulWidget {
  @override
  _CreateOutfitScreenState createState() => _CreateOutfitScreenState();
}

class _CreateOutfitScreenState extends State<CreateOutfitScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.brown.shade500,
        title: Text('Outfitly',style: TextStyle(color: Colors.white)),
        centerTitle: false,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton.icon(
              onPressed: () {
                // Navigate to the AI-generated outfit screen
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => GenerateWithAIScreen()),
                );
              },
              icon: Icon(
                Icons.auto_awesome, // AI-related icon
                color: Colors.white,
              ),
              label: Text(
                'Generate an outfit with AI',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 36, vertical: 15),
                backgroundColor: Colors.brown,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                shadowColor: Colors.brown.withOpacity(0.8),
                elevation: 10,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () {
                // Navigate to the create outfit screen
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CreateOutfitByYourselfScreen()),
                );
              },
              icon: Icon(
                Icons.edit, // Icon for creating or editing outfits
                color: Colors.white,
              ),
              label: Text(
                'Create an outfit by yourself',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                backgroundColor: Colors.brown,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                shadowColor: Colors.brown.withOpacity(0.8),
                elevation: 10,
              ),
            ),
          ],
        )
      ),
    );
  }
}

class GenerateWithAIScreen extends StatefulWidget {
  @override
  _GenerateWithAIScreenState createState() => _GenerateWithAIScreenState();
}

class _GenerateWithAIScreenState extends State<GenerateWithAIScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Generate with AI'),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'AI Outfit Generation Feature Coming Soon!',
            style: TextStyle(fontSize: 18),
          ),
        ),
      ),
    );
  }
}

class CreateOutfitByYourselfScreen extends StatefulWidget {
  @override
  _CreateOutfitByYourselfScreenState createState() => _CreateOutfitByYourselfScreenState();
}

class _CreateOutfitByYourselfScreenState extends State<CreateOutfitByYourselfScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Your Own Outfit'),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Text(
            'Create your own outfit by choosing styles and options.',
            style: TextStyle(fontSize: 18),
          ),
        ),
      ),
    );
  }
}
