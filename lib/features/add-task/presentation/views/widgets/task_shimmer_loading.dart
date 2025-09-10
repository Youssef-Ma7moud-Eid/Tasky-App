import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class TaskShimmerLoading extends StatelessWidget {
  const TaskShimmerLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: ListView.builder(
        itemCount: 6, // عدد العناصر الوهمية
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 15),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey[400]!, width: 1.5),
              borderRadius: BorderRadius.circular(15),
              color: Colors.white,
            ),
            child: Row(
              children: [
                CircleAvatar(backgroundColor: Colors.grey[400], radius: 15),
                const SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(width: 180, height: 18, color: Colors.grey[400]),
                    const SizedBox(height: 10),
                    Container(width: 120, height: 16, color: Colors.grey[400]),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
