import 'package:flutter/material.dart';
import 'package:shopping_app/features/home/domain/entities/category_entity.dart';

class CategoriesWidget extends StatelessWidget {
  const CategoriesWidget({
    super.key,
    required this.categories,
    required this.selectedSlug,
    required this.onCategoryTap,
  });

  final List<CategoryEntity> categories;
  final String? selectedSlug;
  final ValueChanged<CategoryEntity> onCategoryTap;

  @override
  Widget build(BuildContext context) {
    if (categories.isEmpty) {
      return const SizedBox.shrink();
    }

    return SizedBox(
      height: 48,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: categories.length,
        separatorBuilder: (context, index) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final category = categories[index];

          return _CategoryItem(
            name: category.name,
            slug: category.slug,
            isSelected: category.slug == selectedSlug,
            onTap: () => onCategoryTap(category),
          );
        },
      ),
    );
  }
}

class _CategoryItem extends StatelessWidget {
  const _CategoryItem({
    required this.name,
    required this.slug,
    required this.isSelected,
    required this.onTap,
  });

  final String name;
  final String slug;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: isSelected ? Colors.black : Colors.grey),
          color: isSelected ? Colors.grey.shade200 : Colors.transparent,
        ),
        child: Text(name, style: Theme.of(context).textTheme.bodyMedium),
      ),
    );
  }
}
