import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AppSidebar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: Colors.grey[300]),
            child: Center(
              child: Image.asset(
                "assets/logo.png",
                height: 100,
                width: 100,
              ),
            ),
          ),

          // 🔹 Existing Sidebar Items
          Expanded(
            child: ListView(
              children: [
                ListTile(
                  title: Text("Home"),
                  onTap: () => Navigator.pushNamed(context, "/home"),
                ),
                ListTile(
                  title: Text("Chat"),
                  onTap: () => Navigator.pushNamed(context, "/chat"),
                ),
                ListTile(
                  title: Text("Messages"),
                  onTap: () => Navigator.pushNamed(context, "/message"),
                ),
                ListTile(
                  title: Text("Feedback"),
                  onTap: () => Navigator.pushNamed(context, "/feedback"),
                ),
                ListTile(
                  title: Text("Psychiatrists"),
                  onTap: () => Navigator.pushNamed(context, "/doctors_list"),
                ),
                ListTile(
                  title: Text("Profile"),
                  onTap: () => Navigator.pushNamed(context, "/profile"),
                ),
                ListTile(
                  title: Text("Resources"),
                  onTap: () => Navigator.pushNamed(context, "/resources"),
                ),
                ListTile(
                  title: Text("Routine"),
                  onTap: () => Navigator.pushNamed(context, "/routine"),
                ),
                ListTile(
                  title: Text("About"),
                  onTap: () => Navigator.pushNamed(context, "/about"),
                ),
              ],
            ),
          ),

          // 🔥 Logout Button (Small, Light Red)
          Padding(
            padding: const EdgeInsets.only(bottom: 20), // Spacing from bottom
            child: SizedBox(
              width: 120, // Small button width
              height: 40, // Small button height
              child: ElevatedButton.icon(
                onPressed: () async {
                  await Supabase.instance.client.auth.signOut(); // Logout user
                  Navigator.pushReplacementNamed(
                      context, "/login"); // Redirect to login
                },
                icon: Icon(Icons.logout, size: 18, color: Colors.white),
                label: Text("Logout",
                    style: TextStyle(fontSize: 14, color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red[300], // Light red color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
