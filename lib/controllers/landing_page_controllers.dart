import 'package:get/get.dart';

class LandingPageController extends GetxController {
  final List<String> imageUrls = [
    'assets/icons/1.jpg',
    'assets/icons/2.jpg',
    'assets/icons/3.jpg',
    'assets/icons/4.jpg',
  ];

  var currentImageIndex = 0.obs;

  String get currentImageUrl => imageUrls[currentImageIndex.value];

  void nextImage() {
    currentImageIndex.value = (currentImageIndex.value + 1) % imageUrls.length;
  }

  void previousImage() {
    currentImageIndex.value =
        (currentImageIndex.value - 1 + imageUrls.length) % imageUrls.length;
  }
}
