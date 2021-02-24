import 'package:get/get.dart';
import 'package:procura_online/models/profile_model.dart';
import 'package:procura_online/repositories/user_repository.dart';

class ProfileController extends GetxController {
  final int profileId = int.parse(Get.parameters['id']);
  // final UserController _userController = Get.find();
  final UserRepository _userRepository = Get.find();

  RxBool _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  Rx<Profile> _profile = Profile().obs;
  Profile get profile => _profile.value;

  @override
  void onInit() {
    getProfile();
    print('PROFILE: $profileId');
    super.onInit();
  }

  void getProfile() async {
    _isLoading.value = true;
    try {
      Profile response = await _userRepository.getProfile(profileId);
      _profile.value = response;
    } catch (err) {
      print(err);
    } finally {
      _isLoading.value = false;
    }
  }
}
