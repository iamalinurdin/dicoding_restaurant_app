import 'package:flutter/material.dart';
import 'package:restaurant_app/data/models/menu.dart';

class MenuItemList extends StatelessWidget {
  const MenuItemList({
    super.key,
    required this.menuItem,
    required this.backgroundImage,
  });

  final MenuItem menuItem;
  final String backgroundImage;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(backgroundImage, fit: BoxFit.cover),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: .topCenter,
                  end: .bottomCenter,
                  colors: [Colors.transparent, Colors.black],
                ),
              ),
            ),
            Positioned(
              bottom: 10,
              left: 8,
              child: Text(
                menuItem.name,
                style: Theme.of(context).textTheme.labelLarge!.copyWith(
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Roboto',
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
