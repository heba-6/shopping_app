import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class HomeCategoriesSkeleton extends StatelessWidget {
  const HomeCategoriesSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      effect: const ShimmerEffect(
        baseColor: Color(0xFFF5F5F5),
        highlightColor: Color(0xFFFCFCFC),
        duration: Duration(milliseconds: 1400),
      ),
      child: SizedBox(
        height: 48,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemCount: 5,
          separatorBuilder: (_, _) => const SizedBox(width: 8),
          itemBuilder: (_, index) {
            return Container(
              width: 75 + (index % 3) * 15,
              height: 40,
              decoration: BoxDecoration(
                color: const Color(0xFFF5F5F5),
                borderRadius: BorderRadius.circular(14),
              ),
            );
          },
        ),
      ),
    );
  }
}

class HomeBannerSkeleton extends StatelessWidget {
  const HomeBannerSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      effect: const ShimmerEffect(
        baseColor: Color(0xFFF2F2F2),
        highlightColor: Color(0xFFFAFAFA),
        duration: Duration(milliseconds: 1500),
      ),
      child: Container(
        height: 160,
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: const Color(0xFFF2F2F2),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Bone(width: 85, height: 11),
            const SizedBox(height: 13),
            Bone(width: 155, height: 20),
            const SizedBox(height: 9),
            Bone(width: 120, height: 11),
            const SizedBox(height: 17),
            Container(
              width: 85,
              height: 28,
              decoration: BoxDecoration(
                color: const Color(0xFFEAEAEA),
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HomeProductsSkeleton extends StatelessWidget {
  const HomeProductsSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.all(16),
      sliver: SliverGrid(
        delegate: SliverChildBuilderDelegate((_, index) {
          return Skeletonizer(
            effect: const ShimmerEffect(
              baseColor: Color(0xFFF4F4F4),
              highlightColor: Color(0xFFFCFCFC),
              duration: Duration(milliseconds: 1500),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF3F3F3),
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Bone(width: 115, height: 13),
                const SizedBox(height: 8),
                Bone(width: 75, height: 11),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Bone(width: 55, height: 15),
                    Bone.circle(size: 30),
                  ],
                ),
              ],
            ),
          );
        }, childCount: 6),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 18,
          childAspectRatio: 163 / 288,
        ),
      ),
    );
  }
}
