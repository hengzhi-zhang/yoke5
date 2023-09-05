import 'package:flutter/material.dart';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'chat_screen.dart';
import 'package:yoke_app4/person.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomePage extends StatefulWidget {
  final Function onNewMatch;

  HomePage({required this.onNewMatch});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Person> matchedPartners = [];

  @override
  void initState() {
    super.initState();
    loadMatches();
  }

  Future<void> loadMatches() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return;
    }
    final userId = user.uid;

    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('matches')
        .get();

    for (var doc in snapshot.docs) {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(doc.id)
          .get();

      Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;
      final name = userData['name'] ?? '';
      final imageUrl = userData['imageURL'] ?? '';

      matchedPartners.add(
        Person(
          name: name,
          imageUrl: imageUrl,
          userId: doc.id,
          conversationIds: [], // Initialize with an empty list
        ),
      );
    }
  }

void _findPartner() async {
  final usersRef = FirebaseFirestore.instance.collection('users');
  QuerySnapshot snapshot = await usersRef.get();
  final List<QueryDocumentSnapshot> usersDocs = snapshot.docs;

  User? user = FirebaseAuth.instance.currentUser;
  if (user == null) {
    return;
  }
  final userId = user.uid;

  final alreadyMatchedIds = matchedPartners.map((partner) => partner.userId).toList();
  final filteredUsersDocs = usersDocs.where((doc) => !alreadyMatchedIds.contains(doc.id) && doc.id != userId).toList();

  if (filteredUsersDocs.isEmpty) {
    // Show a dialog saying there are no more matches left.
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('No Matches Available'),
          content: Text('Sorry, there are no more available matches at the moment.'),
          actions: [
            TextButton(
              child: Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
    return;
  }

  final randomIndex = Random().nextInt(filteredUsersDocs.length);
  final randomUserDoc = filteredUsersDocs[randomIndex];
  final userData = randomUserDoc.data() as Map<String, dynamic>;

  final name = userData['name'] ?? '';
  final imageURL = userData['imageURL'] ?? '';
  final partnerId = randomUserDoc.id; // Store the partner's ID

  // Generate a conversation ID based on the user's ID and partner's ID
  final conversationId = '${userId}_$partnerId';

  Person newMatch = Person(name: name, imageUrl: imageURL, userId: partnerId, conversationIds: [conversationId]);
  matchedPartners.add(newMatch);

  await FirebaseFirestore.instance.collection('users').doc(userId).collection('matches').doc(partnerId).set({
    'matchId': partnerId,
    'timestamp': FieldValue.serverTimestamp(),
  });

  // Call onNewMatch to notify of the new match
  widget.onNewMatch();

  // Refresh UI and show the new match dialog
  setState(() {
    _showNewMatchDialog(context, newMatch, conversationId);

  });
}


void _showNewMatchDialog(BuildContext context, Person newMatch, String conversationId) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('New Match!'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('You have a new match with ${newMatch.name}.'),
            SizedBox(height: 16),
            Container(
              width: 120,
              height: 120,
              child: CachedNetworkImage(
                imageUrl: newMatch.imageUrl,
                placeholder: (context, url) => CircularProgressIndicator(),
                errorWidget: (context, url, error) => Icon(Icons.error),
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            child: Text('Chat'),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChatScreen(
                    partnerName: newMatch.name,
                    partnerId: newMatch.userId,
                    partnerImageUrl: newMatch.imageUrl,
                    conversationID: conversationId, // Pass the conversation ID here
                  ),
                ),
              );
            },
          ),
          TextButton(
            child: Text('Close'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: _findPartner,
          child: Text(
            'Find a Partner',
            style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          style: ElevatedButton.styleFrom(
            primary: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
          ),
        ),
      ),
    );
  }
}







