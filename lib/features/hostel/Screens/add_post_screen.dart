import 'package:flutter/material.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _price, _roomType, _description;

  // Replace this with actual image picker logic
  final List<String> _imagePaths = [
    'assets/images/hostel1.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Hostel'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image Picker section
              const Text(
                'Images',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 8),
              SizedBox(
                height: 100,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: _imagePaths.length + 1,
                  itemBuilder: (context, index) {
                    if (index == _imagePaths.length) {
                      return GestureDetector(
                        onTap: () {
                          // TODO: pick image
                        },
                        child: Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Center(child: Icon(Icons.add)),
                        ),
                      );
                    } else {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.asset(
                          _imagePaths[index],
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                      );
                    }
                  },
                  separatorBuilder: (_, __) => const SizedBox(width: 12),
                ),
              ),

              const SizedBox(height: 24),

              // Price
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Price (e.g. \$400)',
                  prefixIcon: Icon(Icons.attach_money),
                ),
                keyboardType: TextInputType.number,
                onSaved: (val) => _price = val,
                validator: (val) =>
                val == null || val.isEmpty ? 'Enter price' : null,
              ),
              const SizedBox(height: 16),

              // Room Type
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Room Type',
                  prefixIcon: Icon(Icons.bed_outlined),
                ),
                onSaved: (val) => _roomType = val,
                validator: (val) =>
                val == null || val.isEmpty ? 'Enter room type' : null,
              ),
              const SizedBox(height: 16),

              // Description
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Description',
                  prefixIcon: Icon(Icons.description_outlined),
                ),
                maxLines: 4,
                onSaved: (val) => _description = val,
                validator: (val) =>
                val == null || val.isEmpty ? 'Enter description' : null,
              ),

              const SizedBox(height: 24),

              // Submit Button
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      _formKey.currentState?.save();
                      // TODO: save post data
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Post submitted!')),
                      );
                    }
                  },
                  child: const Text(
                    'Submit Post',
                    style:
                    TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
