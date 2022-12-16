import 'package:blobs/blobs.dart';
import 'package:flutter/material.dart';

class CardIsland extends StatelessWidget {
  final String image;
  final String label;
  final VoidCallback action;
  const CardIsland({Key? key, required this.image, required this.label, required this.action})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Blob.random(
      size: 120,
      styles:BlobStyles(color: Colors.white),
      child: GestureDetector(
        onTap: action,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              image,

            ),
            Text(
              label,
              style: Theme.of(context).textTheme.subtitle1!.copyWith(color: Colors.black)),

          ],
        ),
      ),
    );

    /*Blob.animatedRandom(
      size: 200,
      edgesCount: 5,
      minGrowth: 4,
      duration: const Duration(milliseconds: 3000),
      loop: true,
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              image,
              height: 15,
            ),
            Text(
              label,
              style: const TextStyle(
                  fontFamily: AppFonts.poppinsRegularFont,
                  color: AppColors.black_claro),
            ),
          ],
        ),
      ),
    );*/
  }
}
