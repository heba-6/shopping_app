import 'package:flutter/material.dart';
import 'package:shopping_app/features/product_details/data/model/review_model.dart';
import 'package:shopping_app/core/theme/app_colors.dart';

class ReviewsSection extends StatelessWidget {
  final List<ReviewModel> reviews;
  const ReviewsSection({super.key, required this.reviews});
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Reviews',
          style: theme.textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 15),
        if (reviews.isEmpty)
          Text('No reviews yet', style: TextStyle(fontWeight: .bold))
        else
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: reviews.length,
            separatorBuilder: (_, __) => const Divider(),
            itemBuilder: (_, i) {
              final r = reviews[i];
              return ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(r.userName),
                subtitle: Text(r.comment),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.star,
                      size: 16,
                      color: AppColors.orangeLight,
                    ),
                    const SizedBox(width: 2),
                    Text(r.rating.toString()),
                  ],
                ),
              );
            },
          ),
      ],
    );
  }
}
