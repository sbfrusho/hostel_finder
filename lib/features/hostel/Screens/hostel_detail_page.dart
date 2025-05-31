import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hostel_finder/core/constants/app_colors.dart';
import 'package:hostel_finder/features/hostel/data/hostel_model.dart';


class HostelDetailPage extends StatelessWidget {
  final List<String> imagePaths; // Local file paths here
  final String price;
  final String roomType;
  final String description;
  final double roomScore;
  final int cleanlinessStars;

  const HostelDetailPage({
    super.key,
    required this.imagePaths,
    required this.price,
    required this.roomType,
    required this.description,
    this.roomScore = 5.0,
    this.cleanlinessStars = 3,
  });

  Widget _buildStarRating(int stars) {
    return Row(
      children: List.generate(5, (index) {
        return Icon(
          index < stars ? Icons.star : Icons.star_border,
          color: Colors.amber,
          size: 18,
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: const [
            SizedBox(width: 8),
            Text('Details',style: TextStyle(color: Colors.white),),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: screenWidth * 0.5,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: imagePaths.length,
                separatorBuilder: (_, __) => const SizedBox(width: 8),
                itemBuilder: (context, index) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.file(
                      File(imagePaths[index]),
                      width: screenWidth * 0.7,
                      height: screenWidth * 0.5,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          width: screenWidth * 0.7,
                          height: screenWidth * 0.5,
                          color: Colors.grey[300],
                          child: const Icon(Icons.broken_image, size: 50),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),

            // Price and Room Info
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '$price/month\n$roomType',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryColor,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Text(
                      "Room Score",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: AppColors.primaryColor,
                      ),
                    ),
                    Row(
                      children: [
                        const Icon(Icons.home, size: 20, color: AppColors.primaryColor),
                        const SizedBox(width: 4),
                        Text(
                          
                          roomScore.toStringAsFixed(1),
                          style: const TextStyle(color: AppColors.primaryColor),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Text(
                          "Cleanliness",
                          style: TextStyle(color: AppColors.primaryColor),
                        ),
                        const SizedBox(width: 4),
                        _buildStarRating(cleanlinessStars),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Message button
            ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.message , color: Colors.white,),
              label: const Text("Message",style: TextStyle(color: Colors.white),),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
                minimumSize: const Size(double.infinity, 45),
              ),
            ),

            const SizedBox(height: 20),

            // Description
            const Text(
              "Description",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.primaryColor,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              description,
              style: const TextStyle(color: Colors.black87),
            ),

            const SizedBox(height: 20),

            // Feature cards (responsive with Wrap)
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: const [
                SizedBox(
                  width: double.infinity,
                  child: _FeatureCard(
                    icon: Icons.bolt,
                    title: "AI-Powered Recommendation",
                    description: "Suggests hostels/rooms",
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: _FeatureCard(
                    icon: Icons.star,
                    title: "Room Quality Scoring",
                    description: "Rates cleanliness and condition",
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: _FeatureCard(
                    icon: Icons.analytics,
                    title: "Demand Forecast for Students",
                    description: "Predicts suspicious listings",
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: _FeatureCard(
                    icon: Icons.attach_money,
                    title: "Smart Price Estimator",
                    description: "Suggests fair rent price",
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Book Now button
            ElevatedButton(
              onPressed: () {},
              child: const Text("Book Now", style: TextStyle(color: Colors.white),),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
                minimumSize: const Size(double.infinity, 48),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FeatureCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const _FeatureCard({
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            Icon(icon, size: 28, color: AppColors.primaryColor),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(title,
                      style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryColor)),
                  Text(
                    description,
                    style: const TextStyle(fontSize: 11),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
