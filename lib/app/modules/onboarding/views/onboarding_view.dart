import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onboarding/onboarding.dart';
import 'package:simplechatapps/app/modules/home/views/home_view.dart';
import 'package:simplechatapps/app/modules/login/controllers/login_controller.dart';
import 'package:simplechatapps/app/modules/login/views/login_view.dart';
import 'package:simplechatapps/app/theme/color.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({Key? key}) : super(key: key);

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  int index = 0;
  final LoginController controller = Get.put(LoginController());

  final onboardingPagesList = [
    PageModel(
      widget: buildPage(
        'assets/images/onboarding/onboarding1.png', // Ganti dengan path yang benar
      ),
    ),
    PageModel(
      widget: buildPage(
        'assets/images/onboarding/onboarding2.png',
      ),
    ),
    PageModel(
      widget: buildPage(
        'assets/images/onboarding/onboarding3.png',
      ),
    ),
  ];

  static Widget buildPage(String imagePath) {
    return Container(
      color: appPurple,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Align(
                alignment: Alignment.topRight,
                child: TextButton(
                    onPressed: () {
                      Get.to(LoginView());
                    },
                    child: Text(
                      'Lewati',
                      style: TextStyle(color: appWhite),
                    ))),
          ),
          Center(
            child: Image.asset(imagePath),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Onboarding(
          pages: onboardingPagesList,
          onPageChange: (int pageIndex) {
            setState(() {
              index = pageIndex; // Mengupdate index ketika halaman berubah
            });
          },
          startPageIndex: 0,
          footerBuilder: (context, dragDistance, pagesLength, setIndex) {
            String footerText;
            String titleFooterText;
            Widget additionalWidget = const SizedBox.shrink();

            switch (index) {
              case 0:
                titleFooterText = 'Selamat Datang di Onanmedia!';
                footerText =
                    'Platform penyedia jasa untuk membantu pekerjaan anda maupun bisnis anda sesuai kebutuhan. ';
                break;
              case 1:
                titleFooterText = 'Layanan Jasa yang Beragam';
                footerText =
                    'Temukan berbagai layanan jasa untuk semua kebutuhan pekerjaan maupun bisnis mu di Onanmedia';
                break;
              case 2:
                titleFooterText =
                    "Berbagai keuntungan yang di peroleh dari Onanmedia";
                footerText =
                    'Penjual jasa berkualitas, fleksebilitas, kemanan bertansaksi, dan pembayaran yang mudah. ';
                additionalWidget = Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  child: InkWell(
                    onTap: () {
                      Get.to(HomeView());
                    },
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      width: MediaQuery.of(context).size.width * 0.8,
                      decoration: BoxDecoration(
                        color: appPurple, // Warna latar belakang Container
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          'Mulai',
                          style: TextStyle(color: appWhite), // Gaya teks
                        ),
                      ),
                    ),
                  ),
                );
                break;
              default:
                titleFooterText = '';
                footerText = '';
            }
            return Container(
              height: MediaQuery.of(context).size.height * 0.4,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: appWhite,
                boxShadow: [
                  BoxShadow(
                    color: appPurple,
                    spreadRadius: 7,
                    blurRadius: 1,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: Text(
                        titleFooterText,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                        textAlign: TextAlign.center,
                        maxLines: 2,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        footerText,
                        style: TextStyle(
                            fontSize: 16, color: Colors.grey.withOpacity(0.2)),
                        maxLines: 3,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Indikator halaman
                          index < 2
                              ? Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: List.generate(pagesLength, (index) {
                                    return Container(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 2.0),
                                      height: 10.0,
                                      width: 10.0,
                                      decoration: BoxDecoration(
                                        color: this.index == index
                                            ? Colors.purple
                                            : Colors.grey.withOpacity(0.2),
                                        shape: BoxShape.circle,
                                      ),
                                    );
                                  }),
                                )
                              : additionalWidget,
                          // Tombol 'Lewati' atau 'Daftar' di halaman terakhir
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
