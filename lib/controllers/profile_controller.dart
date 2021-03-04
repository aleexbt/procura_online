import 'package:get/get.dart';
import 'package:procura_online/models/profile_model.dart';
import 'package:procura_online/repositories/user_repository.dart';

class ProfileController extends GetxController {
  final int profileId = int.parse(Get.parameters['id']);
  final UserRepository _userRepository = Get.find();

  RxBool _isLoading = false.obs;
  RxBool _hasError = false.obs;
  bool get isLoading => _isLoading.value;
  bool get hasError => _hasError.value;

  Rx<Profile> _profile = Profile().obs;
  Profile get profile => _profile.value;

  @override
  void onInit() {
    getProfile();
    super.onInit();
  }

  void getProfile() async {
    _isLoading.value = true;
    _hasError.value = false;
    try {
      Profile response = await _userRepository.getProfile(profileId);
      _profile.value = response;
      if (response.user == null) {
        _hasError.value = true;
      }
    } catch (err) {
      print(err);
      _hasError.value = true;
    } finally {
      _isLoading.value = false;
    }
  }
}
