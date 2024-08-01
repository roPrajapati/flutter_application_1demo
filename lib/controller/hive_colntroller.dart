//  call at initial app
await AppHive.instance.init();

  final loginUserJson = AppHive.instance.hiveBox.get(AppHive.loginUserInfo);
  if (loginUserJson != null) {
    userLogin = UserLoginData.fromJson(jsonParser(loginUserJson));
  }

   Future<void> dataStoreLocally({UserLoginData? userLoginData}) async {
    sUserAccessToken = userLoginData?.accessToken ?? "";
    " ${StringsConst.accessToken}$sUserAccessToken".printLog();
    " ${StringsConst.refreshToken}${userLogin?.refreshToken}".printLog();
    "${StringsConst.userIds}${userLogin?.user?.id}".printLog();
    await AppHive.instance.hiveBox.put(AppHive.accessToken, sUserAccessToken);
    await AppHive.instance.hiveBox.put(
      AppHive.loginUserInfo,
      (userLoginData?.toJson()),
    );
    if (userLoginData?.authUrl?.isNotEmpty ?? false) {
      await launchUrlString(
        userLoginData?.authUrl ?? "",
        mode: LaunchMode.externalApplication,
      );
    }
  }


  initialRoute: AppHive.instance.hiveBox.get(AppHive.loginUserInfo) == null
          ? AppRoutes.loginScreen
          : userLogin?.user?.jobTitle == "Office boy"
              ? AppRoutes.officeBoyScreen
              : AppRoutes.appDashboard,
class AppHive {
  static const String localStorage = "localStorage";
  static const String loginUserInfo = "loginUserInfo";
  static const String accessToken = "accessToken";

  AppHive._();
  static AppHive instance = AppHive._();
  late Box<dynamic> hiveBox;
  Future<void> init() async {
    await Hive.initFlutter();
    await Hive.openBox(localStorage);
    hiveBox = Hive.box(localStorage);
  }

  Future<void> clearHiveData() async {
    await Hive.deleteFromDisk();
    await init();
  }
}


void showToast({
  required String message,
  Toast? toastLength,
  ToastGravity? gravity,
  Color? backgroundColor,
  Color? textColor,
}) {
  Fluttertoast.cancel();
  Fluttertoast.showToast(
    msg: message,
    toastLength: toastLength ?? Toast.LENGTH_SHORT,
    gravity: gravity ?? ToastGravity.BOTTOM_RIGHT,
    backgroundColor: backgroundColor ?? ColorConst.bgBlack,
    textColor: textColor ?? ColorConst.bgWhite,
  );
}

Future launchUrl({required String url}) async {
  try {
    if (await canLaunchUrlString(url)) {
      await launchUrlString(url);
    }
  } catch (ex) {
    "launchUrl error: $ex".printLog();
  }
}

void hideKeyboard() {
  FocusManager.instance.primaryFocus?.unfocus();
}


controller.isDashboardLeaveLoading.isTrue
      ? const ShimmerEffectLeave()
      : (leaveUsers.isNotEmpty)
          ?




class ShimmerEffectLeave extends StatelessWidget {
  const ShimmerEffectLeave({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[400]!,
      highlightColor: Colors.grey[300]!,
      child: SizedBox(
        height: 100,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 4,
          shrinkWrap: true,
          itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.all(5),
            child: Column(
              children: [
                const CircleAvatar(
                  radius: 25,
                  backgroundColor: Colors.white,
                ),
                const SizedBox(
                  height: 5,
                ),
                Container(
                  height: 10,
                  width: 40,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                const SizedBox(height: 5),
                Container(
                  height: 10,
                  width: 60,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}