import 'package:flutter/material.dart';

class HostelDetailPage extends StatelessWidget {
  final List<String> imageUrls;
  final String price;
  final String roomType;
  final String description;
  final double roomScore;
  final int cleanlinessStars;

  const HostelDetailPage({
    super.key,
    required this.imageUrls,
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
    return Scaffold(
      appBar: AppBar(
        title: const Text("Hostel Details"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image carousel
            SizedBox(
              height: 160,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: imageUrls.length,
                separatorBuilder: (_, __) => const SizedBox(width: 8),
                itemBuilder: (context, index) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      imageUrls[index],
                      width: 200,
                      height: 160,
                      fit: BoxFit.cover,
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
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Text(
                      "Room Score",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    Row(
                      children: [
                        const Icon(Icons.home, size: 20),
                        const SizedBox(width: 4),
                        Text(roomScore.toStringAsFixed(1)),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Text("Cleanliness"),
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
              icon: const Icon(Icons.message),
              label: const Text("Message"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                minimumSize: const Size(double.infinity, 45),
              ),
            ),

            const SizedBox(height: 20),

            // Description
            const Text(
              "Description",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 6),
            Text(description),

            const SizedBox(height: 20),

            // Feature cards
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 3,
              children: const [
                _FeatureCard(
                  icon: Icons.bolt,
                  title: "AI-Powered Recommendation",
                  description: "Suggests hostels/rooms",
                ),
                _FeatureCard(
                  icon: Icons.star,
                  title: "Room Quality Scoring",
                  description: "Rates cleanliness and condition",
                ),
                _FeatureCard(
                  icon: Icons.analytics,
                  title: "Demand Forecast for Students",
                  description: "Predicts suspicious listings",
                ),
                _FeatureCard(
                  icon: Icons.attach_money,
                  title: "Smart Price Estimator",
                  description: "Suggests fair rent price",
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Book Now button
            ElevatedButton(
              onPressed: () {},
              child: const Text("Book Now"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
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
            Icon(icon, size: 28, color: Colors.teal),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(title,
                      style:
                      const TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
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
