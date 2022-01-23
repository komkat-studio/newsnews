import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HeadlineCard extends StatelessWidget {
  const HeadlineCard({
    Key? key,
    required this.newsTitle,
    required this.newsTag,
    required this.imageURL,
  }) : super(key: key);

  final String newsTitle;
  final String newsTag;
  final String imageURL;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 14,
            offset: Offset(1, 1),
          ),
        ],
      ),
      child: Column(
        children: [
          Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(6),
                child: Container(
                  height: 200.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: Image.network(
                        imageURL,
                      ).image,
                      fit: BoxFit.cover,
                    ),
                  ),
                  margin: EdgeInsets.only(bottom: 12.h),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 20.w,
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.blue.shade800,
                      borderRadius: BorderRadius.circular(4)),
                  padding: const EdgeInsets.all(5),
                  child: Text(
                    newsTag.toUpperCase(),
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 12.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0.w),
            child: Text(
              newsTitle,
              style: TextStyle(
                fontSize: 19.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}