import 'package:oifyoo_mksr/resources/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/size_extension.dart';

///*********************************************
/// Created by ukietux on 03/11/20 with ♥
/// (>’_’)> email : ukie.tux@gmail.com
/// github : https://www.github.com/ukieTux <(’_’<)
///*********************************************
/// © 2020 | All Right Reserved
class CircleImage extends StatelessWidget {
  final String url;
  final double size;

  const CircleImage({Key key, @required this.url, this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// TODO Need to change with Fix on error image url
    return ClipRRect(
      borderRadius: BorderRadius.circular(360),

      /// 360 degree circle
      child: Image.network(url,
          fit: BoxFit.cover,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return Center(
              child: CircularProgressIndicator(
                value: loadingProgress.expectedTotalBytes != null
                    ? loadingProgress.cumulativeBytesLoaded /
                        loadingProgress.expectedTotalBytes
                    : null,
              ),
            );
          },
          errorBuilder: (context, error, stackTrace) => Image.network(
                "https://disk.mediaindonesia.com/thumbs/1800x1200/news/2019/12/e5072fc473baef25f8e2447fc88e3246.jpg",
                fit: BoxFit.cover,
                width: size ?? 100.w,
                height: size ?? 100.w,
              )),
    );
  }
}
