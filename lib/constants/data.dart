import 'package:get/get.dart';
class GameItems {
  static final List items = [
    {
      'url': 'assets/home/2d_game.png',
      'title': '2D',
      'centerTitle': false,
      'context': 'Guess the 2 Number and Earn Moeny.',
      'onTap': () {
        Get.toNamed('twoddashboard');
      },
    },
    {
      'url': 'assets/home/3d_game.png',
      'title': '3D',
      'centerTitle': false,
      'context': 'Guess the 3 Number and Earn Moeny.',
      'onTap': () {
        Get.toNamed('/threeddashboard');
      },
    },
    {
      'url': 'assets/home/promo_1.png',
      'title': 'Coming Now',
      'centerTitle': true,
      'context': 'coming soon game or promotion.',
      'onTap': () {
        print('promo 1');
      },
    },
    {
      'url': 'assets/home/promo_2.png',
      'title': 'Coming Now',
      'centerTitle': true,
      'context': 'coming soon game or promotion.',
      'onTap': () {
        print('promo 2');
      },
    },
    {
      'url': 'assets/home/promo_1.png',
      'title': 'Coming Now',
      'centerTitle': true,
      'context': 'coming soon game or promotion.',
      'onTap': () {
        print('promo 1');
      },
    },
    {
      'url': 'assets/home/promo_2.png',
      'title': 'Coming Now',
      'centerTitle': true,
      'context': 'coming soon game or promotion.',
      'onTap': () {
        print('promo 2');
      },
    },
  ];
}

class PaymentData {
  static final List paymentData = [
    {
      'url': 'assets/pocket/kbz.png',
      'title': 'KPay',
      'onTab': () {
        Get.toNamed('/deposit',arguments: {
          'url':'assets/pocket/kbz.png',
          'title': 'KPay',
          'method': 'kpay'
        });
      },
    },
    {
      'url': 'assets/pocket/wave.png',
      'title': 'Wave Money',
      'onTab': () {
        Get.toNamed('/deposit',arguments: {
          'url':'assets/pocket/wave.png',
          'title': 'Wave Money',
          'method': 'wave'
        });
      },
    }
  ];
}

class WithdrawData {
  static final List withdrawData = [
    {
      'url': 'assets/pocket/kbz.png',
      'title': 'KPay',
      'onTab': () {
        Get.toNamed('/withdraw',arguments: {
          'url':'assets/pocket/kbz.png',
          'title': 'KPay',
          'method': 'kpay'
        });
      },
    },
    {
      'url': 'assets/pocket/wave.png',
      'title': 'Wave Money',
      'onTab': () {
        Get.toNamed('/withdraw',arguments: {
          'url':'assets/pocket/wave.png',
          'title': 'Wave Money',
          'method': 'wave'
        });
      },
    }
  ];
}
