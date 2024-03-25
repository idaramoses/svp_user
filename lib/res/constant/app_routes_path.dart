import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sharkhub/main_payment.dart';

import 'package:sharkhub/view/categories/main/categories_page.dart';
import 'package:sharkhub/view/electricity/view/other/maharashtra_electricity_page.dart';

import 'package:sharkhub/view/login/main/login_page.dart';
import 'package:sharkhub/view/login/other/forgot_pass/forgot_pass_page.dart';
import 'package:sharkhub/view/login/other/pass_success/pass_success_page.dart';
import 'package:sharkhub/view/login/other/reset_password/reset_pass_page.dart';
import 'package:sharkhub/view/login/other/verification/verification_page.dart';

import 'package:sharkhub/view/onBoarding/onboarding_page.dart';
import 'package:sharkhub/view/package_detail/view/other/payment/payment_page.dart';
import 'package:sharkhub/view/package_detail/view/other/payment/payment_success_page.dart';
import 'package:sharkhub/view/package_detail/view/package_detail_page.dart';
import 'package:sharkhub/view/popular_transaction/trans_detail/payment_trans_detail_page.dart';
import 'package:sharkhub/view/popular_transaction/trans_detail/trans_detail_page.dart';
import 'package:sharkhub/view/popular_transaction/view/popular_transaction_page.dart';

import 'package:sharkhub/view/profile/others/logout/logout_page.dart';
import 'package:sharkhub/view/profile/others/my_profile/edit_profile/edit_profile_page.dart';
import 'package:sharkhub/view/profile/others/my_profile/my_profile_page.dart';
import 'package:sharkhub/view/profile/others/terms_and_conditions/terms_and_condition_page.dart';
import 'package:sharkhub/view/signup/view/signup_page.dart';
import 'package:sharkhub/view/transaction/main/transaction_page.dart';
import 'package:sharkhub/view/transaction/main/transaction_page_main.dart';

import '../../main_wrapper.dart';
import '../../view/electricity/view/buy_electricity_bill_page.dart';
import '../../view/electricity/view/rebuy_electricity_bill_page.dart';
import '../../view/home/main/home_page.dart';
import '../../view/home/others/welcome.dart';
import '../../view/login/other/pin_validate/pin_validate.dart';

import '../../view/profile/others/my_profile/edit_profile/update_profile_page.dart';
import '../../view/signup/view/verify_email_page.dart';
import '../../view/splash/splash_page.dart';

class RoutesPath {
  static const initialRoutes = "/";

  static const splashPage = "/SplashPage";
  static const loginPage = "/LogInPage";
  static const pinValidatePage = "/pinValidatePage";
  static const homePage = "/HomePage";
  static const onBoardingPage = "/OnBoardingPage";
  static const signupPage = "/SignUpPage";
  static const forgotPassPage = "/ForgotPasswordPage";
  static const verificationPage = "/VerificationPage";
  static const resetPasswordPage = "/ResetPasswordPage";
  static const passSuccessPage = "/PassSuccessPage";
  static const bottomBarPage = "/BottomBarPage";
  static const finishbottomBarPage = "/FinishBottomBarPage";
  static const categoriesPage = "/CategoriesPage";
  static const popularTransactionPage = "/PopularTransactionPage";
  static const transactionDetailPage = "/TransactionDetailPage";
  static const transactionPage = "/TransactionPage";
  static const termsAndConditionPage = "/TermsAndConditionPage";
  static const myCardsPage = "/MyCardsPage";
  static const rechargePage = "/RechargePage";
  static const packageDetailPage = "/PackageDetailPage";
  static const paymentPage = "/PaymentPage";
  static const paymentSuccessPage = "/PaymentSuccessPage";
  static const electricityBillPage = "/ElectricityBillPage";
  static const rebuyelectricityBillPage = "/RebuyElectricityBillPage";
  static const maharashtraElectricityPage = "/MaharashtraElectricityPage";
  static const movieTicketBookingPage = "/MovieTicketBookingPage";
  static const movieDetailPage = "/MovieDetailPage";
  static const selectSeatPage = "/SelectSeatPage";
  static const paymentDetailPage = "/PaymentDetailPage";
  static const recieptPage = "/RecieptPage";
  static const bookingSuccessPage = "/BookingSuccessPage";
  static const helpPage = "/HelpPage";
  static const logoutPage = "/LogoutPage";
  static const searchFlightPage = "/SearchFlightPage";
  static const flightDetailPage = "/FlightDetailPage";
  static const flightSelectSeatPage = "/FlightSelectSeatPage";
  static const flightPaymentDetail = "/FlightPaymentDetail";
  static const flightBookingDetailPage = "/FlightBookingDetailPage";
  static const myProfilePage = "/MyProfilePage";
  static const editProfilePage = "/EditProfilePage";
  static const addNewCardPage = "/AddNewCardPage";
  static const flightTicketPage = "/FlightTicketPage";
  static const demoPage = "/DemoPage";
  static const verifyEmail = "/verifyEmail";
  static const transactionsmainpage = "/transactions";
  static const Validate = "/Validate";
  static const updateProfilePage = '/updateProfilePage';
  static const paymentTransactionDetailPage = '/paymentTransactionDetailPage';
  static const AddMeterPage = '/AddMeterPage';

