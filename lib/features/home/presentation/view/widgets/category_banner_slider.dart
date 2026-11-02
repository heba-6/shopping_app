import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shopping_app/core/constants/category_banner_images.dart';
import 'package:shopping_app/core/theme/app_colors.dart';
import 'package:shopping_app/features/home/domain/entities/category_entity.dart';
import 'package:shopping_app/features/products_by_category/presentation/view/screens/products_by_category_screen.dart';

class CategoryBannerSlider extends StatefulWidget {
  final List<CategoryEntity> categories;

  const CategoryBannerSlider({super.key, required this.categories});

  @override
  State<CategoryBannerSlider> createState() => _CategoryBannerSliderState();
}

class _CategoryBannerSliderState extends State<CategoryBannerSlider> {
  late final PageController _pageController;

  Timer? _autoPlayTimer;

  int _currentIndex = 0;

  static const Duration _autoPlayDuration = Duration(seconds: 3);
  static const Duration _animationDuration = Duration(milliseconds: 600);

  @override
  void initState() {
    super.initState();

    final initialPage = widget.categories.isEmpty
        ? 0
        : 10000 - (10000 % widget.categories.length);

    _pageController = PageController(initialPage: initialPage);

    if (widget.categories.length > 1) {
      _startAutoPlay();
    }
  }

  void _startAutoPlay() {
    _autoPlayTimer?.cancel();

    if (widget.categories.length <= 1) return;

    _autoPlayTimer = Timer(_autoPlayDuration, _goToNextPage);
  }

  void _goToNextPage() {
    if (!mounted || !_pageController.hasClients) return;

    final nextPage = _pageController.page!.round() + 1;

    _pageController.animateToPage(
      nextPage,
      duration: _animationDuration,
      curve: Curves.easeInOut,
    );
  }

  void _onPageChanged(int index) {
    if (!mounted) return;

    setState(() {
      _currentIndex = index % widget.categories.length;
    });

    _startAutoPlay();
  }

  void _openCategory(CategoryEntity category) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ProductsByCategoryScreen(
          slug: category.slug,
          categoryName: category.name,
        ),
      ),
    );
  }

  String _getBannerImage(CategoryEntity category) {
    return CategoryBannerImages.images[category.slug] ?? category.image;
  }

  List<int> _getVisibleIndicatorIndexes() {
    final count = widget.categories.length;

    if (count <= 5) {
      return List.generate(count, (index) => index);
    }

    final startIndex = _currentIndex - 2;

    return List.generate(5, (index) => (startIndex + index + count) % count);
  }

  @override
  void didUpdateWidget(covariant CategoryBannerSlider oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.categories.length != widget.categories.length) {
      _autoPlayTimer?.cancel();

      _currentIndex = 0;

      if (widget.categories.isNotEmpty && _pageController.hasClients) {
        final firstPage = 10000 - (10000 % widget.categories.length);

        _pageController.jumpToPage(firstPage);
      }

      if (widget.categories.length > 1) {
        _startAutoPlay();
      }
    }
  }

  @override
  void dispose() {
    _autoPlayTimer?.cancel();
    _pageController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.categories.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: 185,
          child: PageView.builder(
            controller: _pageController,
            onPageChanged: _onPageChanged,
            itemBuilder: (context, index) {
              final category =
                  widget.categories[index % widget.categories.length];

              return _buildBanner(category);
            },
          ),
        ),

        const SizedBox(height: 12),

        _buildIndicators(),
      ],
    );
  }

  Widget _buildBanner(CategoryEntity category) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.network(
              _getBannerImage(category),
              fit: BoxFit.cover,
              width: double.infinity,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: Colors.grey.shade300,
                  alignment: Alignment.center,
                  child: const Icon(
                    Icons.image_not_supported_outlined,
                    size: 40,
                    color: Colors.grey,
                  ),
                );
              },
            ),

            const DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    Color(0xCC000000),
                    Color(0x66000000),
                    Color(0x00000000),
                  ],
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    category.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 6),

                  Text(
                    CategoryBannerImages.hints[category.slug] ??
                        'Discover something you will love.',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),

                  const SizedBox(height: 14),

                  ElevatedButton(
                    onPressed: () => _openCategory(category),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryOrange,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Shop Now',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIndicators() {
    final visibleIndexes = _getVisibleIndicatorIndexes();

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: visibleIndexes.map((index) {
        final isActive = index == _currentIndex;

        return AnimatedContainer(
          key: ValueKey(index),
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          margin: const EdgeInsets.symmetric(horizontal: 3),
          width: isActive ? 18 : 7,
          height: 7,
          decoration: BoxDecoration(
            color: isActive ? AppColors.primaryOrange : Colors.grey.shade400,
            borderRadius: BorderRadius.circular(10),
          ),
        );
      }).toList(),
    );
  }
}
