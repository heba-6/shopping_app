import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class ProductImageSlider extends StatefulWidget {
  final List<String> images;
  const ProductImageSlider({super.key, required this.images});

  @override
  State<ProductImageSlider> createState() => _ProductImageSliderState();
}

class _ProductImageSliderState extends State<ProductImageSlider> {
  int _current = 0;
  bool _isfavorite = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            CarouselSlider(
              options: CarouselOptions(
                height: 331,
                viewportFraction: 1,
                enableInfiniteScroll: widget.images.length > 1,
                onPageChanged: (i, _) => setState(() => _current = i),
              ),
              items: widget.images
                  .map(
                    (url) => ClipRRect(
                      borderRadius: BorderRadius.circular(24),
                      child: Image.network(
                        url,
                        width: 264,
                        height: 260,
                        fit: BoxFit.contain,
                      ),
                    ),
                  )
                  .toList(),
            ),
            Positioned(
              top: 8,
              right: 8,

              child: IconButton(
                onPressed: () => setState(() => _isfavorite = !_isfavorite),
                icon: Icon(
                  _isfavorite ? Icons.favorite : Icons.favorite_border,
                  color: _isfavorite ? Colors.red : Color(0xFF000000),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            widget.images.length,
            (i) => Container(
              width: 8,
              height: 8,
              margin: const EdgeInsets.symmetric(horizontal: 3),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _current == i
                    ? Theme.of(context).primaryColor
                    : Colors.grey.shade300,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