  static Map<String, WidgetBuilder> routes = {
    RoutesPath.splashPage: (context) => const SplashPage(),
  };

  static routesFactory(settings) {
    switch (settings.name) {
      case RoutesPath.splashPage:
        return getPage(const SplashPage(), settings);
      case RoutesPath.loginPage:
        return getPage(const LogInPage(), settings);
      case RoutesPath.AddMeterPage:
        return getPage( WelcomeDialog(), settings);
      case RoutesPath.pinValidatePage:
        return getPage(PinCodeScreen(), settings);
      case RoutesPath.homePage:
        return getPage(const HomePage(), settings);
      case RoutesPath.onBoardingPage:
        return getPage(const OnBoardingPage(), settings);
      case RoutesPath.signupPage:
        return getPage(const SignUpPage(), settings);
      case RoutesPath.verifyEmail:
        return getPage(const VerifyEmail(), settings);
      case RoutesPath.forgotPassPage:
        return getPage(const ForgotPasswordPage(), settings);
      case RoutesPath.verificationPage:
        return getPage(const VerificationPage(), settings);
      case RoutesPath.resetPasswordPage:
        return getPage(const ResetPasswordPage(), settings);
      case RoutesPath.passSuccessPage:
        return getPage(const PassSuccessPage(), settings);
      case RoutesPath.bottomBarPage:
        return getPage(MainWrapper(), settings);
      case RoutesPath.finishbottomBarPage:
        return getPage(MainPayment(), settings);
      case RoutesPath.categoriesPage:
        return getPage(const CategoriesPage(), settings);
      case RoutesPath.transactionDetailPage:
        return getPage(const TransactionDetailPage(), settings);
      case RoutesPath.paymentTransactionDetailPage:
        return getPage(const PaymentTransactionDetailPage(), settings);
      case RoutesPath.transactionPage:
        return getPage(const TransactionPage(), settings);
      case RoutesPath.transactionsmainpage:
        return getPage(const TransactionMainPage(), settings);
      case RoutesPath.termsAndConditionPage:
        return getPage(const TermsAndConditionPage(), settings);

      case RoutesPath.packageDetailPage:
        return getPage(const PackageDetailPage(), settings);
      case RoutesPath.paymentPage:
        return getPage(const PaymentPage(), settings);
      case RoutesPath.paymentSuccessPage:
        return getPage(const PaymentSuccessPage(), settings);
      case RoutesPath.electricityBillPage:
        return getPage(const BuyElectricityBillPage(), settings);
      case RoutesPath.rebuyelectricityBillPage:
        return getPage(const RebuyElectricityBillPage(), settings);
      case RoutesPath.maharashtraElectricityPage:
        return getPage(const MaharashtraElectricityPage(), settings);
      // case RoutesPath.movieTicketBookingPage:
      //   return getPage(const MovieTicketBookingPage(), settings);
      // case RoutesPath.movieDetailPage:
      //   return getPage(const MovieDetailPage(), settings);
      // case RoutesPath.selectSeatPage:
      //   return getPage(const SelectSeatPage(), settings);
      // case RoutesPath.paymentDetailPage:
      //   return getPage(const PaymentDetailPage(), settings);
      // case RoutesPath.recieptPage:
      //   return getPage(const RecieptPage(), settings);
      // case RoutesPath.bookingSuccessPage:
      //   return getPage(const BookingSuccessPage(), settings);
      // case RoutesPath.helpPage:
      //   return getPage(const HelpPage(), settings);
      case RoutesPath.logoutPage:
        return getPage(const LogoutPage(), settings);
      // case RoutesPath.searchFlightPage:
      //   return getPage(const SearchFlightPage(), settings);
      // case RoutesPath.flightDetailPage:
      //   return getPage(const FlightDetailPage(), settings);
      // case RoutesPath.flightSelectSeatPage:
      //   return getPage(const FlightSelectSeatPage(), settings);
      // case RoutesPath.flightPaymentDetail:
      //   return getPage(const FlightPaymentDetail(), settings);
      // case RoutesPath.flightBookingDetailPage:
      //   return getPage(const FlightBookingDetailPage(), settings);
      case RoutesPath.myProfilePage:
        return getPage(const MyProfilePage(), settings);
      case RoutesPath.editProfilePage:
        return getPage(const EditProfilePage(), settings);
      case RoutesPath.updateProfilePage:
        return getPage(const UpdateProfilePage(), settings);
      // case RoutesPath.addNewCardPage:
      //   return getPage(const AddNewCardPage(), settings);
      // case RoutesPath.flightTicketPage:
      //   return getPage(const FlightTicketPage(), settings);
      default:
        return null;
    }
  }

  static getPage(var child, var settings) {
    var type = PageTransitionType.rightToLeftWithFade;

    return PageTransition(
      child: child,
      type: type,
      duration: Durations.medium4,
      settings: settings,
    );
  }
}
