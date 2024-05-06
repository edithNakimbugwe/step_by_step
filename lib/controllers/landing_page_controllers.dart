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

  String identifyImage() {
    String imageName;
    if (currentImageUrl == 'assets/icons/1.jpg') {
      imageName = 'image 1';
    } else if (currentImageUrl == 'assets/icons/2.jpg') {
      imageName = 'image 2';
    } else if (currentImageUrl == 'assets/icons/3.jpg') {
      imageName = 'image 3';
    } else if (currentImageUrl == 'assets/icons/4.jpg') {
      imageName = 'image 4';
    } else {
      imageName = 'No image';
    }

    return imageName;
  }
}
