import 'package:flutter/material.dart';
import 'new_multiselect_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';  // Import this package
import 'package:yoke_app4/main.dart';  // Import this package
import 'package:cloud_firestore/cloud_firestore.dart';

class PreferencesPage extends StatefulWidget {
  @override
  _PreferencesPageState createState() => _PreferencesPageState();
}

class _PreferencesPageState extends State<PreferencesPage> {
  List<String> _preferredGenders = ["Any"];

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Sign out method
  void _signOut() async {
    await _auth.signOut();
    Navigator.of(context).pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
  }

  // Save preferences to Firestore
  void _savePreferences() async {
  User? user = _auth.currentUser;
  if (user != null) {
    await _firestore.collection('users').doc(user.uid).update({
      'preferredGenders': _preferredGenders,
    });

    // Navigate to Home Page after preferences are set
    Navigator.pushNamed(context, '/home');
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Preferences'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // Match Preferences
            ListTile(
              title: Text('Preferred Gender', style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: MultiSelectDropdown(
                items: ['Men', 'Women', 'Non-Binary', 'Any'],
                selectedItems: _preferredGenders,
                onSelectionChanged: (selectedList) {
                  setState(() {
                    _preferredGenders = selectedList;
                  });
                },
              ),
            ),
            
            Divider(),

            // Save Preferences Button
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: ElevatedButton(
                onPressed: _savePreferences, // Call the save preferences method
                child: Text(
                  'Save Preferences & Proceed',
                  style: TextStyle(color: Colors.black),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Colors.white, // This sets the background color of the button
                  onPrimary: Colors.black, // This sets the color of the text
                ),
              ),
            ),

            // Sign Out Button
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: ElevatedButton(
                onPressed: _signOut,
                child: Text('Sign Out'),
                style: ElevatedButton.styleFrom(
                  primary: Colors.white, // This sets the background color of the button
                  onPrimary: Colors.black, // This sets the color of the text
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}







