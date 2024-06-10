import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Controllers/LoadingController.dart';

class LoadingBarrier extends StatelessWidget {
  LoadingBarrier({super.key, required this.child});
  final loadC = Get.find<LoadingController>();
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoadingController>(
      builder: (loadC) {
        return Stack(
          children: [
            child,
            if (loadC.isLoading.value)
              Container(
                color: Colors.black.withOpacity(0.5), // Warna overlay
                child: const Center(
                  // Menampilkan widget loading di tengah overlay
                  child: CircularProgressIndicator(),
                ),
              ),
          ],
        );
      },
    );
  }
}
