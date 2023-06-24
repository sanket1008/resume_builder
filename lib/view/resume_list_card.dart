import 'package:flutter/material.dart';
import 'package:resume_builder/util/assets.dart';

import '../resorses/components/common_image_view.dart';

class ResumeListCard extends StatelessWidget {
  const ResumeListCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  InkWell(
      onTap: () {
       // Get.to(() => const MyLiveCourseDetailsScreen());
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: const CommonImageView(
                        image: Assets.DEFAULT_IMAGE,
                        height: 80,
                        width: 80,
                      ),
                    ),
                  ],
                ),
              ),
              const Expanded(
                flex: 7,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Resume Name",
                    ),

                  ],
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}

