part of splash;

class SplashController extends GetxController {
  final isLoading = true.obs;
  @override
  void onInit() async {
    super.onInit();

    // await Future.delayed(Duration(seconds: 1));
    isLoading.value = false;
    // goToDashboard(); // dont do it here: debuglock error
  }

  void loadView() async {
    await Future.delayed(const Duration(milliseconds: 200));
    Get.toNamed(Routes.dashboard);
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    print("onready");
    isLoading.value = false;

    goToDashboard();
  }

  static const _url = "https://github.com/firgia/FD-File-Manager";

  void goToDashboard() => Get.toNamed(Routes.dashboard);

  void goToYoutubeChannel() async => await canLaunch(_url)
      ? await launch(_url)
      : throw 'Could not launch $_url';
}
