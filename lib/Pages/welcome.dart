import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:loginapp/Pages/GetUserData.dart';
import 'package:loginapp/Pages/LoginPage.dart';
import 'package:loginapp/Pages/editProfile.dart';

class Welcome extends StatefulWidget {
  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  late User user;
  late CollectionReference<Map<String, dynamic>> usersCollection;

  @override
  void initState() {
    super.initState();
    user = FirebaseAuth.instance.currentUser!;
    usersCollection = FirebaseFirestore.instance.collection("Users");
  }

  void signOutUser(BuildContext context) {
    FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => LoginPage(
          onTap: () {},
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:
            const Color.fromARGB(255, 0, 0, 0), // Set the background color here

        title: const Text('Home Page',
            style: TextStyle(color: Color.fromARGB(255, 255, 255, 255))),
        actions: [
          IconButton(
            onPressed: () => signOutUser(context),
            icon: const Icon(
              Icons.logout,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('lib/Images/background.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Container(
            padding: EdgeInsets.fromLTRB(
                10, MediaQuery.of(context).size.height * 0.3, 10, 10),
            color: Color.fromARGB(149, 6, 6, 6),
            height: MediaQuery.of(context).size.height * 1,
            width: MediaQuery.of(context).size.width * 1,
            child: Column(
              children: [
                Text(
                  'Welcome, ${user.email!.split('@')[0].trim()}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontFamily: 'Kanit',
                  ),
                ),
                const SizedBox(
                  height: 90,
                ),
                GetUserData(usersCollection: usersCollection),
                const SizedBox(
                  height: 90,
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditProfile(),
                      ),
                    );
                  },
                  child: Text('Edit Profile'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
