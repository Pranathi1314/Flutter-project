import 'package:flutter/material.dart';
import 'package:readnote/components/my_list_tile.dart';

class MyDrawer extends StatelessWidget {
  final void Function() ? onProfileTap;
  final void Function() ? onSignOut;
  final void Function() ? onShelfTap;
  final void Function() ? onDiscoverTap;


  const MyDrawer({super.key,
    required this.onProfileTap,
    required this.onSignOut,
    required this.onShelfTap,
    required this.onDiscoverTap,

  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.grey[900],
      child: Column(
        children: [
          const DrawerHeader(
            child: Icon(
              Icons.person,
              color: Colors.white,
              size: 64,
          ),
          ),

          //home
          MyListTile(
            icon: Icons.home,
            text: 'H O M E',
            onTap: () => Navigator.pop(context),
          ),

          //profile
          MyListTile(
            icon: Icons.person, 
            text: 'P R O F I L E', 
            onTap: onProfileTap,
          ),

          //bookshelf
          MyListTile(
            icon: Icons.bookmark, 
            text: 'S H E L V E S', 
            onTap: onShelfTap,
          ),
          
          //recommended books
          MyListTile(
            icon: Icons.public, 
            text: 'D I S C O V E R', 
            onTap: onDiscoverTap,
          ),
          
          //logout
          MyListTile(
            icon: Icons.logout, 
            text: 'L O G O U T', 
            onTap: onSignOut,
          ),


        ],
      ),
    );
  }
}