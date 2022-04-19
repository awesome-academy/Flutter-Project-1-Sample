import 'package:flutter/material.dart';
import 'package:vn_crypto/assets/vn_crypto_icons.dart';

class BottomNav extends StatefulWidget {
  BottomNav({Key? key, required this.onTap, this.selectedIndex = 0})
      : super(key: key);

  final ValueChanged<int> onTap;
  int selectedIndex;

  @override
  _BottomNavState createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 8,
      child: Row(
        children: [
          buildNavItem(icon: VNCryptoIcons.ic_home, index: 0),
          buildNavItem(icon: VNCryptoIcons.ic_chart, index: 1),
          buildNavItem(icon: VNCryptoIcons.ic_invest, index: 2),
          buildNavItem(icon: VNCryptoIcons.ic_settings, index: 3),
        ],
      ),
    );
  }

  Widget buildNavItem({required IconData icon, required int index}) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          widget.onTap(index);
        },
        child: Container(
          color: Colors.white,
          height: 60,
          child: Icon(icon,
              color: index == widget.selectedIndex
                  ? Colors.black87
                  : Colors.black38,
              size: 20),
        ),
      ),
    );
  }
}
