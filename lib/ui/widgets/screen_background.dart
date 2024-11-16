import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../utils/assets_path.dart';

class BackgroundScreen extends StatelessWidget {
  const BackgroundScreen({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {

    Size screenSize = MediaQuery.sizeOf(context);

    return SingleChildScrollView(
      child: Stack(
        children: [
          SvgPicture.asset(AssetsPath.backgroundSvg, fit: BoxFit.cover,
            height: screenSize.height,
            width: screenSize.width,),
          SafeArea(child:
          child)
        ],
      ),
    );
  }
}