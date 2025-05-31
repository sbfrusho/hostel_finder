// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:hostel_finder/core/constants/app_colors.dart';
// import 'package:hostel_finder/features/authentication/presentation/screens/sign_in_screen.dart';
// import 'package:hostel_finder/features/hostel/Screens/hostel_detail_page.dart';
// import 'package:hostel_finder/features/hostel/data/hostel_model.dart';
// import 'add_post_screen.dart';
// import 'bookmark_screen.dart';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   int _selectedIndex = 0;
//   List<HostelModel> hostels = [];

//   Widget _buildHostelCard(int index) {
//     final hostel = hostels[index];

//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//       child: GestureDetector(
//         onTap: () {
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (_) => HostelDetailPage(
//                 imagePaths: hostel.images,
//                 price: hostel.price,
//                 roomType: hostel.roomType,
//                 description: hostel.description,
//                 roomScore: hostel.roomScore,
//                 cleanlinessStars: hostel.cleanlinessStars,
//               ),
//             ),
//           );
//         },
//         child: Card(
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(12),
//           ),
//           elevation: 4,
//           child: Row(
//             children: [
//               ClipRRect(
//                 borderRadius: const BorderRadius.only(
//                     topLeft: Radius.circular(12),
//                     bottomLeft: Radius.circular(12)),
//                 child: hostel.images.isNotEmpty
//                     ? Image.file(
//                         File(hostel.images.first),
//                         width: 100,
//                         height: 100,
//                         fit: BoxFit.cover,
//                       )
//                     : Container(
//                         width: 100,
//                         height: 100,
//                         color: Colors.grey[300],
//                         child: const Icon(Icons.photo, size: 40),
//                       ),
//               ),
//               const SizedBox(width: 12),
//               Expanded(
//                 child: Padding(
//                   padding: const EdgeInsets.symmetric(vertical: 12),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         hostel.roomType,
//                         style: const TextStyle(
//                           fontSize: 16,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       const SizedBox(height: 4),
//                       Text(
//                         hostel.description.length > 40
//                             ? '${hostel.description.substring(0, 40)}...'
//                             : hostel.description,
//                         style: const TextStyle(fontSize: 14),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               const SizedBox(width: 8),
//               IconButton(
//                 icon: const Icon(Icons.map_outlined),
//                 color: AppColors.primaryColor,
//                 onPressed: () {
//                   // TODO: open map view
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   void _onNavItemTapped(int index) async {
//     setState(() {
//       _selectedIndex = index;
//     });

//     switch (index) {
//       case 0:
//         break;
//       case 1:
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (_) => const BookmarkScreen()),
//         );
//         break;
//       case 2:
//         final newHostel = await Navigator.push<HostelModel>(
//           context,
//           MaterialPageRoute(builder: (_) => const AddPostScreen()),
//         );

//         if (newHostel != null) {
//           setState(() {
//             hostels.add(newHostel);
//             _selectedIndex = 0;
//           });
//         }
//         break;
//       case 3:
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (_) => const SignInScreen()),
//         );
//         break;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: AppColors.primaryColor,
//         title: Row(
//           mainAxisSize: MainAxisSize.min,
//           children: const [
//             Icon(Icons.search, color: Colors.white),
//             SizedBox(width: 8),
//             Text('Hostel Finder', style: TextStyle(color: Colors.white)),
//           ],
//         ),
//       ),
//       body: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Row(
//               children: [
//                 Expanded(
//                   child: TextField(
//                     decoration: InputDecoration(
//                       hintText: 'Search hostels...',
//                       prefixIcon: const Icon(Icons.search),
//                       filled: true,
//                       fillColor: Colors.grey[100],
//                       contentPadding: const EdgeInsets.symmetric(
//                           vertical: 12, horizontal: 16),
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(12),
//                         borderSide: BorderSide.none,
//                       ),
//                     ),
//                     onChanged: (value) {
//                       // TODO: search logic
//                     },
//                   ),
//                 ),
//                 const SizedBox(width: 12),
//                 GestureDetector(
//                   onTap: () {
//                     // TODO: filter logic
//                   },
//                   child: Container(
//                     padding: const EdgeInsets.all(12),
//                     decoration: BoxDecoration(
//                       color: AppColors.primaryColor,
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     child: const Icon(
//                       Icons.filter_list,
//                       color: Colors.white,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Expanded(
//             child: hostels.isEmpty
//                 ? const Center(child: Text('No hostels found. Add some!'))
//                 : ListView.builder(
//                     itemCount: hostels.length,
//                     itemBuilder: (context, index) => _buildHostelCard(index),
//                   ),
//           ),
//         ],
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: _selectedIndex,
//         onTap: _onNavItemTapped,
//         backgroundColor: AppColors.primaryColor,
//         selectedItemColor: Colors.white,
//         unselectedItemColor: Colors.white70,
//         showUnselectedLabels: true,
//         type: BottomNavigationBarType.fixed,
//         items: const [
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home_filled),
//             label: 'Home',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.favorite_border),
//             label: 'Bookmarks',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.add_circle_outline),
//             label: 'Add',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.person_outline),
//             label: 'Profile',
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hostel_finder/core/constants/app_colors.dart';
import 'package:hostel_finder/features/authentication/presentation/screens/sign_in_screen.dart';
import 'package:hostel_finder/features/hostel/Screens/hostel_detail_page.dart';
import 'package:hostel_finder/features/hostel/data/hostel_model.dart';
import 'package:hostel_finder/features/hostel/presentation/providers/hostel_provider.dart';
import 'package:provider/provider.dart';
import 'add_post_screen.dart';
import 'bookmark_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  Widget _buildHostelCard(int index, List<HostelModel> hostels) {
    final hostel = hostels[index];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => HostelDetailPage(
                imagePaths: hostel.images,
                price: hostel.price,
                roomType: hostel.roomType,
                description: hostel.description,
                roomScore: hostel.roomScore,
                cleanlinessStars: hostel.cleanlinessStars,
              ),
            ),
          );
        },
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 4,
          child: Row(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    bottomLeft: Radius.circular(12)),
                child: hostel.images.isNotEmpty
                    ? Image.file(
                        File(hostel.images.first),
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      )
                    : Container(
                        width: 100,
                        height: 100,
                        color: Colors.grey[300],
                        child: const Icon(Icons.photo, size: 40),
                      ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        hostel.roomType,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        hostel.description.length > 40
                            ? '${hostel.description.substring(0, 40)}...'
                            : hostel.description,
                        style: const TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 8),
              IconButton(
                icon: const Icon(Icons.map_outlined),
                color: AppColors.primaryColor,
                onPressed: () {
                  // TODO: open map view
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onNavItemTapped(int index) async {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        break;
      case 1:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const BookmarkScreen()),
        );
        break;
      case 2:
        final newHostel = await Navigator.push<HostelModel>(
          context,
          MaterialPageRoute(builder: (_) => const AddPostScreen()),
        );

        if (newHostel != null) {
          Provider.of<HostelProvider>(context, listen: false).addHostel(newHostel);
          setState(() {
            _selectedIndex = 0;
          });
        }
        break;
      case 3:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const SignInScreen()),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final hostelProvider = Provider.of<HostelProvider>(context);
    final hostels = hostelProvider.hostels;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Icon(Icons.search, color: Colors.white),
            SizedBox(width: 8),
            Text('Hostel Finder', style: TextStyle(color: Colors.white)),
          ],
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search hostels...',
                      prefixIcon: const Icon(Icons.search),
                      filled: true,
                      fillColor: Colors.grey[100],
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 16),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    onChanged: (value) {
                      // TODO: search logic
                    },
                  ),
                ),
                const SizedBox(width: 12),
                GestureDetector(
                  onTap: () {
                    // TODO: filter logic
                  },
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.filter_list,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: hostels.isEmpty
                ? const Center(child: Text('No hostels found. Add some!'))
                : ListView.builder(
                    itemCount: hostels.length,
                    itemBuilder: (context, index) => _buildHostelCard(index, hostels),
                  ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onNavItemTapped,
        backgroundColor: AppColors.primaryColor,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_filled),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border),
            label: 'Bookmarks',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle_outline),
            label: 'Add',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}