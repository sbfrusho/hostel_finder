import 'dart:io';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:hostel_finder/core/constants/app_colors.dart';

class HostelDetailPage extends StatelessWidget {
  final List<String> imagePaths;
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
    required this.roomScore,
    required this.cleanlinessStars,
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
            Text('Details', style: TextStyle(color: Colors.white)),
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
              icon: const Icon(Icons.message, color: Colors.white),
              label: const Text("Message", style: TextStyle(color: Colors.white)),
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

            // Feature cards
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                SizedBox(
                  width: double.infinity,
                  child: GestureDetector(
                    onTap: () => showDialog(
                      context: context,
                      builder: (_) => const RecommendationDialog(),
                    ),
                    child: const _FeatureCard(
                      icon: Icons.bolt,
                      title: "AI-Powered Recommendation",
                      description: "Suggests hostels/rooms",
                    ),
                  ),
                ),
                const SizedBox(
                  width: double.infinity,
                  child: _FeatureCard(
                    icon: Icons.star,
                    title: "Room Quality Scoring",
                    description: "Rates cleanliness and condition",
                  ),
                ),
                const SizedBox(
                  width: double.infinity,
                  child: _FeatureCard(
                    icon: Icons.analytics,
                    title: "Demand Forecast for Students",
                    description: "Predicts suspicious listings",
                  ),
                ),
                const SizedBox(
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
              child: const Text("Book Now", style: TextStyle(color: Colors.white)),
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

class RecommendationDialog extends StatefulWidget {
  const RecommendationDialog({super.key});

  @override
  State<RecommendationDialog> createState() => _RecommendationDialogState();
}

class _RecommendationDialogState extends State<RecommendationDialog> {
  static const List<String> recommendations = [
    "Check out GreenView Hostel – best for natural light and study ambiance.",
    "Try Moonlight Rooms – verified cleanliness and high student ratings.",
    "Budget-friendly alert: CozyStay offers shared rooms at low rent!",
    "Looking for peace? SilentNest has strict no-noise policies.",
    "Top pick: PrimeHostel near the library with free Wi-Fi and meals."
  ];

  String displayedText = '';
  late String selectedRecommendation;
  int _charIndex = 0;

  @override
  void initState() {
    super.initState();
    selectedRecommendation = (recommendations.toList()..shuffle()).first;
    _startTypingAnimation();
  }

  void _startTypingAnimation() {
    Future.delayed(const Duration(milliseconds: 50), _addNextChar);
  }

  void _addNextChar() {
    if (_charIndex < selectedRecommendation.length) {
      setState(() {
        displayedText += selectedRecommendation[_charIndex];
        _charIndex++;
      });
      Future.delayed(const Duration(milliseconds: 40), _addNextChar);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("AI Recommendation"),
      content: SizedBox(
        height: 100,
        child: SingleChildScrollView(
          child: Text(
            displayedText,
            style: const TextStyle(fontSize: 14),
          ),
        ),
      ),
      actions: [
        TextButton(
          child: const Text("Close", style: TextStyle(color: AppColors.primaryColor)),
          onPressed: () => Navigator.of(context).pop(),
        )
      ],
    );
  }
}
