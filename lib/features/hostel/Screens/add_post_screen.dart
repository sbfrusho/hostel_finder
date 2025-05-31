// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:hostel_finder/core/constants/app_colors.dart';
// import 'package:hostel_finder/features/authentication/presentation/screens/sign_in_screen.dart';
// import 'package:hostel_finder/features/hostel/data/hostel_model.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:permission_handler/permission_handler.dart';

// import 'home_screen.dart';
// import 'bookmark_screen.dart';

// class AddPostScreen extends StatefulWidget {
//   const AddPostScreen({super.key});

//   @override
//   State<AddPostScreen> createState() => _AddPostScreenState();
// }

// class _AddPostScreenState extends State<AddPostScreen> {
//   final _formKey = GlobalKey<FormState>();
//   List<String> _images = [];

//   List<HostelModel> hostels = [];

//   final TextEditingController _priceController = TextEditingController();
//   final TextEditingController _roomTypeController = TextEditingController();
//   final TextEditingController _descriptionController = TextEditingController();
//   final TextEditingController _roomScoreController = TextEditingController();
//   final TextEditingController _cleanlinessStarsController = TextEditingController();

//   final ImagePicker _picker = ImagePicker();
//   int _selectedIndex = 2;

//   Future<bool> _requestPermissions() async {
//     final cameraStatus = await Permission.camera.status;
//     final locationStatus = await Permission.location.status;

//     if (!cameraStatus.isGranted || !locationStatus.isGranted) {
//       final result = await [
//         Permission.camera,
//         Permission.location,
//       ].request();

//       return result[Permission.camera]!.isGranted && result[Permission.location]!.isGranted;
//     }
//     return true;
//   }

//   Future<void> _captureImage() async {
//     final hasPermission = await _requestPermissions();

//     if (!hasPermission) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Camera and location permissions are required')),
//       );
//       return;
//     }

//     final XFile? capturedFile = await _picker.pickImage(source: ImageSource.camera);

//     if (capturedFile != null) {
//       setState(() {
//         _images.add(capturedFile.path);
//       });
//     }
//   }

//   void _submit() {
//     if (_formKey.currentState!.validate()) {
//       final newHostel = HostelModel(
//         images: _images,
//         price: _priceController.text,
//         roomType: _roomTypeController.text,
//         description: _descriptionController.text,
//         roomScore: double.tryParse(_roomScoreController.text) ?? 0.0,
//         cleanlinessStars: int.tryParse(_cleanlinessStarsController.text) ?? 0,
//       );

//       Navigator.pop(context, newHostel);
//     }
//   }

//   void _onNavItemTapped(int index) async {
//     setState(() {
//       _selectedIndex = index;
//     });

//     switch (index) {
//       case 0:
//         Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const HomeScreen()));
//         break;
//       case 1:
//         // Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const BookmarkScreen()));
//         break;
//       case 2:
//         // Already on AddPostScreen
//         break;
//       case 3:
//         Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const SignInScreen()));
//         break;
//     }
//   }

//   @override
//   void dispose() {
//     _priceController.dispose();
//     _roomTypeController.dispose();
//     _descriptionController.dispose();
//     _roomScoreController.dispose();
//     _cleanlinessStarsController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Add Hostel Post'),
//         backgroundColor: AppColors.primaryColor,
//         foregroundColor: Colors.white,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: ListView(
//             children: [
//               GestureDetector(
//                 onTap: _captureImage,
//                 child: Container(
//                   height: 150,
//                   width: double.infinity,
//                   decoration: BoxDecoration(
//                     border: Border.all(color: AppColors.primaryColor, width: 2),
//                     borderRadius: BorderRadius.circular(12),
//                     color: Colors.grey[200],
//                   ),
//                   child: _images.isEmpty
//                       ? const Center(
//                           child: Icon(
//                             Icons.camera_alt_outlined,
//                             size: 60,
//                             color: Colors.grey,
//                           ),
//                         )
//                       : ListView.builder(
//                           scrollDirection: Axis.horizontal,
//                           padding: const EdgeInsets.all(8),
//                           itemCount: _images.length,
//                           itemBuilder: (context, index) {
//                             return Container(
//                               margin: const EdgeInsets.symmetric(horizontal: 8),
//                               child: ClipRRect(
//                                 borderRadius: BorderRadius.circular(12),
//                                 child: Image.file(
//                                   File(_images[index]),
//                                   width: 140,
//                                   height: 140,
//                                   fit: BoxFit.cover,
//                                 ),
//                               ),
//                             );
//                           },
//                         ),
//                 ),
//               ),

//               const SizedBox(height: 12),
//               Text(
//                 'Tap the box above to capture image',
//                 style: TextStyle(color: Colors.grey[600], fontSize: 14),
//                 textAlign: TextAlign.center,
//               ),

//               const SizedBox(height: 20),

