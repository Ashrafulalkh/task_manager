import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:task_manager/ui/utilities/asset_path.dart';

class BackGroundWidgets extends StatelessWidget {
  const BackGroundWidgets({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SvgPicture.asset(
          AssetPath.backGroundSvg,
          height: double.maxFinite,
          width: double.maxFinite,
          fit: BoxFit.cover,
        ),
        child
      ],
    );
  }
}

