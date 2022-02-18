import 'package:flutter/material.dart';

class CategoryContainer extends StatelessWidget {
  final String categoryTitle, categoryImage;
  final Function onTap;

  const CategoryContainer({
    Key? key,
    required this.categoryTitle,
    required this.categoryImage,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Column(
        children: [
          Container(
              height: 93,
              width: 166,
              margin: const EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20), // Image border
                child: SizedBox.fromSize(
                  size: const Size.fromRadius(48), // Image radius
                  child: Image.network(categoryImage, fit: BoxFit.cover),
                ),
              )),
          const SizedBox(height: 5),
          Text(categoryTitle),
        ],
      ),
    );
  }
}