//               TextFormField(
//                 controller: _priceController,
//                 decoration: const InputDecoration(
//                   labelText: 'Price',
//                   border: OutlineInputBorder(),
//                 ),
//                 validator: (val) => val == null || val.isEmpty ? 'Enter price' : null,
//               ),
//               const SizedBox(height: 12),
//               TextFormField(
//                 controller: _roomTypeController,
//                 decoration: const InputDecoration(
//                   labelText: 'Room Type',
//                   border: OutlineInputBorder(),
//                 ),
//                 validator: (val) => val == null || val.isEmpty ? 'Enter room type' : null,
//               ),
//               const SizedBox(height: 12),
//               TextFormField(
//                 controller: _descriptionController,
//                 maxLines: 3,
//                 decoration: const InputDecoration(
//                   labelText: 'Description',
//                   border: OutlineInputBorder(),
//                 ),
//                 validator: (val) => val == null || val.isEmpty ? 'Enter description' : null,
//               ),
//               const SizedBox(height: 12),
              
//               const SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: _submit,
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: AppColors.primaryColor,
//                   foregroundColor: Colors.white,
//                 ),
//                 child: const Text('Add Hostel'),
//               ),
//             ],
//           ),
//         ),
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
import 'package:hostel_finder/features/hostel/data/hostel_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import 'home_screen.dart';
import 'bookmark_screen.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  final _formKey = GlobalKey<FormState>();
  List<String> _images = [];

  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _roomTypeController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _roomScoreController = TextEditingController();
  final TextEditingController _cleanlinessStarsController = TextEditingController();

  final ImagePicker _picker = ImagePicker();
  int _selectedIndex = 2;

  Future<bool> _requestPermissions() async {
    final cameraStatus = await Permission.camera.status;
    final locationStatus = await Permission.location.status;

    if (!cameraStatus.isGranted || !locationStatus.isGranted) {
      final result = await [
        Permission.camera,
        Permission.location,
      ].request();

      return result[Permission.camera]!.isGranted && result[Permission.location]!.isGranted;
    }
    return true;
  }

  Future<void> _captureImage() async {
    final hasPermission = await _requestPermissions();

    if (!hasPermission) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Camera and location permissions are required')),
      );
      return;
    }

    final XFile? capturedFile = await _picker.pickImage(source: ImageSource.camera);

    if (capturedFile != null) {
      setState(() {
        _images.add(capturedFile.path);
      });
    }
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      final newHostel = HostelModel(
        images: _images,
        price: _priceController.text,
        roomType: _roomTypeController.text,
        description: _descriptionController.text,
        roomScore: double.tryParse(_roomScoreController.text) ?? 0.0,
        cleanlinessStars: int.tryParse(_cleanlinessStarsController.text) ?? 0,
      );

      Navigator.pop(context, newHostel);
    }
  }

  void _onNavItemTapped(int index) async {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const HomeScreen()));
        break;
      case 1:
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const BookmarkScreen()));
        break;
      case 2:
        // Already on AddPostScreen
        break;
      case 3:
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const SignInScreen()));
        break;
    }
  }

  @override
  void dispose() {
    _priceController.dispose();
    _roomTypeController.dispose();
    _descriptionController.dispose();
    _roomScoreController.dispose();
    _cleanlinessStarsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Hostel Post'),
        backgroundColor: AppColors.primaryColor,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              GestureDetector(
                onTap: _captureImage,
                child: Container(
                  height: 150,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.primaryColor, width: 2),
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.grey[200],
                  ),
                  child: _images.isEmpty
                      ? const Center(
                          child: Icon(
                            Icons.camera_alt_outlined,
                            size: 60,
                            color: Colors.grey,
                          ),
                        )
                      : ListView.builder(
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.all(8),
                          itemCount: _images.length,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: const EdgeInsets.symmetric(horizontal: 8),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.file(
                                  File(_images[index]),
                                  width: 140,
                                  height: 140,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            );
                          },
                        ),
                ),
              ),

              const SizedBox(height: 12),
              Text(
                'Tap the box above to capture image',
                style: TextStyle(color: Colors.grey[600], fontSize: 14),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 20),

              TextFormField(
                controller: _priceController,
                decoration: const InputDecoration(
                  labelText: 'Price',
                  border: OutlineInputBorder(),
                ),
                validator: (val) => val == null || val.isEmpty ? 'Enter price' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _roomTypeController,
                decoration: const InputDecoration(
                  labelText: 'Room Type',
                  border: OutlineInputBorder(),
                ),
                validator: (val) => val == null || val.isEmpty ? 'Enter room type' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _descriptionController,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(),
                ),
                validator: (val) => val == null || val.isEmpty ? 'Enter description' : null,
              ),
              const SizedBox(height: 12),
              
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submit,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  foregroundColor: Colors.white,
                ),
                child: const Text('Add Hostel'),
              ),
            ],
          ),
        ),
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