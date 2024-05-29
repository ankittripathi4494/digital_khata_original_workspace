import 'package:flutter/cupertino.dart';

import 'module/Emi/emi_screen.dart';
import 'module/account/account_screen.dart';
import 'module/add_business/add_new_business_screen.dart';
import 'module/applock/app_lock_screen.dart';
import 'module/applock/lock_type_screen.dart';
import 'module/applock/pattern/confirm_pattern_screen.dart';
import 'module/applock/pattern/set_pattern_screen.dart';
import 'module/applock/pinlock/confirm_pin_lock_screen.dart';
import 'module/applock/pinlock/pin_lock_screen.dart';
import 'module/bill/create_bill_screen.dart';
import 'module/bill_plan/bill_plan_screen.dart';
import 'module/business/business_screen.dart';
import 'module/business/update_business_profile_screen.dart';
import 'module/business_type/business_type_screen.dart';
import 'module/custom_amount/custom_amount_screen.dart';
import 'module/customers/select_customer_screen.dart';
import 'module/dashboard/screens/dashboard_screen.dart';
import 'module/discount/discount_screen.dart';
import 'module/edit_profile/edit_personal_profile.dart';
import 'module/errors/screens/network_error_screen.dart';
import 'module/errors/screens/page_error_screen.dart';
import 'module/help_support/help_support_screen.dart';
import 'module/howitworks/howitworks_screen.dart';
import 'module/invoice/create_invoice_screen.dart';
import 'module/invoice/invoice_screen.dart';
import 'module/language/choose_language_screen.dart';
import 'module/login/login_screen.dart';
import 'module/mobile_otp/mobile_otp_screen.dart';
import 'module/notification/enable_notification_screen.dart';
import 'module/payments/my_payment_screen.dart';
import 'module/payments/payment_configuration_screen.dart';
import 'module/payments/upi_payment_screen.dart';
import 'module/plan/emi_plan_screen.dart';
import 'module/plan/new_emi_plan_screen.dart';
import 'module/plan/plan_screen.dart';
import 'module/plan/recurring_new_bill_plan_screen.dart';
import 'module/privacy_policy/privacy_policy_screen.dart';
import 'module/privacy_policy/terms_condition_screen.dart';
import 'module/product/product_detail_screen.dart';
import 'module/product/product_screen.dart';
import 'module/purchases/my_purchases_screen.dart';
import 'module/recurring/recurring_bill_screen.dart';
import 'module/recurring/recurring_invoice_screen.dart';
import 'module/recurring/recurring_transaction_screen.dart';
import 'module/reminder_activity/reminder_activity.dart';
import 'module/reward/reward_screen.dart';
import 'module/service/service_detail_screen.dart';
import 'module/service/service_screen.dart';
import 'module/sms/select_sms_template_screen.dart';
import 'module/sms/sms_credit_screen.dart';
import 'module/sms/sms_reminder_setting_screen.dart';
import 'module/splash/splash_screen.dart';
import 'module/subscription/checkout/checkout_diamond_screen.dart';
import 'module/subscription/checkout/checkout_platinum_screen.dart';
import 'module/subscription/subscription_screen.dart';
import 'module/tax/tax_screen.dart';
import 'module/transaction/new_transaction_plan_screen.dart';

class RouteAccessGenerator {
  static Route<dynamic> routerFunc(RouteSettings settings) {
    var arguments = settings.arguments;
    switch (settings.name) {
      case '/':
        if (arguments is Map<String, dynamic>) {
          return CupertinoPageRoute(
            builder: (context) => const SplashScreen(),
          );
        }
        return CupertinoPageRoute(
          builder: (context) => const SplashScreen(),
        );
      case '/dashboard':
        if (arguments is Map<String, dynamic>) {
          return CupertinoPageRoute(
            builder: (context) => DashboardScreen(
              argus: arguments,
            ),
          );
        }
        return CupertinoPageRoute(
          builder: (context) => DashboardScreen(
            argus: const {},
          ),
        );
      case '/how-It-works':
        if (arguments is Map<String, dynamic>) {
          return CupertinoPageRoute(
            builder: (context) => HowItWorksScreen(
              argus: arguments,
            ),
          );
        }
        return CupertinoPageRoute(
          builder: (context) => HowItWorksScreen(
            argus: const {},
          ),
        );
      case '/login':
        if (arguments is Map<String, dynamic>) {
          return CupertinoPageRoute(
            builder: (context) => LoginScreen(
              argus: arguments,
            ),
          );
        }
        return CupertinoPageRoute(
          builder: (context) => LoginScreen(
            argus: const {},
          ),
        );
      case '/app-lock':
        if (arguments is Map<String, dynamic>) {
          return CupertinoPageRoute(
            builder: (context) => AppLockScreen(
              argus: arguments,
            ),
          );
        }
        return CupertinoPageRoute(
          builder: (context) => AppLockScreen(
            argus: const {},
          ),
        );
      case '/app-lock/set-pattern':
        if (arguments is Map<String, dynamic>) {
          return CupertinoPageRoute(
            builder: (context) => SetPatternScreen(
              argus: arguments,
            ),
          );
        }
        return CupertinoPageRoute(
          builder: (context) => SetPatternScreen(
            argus: const {},
          ),
        );
      case '/app-lock/confirm-set-pattern':
        if (arguments is Map<String, dynamic>) {
          return CupertinoPageRoute(
            builder: (context) => ConfirmPatternScreen(
              argus: arguments,
            ),
          );
        }
        return CupertinoPageRoute(
          builder: (context) => ConfirmPatternScreen(
            argus: const {},
          ),
        );
      case '/app-lock/pin-lock':
        if (arguments is Map<String, dynamic>) {
          return CupertinoPageRoute(
            builder: (context) => PinLockScreen(
              argus: arguments,
            ),
          );
        }
        return CupertinoPageRoute(
          builder: (context) => PinLockScreen(
            argus: const {},
          ),
        );
      case '/app-lock/confirm-pin-lock':
        if (arguments is Map<String, dynamic>) {
          return CupertinoPageRoute(
            builder: (context) => ConfirmPinLockScreen(
              argus: arguments,
            ),
          );
        }
        return CupertinoPageRoute(
          builder: (context) => ConfirmPinLockScreen(
            argus: const {},
          ),
        );
      case '/lock-type':
        if (arguments is Map<String, dynamic>) {
          return CupertinoPageRoute(
            builder: (context) => LockTypeScreen(
              argus: arguments,
            ),
          );
        }
        return CupertinoPageRoute(
          builder: (context) => LockTypeScreen(
            argus: const {},
          ),
        );
      case '/mobile-otp':
        if (arguments is Map<String, dynamic>) {
          return CupertinoPageRoute(
            builder: (context) => MobileOtpScreen(
              argus: arguments,
            ),
          );
        }
        return CupertinoPageRoute(
          builder: (context) => MobileOtpScreen(
            argus: const {},
          ),
        );
      case '/choose-language':
        if (arguments is Map<String, dynamic>) {
          return CupertinoPageRoute(
            builder: (context) => ChooseLanguageScreen(
              argus: arguments,
            ),
          );
        }
        return CupertinoPageRoute(
          builder: (context) => ChooseLanguageScreen(
            argus: const {},
          ),
        );
      case '/enable-notification':
        if (arguments is Map<String, dynamic>) {
          return CupertinoPageRoute(
            builder: (context) => EnableNotificationScreen(
              argus: arguments,
            ),
          );
        }
        return CupertinoPageRoute(
          builder: (context) => EnableNotificationScreen(
            argus: const {},
          ),
        );
      case '/privacy-policy':
        if (arguments is Map<String, dynamic>) {
          return CupertinoPageRoute(
            builder: (context) => PrivacyPolicyScreen(
              argus: arguments,
            ),
          );
        }
        return CupertinoPageRoute(
          builder: (context) => PrivacyPolicyScreen(
            argus: const {},
          ),
        );
      case '/terms-and-condition':
        if (arguments is Map<String, dynamic>) {
          return CupertinoPageRoute(
            builder: (context) => TermsConditionScreen(
              argus: arguments,
            ),
          );
        }
        return CupertinoPageRoute(
          builder: (context) => TermsConditionScreen(
            argus: const {},
          ),
        );
      case '/invoice':
        if (arguments is Map<String, dynamic>) {
          return CupertinoPageRoute(
            builder: (context) => InVoiceScreen(
              argus: arguments,
            ),
          );
        }
        return CupertinoPageRoute(
          builder: (context) => InVoiceScreen(
            argus: const {},
          ),
        );
      case '/create-invoice':
        if (arguments is Map<String, dynamic>) {
          return CupertinoPageRoute(
            builder: (context) => CreateInvoiceScreen(
              argus: arguments,
            ),
          );
        }
        return CupertinoPageRoute(
          builder: (context) => CreateInvoiceScreen(
            argus: const {},
          ),
        );
      case '/create-bill':
        if (arguments is Map<String, dynamic>) {
          return CupertinoPageRoute(
            builder: (context) => CreateBillScreen(
              argus: arguments,
            ),
          );
        }
        return CupertinoPageRoute(
          builder: (context) => CreateBillScreen(
            argus: const {},
          ),
        );
      case '/accounts':
        if (arguments is Map<String, dynamic>) {
          return CupertinoPageRoute(
            builder: (context) => AccountScreeen(
              argus: arguments,
            ),
          );
        }
        return CupertinoPageRoute(
          builder: (context) => AccountScreeen(
            argus: const {},
          ),
        );
      case '/business':
        if (arguments is Map<String, dynamic>) {
          return CupertinoPageRoute(
            builder: (context) => BusinessScreen(
              argus: arguments,
            ),
          );
        }
        return CupertinoPageRoute(
          builder: (context) => BusinessScreen(
            argus: const {},
          ),
        );
      case '/add-new-business':
        if (arguments is Map<String, dynamic>) {
          return CupertinoPageRoute(
            builder: (context) => AddNewBusinessScreen(
              argus: arguments,
            ),
          );
        }
        return CupertinoPageRoute(
          builder: (context) => AddNewBusinessScreen(
            argus: const {},
          ),
        );
      case '/business-type':
        if (arguments is Map<String, dynamic>) {
          return CupertinoPageRoute(
            builder: (context) => BusinessTypeScreen(
              argus: arguments,
            ),
          );
        }
        return CupertinoPageRoute(
          builder: (context) => BusinessTypeScreen(
            argus: const {},
          ),
        );
      case '/edit-personal-profile':
        if (arguments is Map<String, dynamic>) {
          return CupertinoPageRoute(
            builder: (context) => EditPersonalProfileScreen(
              argus: arguments,
            ),
          );
        }
        return CupertinoPageRoute(
          builder: (context) => EditPersonalProfileScreen(
            argus: const {},
          ),
        );
      case '/update-business-profile':
        if (arguments is Map<String, dynamic>) {
          return CupertinoPageRoute(
            builder: (context) => UpdateBusinessProfileScreen(
              argus: arguments,
            ),
          );
        }
        return CupertinoPageRoute(
          builder: (context) => UpdateBusinessProfileScreen(
            argus: const {},
          ),
        );
      case '/recurring-transaction':
        if (arguments is Map<String, dynamic>) {
          return CupertinoPageRoute(
            builder: (context) => RecurringTransactionScreen(
              argus: arguments,
            ),
          );
        }
        return CupertinoPageRoute(
          builder: (context) => RecurringTransactionScreen(
            argus: const {},
          ),
        );
      case '/recurring-new-bill-plan':
        if (arguments is Map<String, dynamic>) {
          return CupertinoPageRoute(
            builder: (context) => RecurringNewBillPlanScreen(
              argus: arguments,
            ),
          );
        }
        return CupertinoPageRoute(
          builder: (context) => RecurringNewBillPlanScreen(
            argus: const {},
          ),
        );
      case '/new-transaction-plan':
        if (arguments is Map<String, dynamic>) {
          return CupertinoPageRoute(
            builder: (context) => NewTransactionPlanScreen(
              argus: arguments,
            ),
          );
        }
        return CupertinoPageRoute(
          builder: (context) => NewTransactionPlanScreen(
            argus: const {},
          ),
        );
      case '/new-emi-plan':
        if (arguments is Map<String, dynamic>) {
          return CupertinoPageRoute(
            builder: (context) => NewEmiPlanScreen(
              argus: arguments,
            ),
          );
        }
        return CupertinoPageRoute(
          builder: (context) => NewEmiPlanScreen(
            argus: const {},
          ),
        );
      case '/recurring-invoice':
        if (arguments is Map<String, dynamic>) {
          return CupertinoPageRoute(
            builder: (context) => RecurringInvoiceScreen(
              argus: arguments,
            ),
          );
        }
        return CupertinoPageRoute(
          builder: (context) => RecurringInvoiceScreen(
            argus: const {},
          ),
        );
      case '/recurring-bill':
        if (arguments is Map<String, dynamic>) {
          return CupertinoPageRoute(
            builder: (context) => RecurringBillScreen(
              argus: arguments,
            ),
          );
        }
        return CupertinoPageRoute(
          builder: (context) => RecurringBillScreen(
            argus: const {},
          ),
        );
      case '/sms-credit':
        if (arguments is Map<String, dynamic>) {
          return CupertinoPageRoute(
            builder: (context) => SmsCreditScreen(
              argus: arguments,
            ),
          );
        }
        return CupertinoPageRoute(
          builder: (context) => SmsCreditScreen(
            argus: const {},
          ),
        );
      case '/whatsapp-credit':
        if (arguments is Map<String, dynamic>) {
          return CupertinoPageRoute(
            builder: (context) => SmsCreditScreen(
              argus: arguments,
            ),
          );
        }
        return CupertinoPageRoute(
          builder: (context) => SmsCreditScreen(
            argus: const {},
          ),
        );
      case '/my-purchase':
        if (arguments is Map<String, dynamic>) {
          return CupertinoPageRoute(
            builder: (context) => MyPurchasesScreen(
              argus: arguments,
            ),
          );
        }
        return CupertinoPageRoute(
          builder: (context) => MyPurchasesScreen(
            argus: const {},
          ),
        );
      case '/help-and-support':
        if (arguments is Map<String, dynamic>) {
          return CupertinoPageRoute(
            builder: (context) => HelpSupportScreen(
              argus: arguments,
            ),
          );
        }
        return CupertinoPageRoute(
          builder: (context) => HelpSupportScreen(
            argus: const {},
          ),
        );
      case '/my-payments':
        if (arguments is Map<String, dynamic>) {
          return CupertinoPageRoute(
            builder: (context) => MyPaymentScreen(
              argus: arguments,
            ),
          );
        }
        return CupertinoPageRoute(
          builder: (context) => MyPaymentScreen(
            argus: const {},
          ),
        );
      case '/payment-configuration':
        if (arguments is Map<String, dynamic>) {
          return CupertinoPageRoute(
            builder: (context) => PaymentConfigurationScreen(
              argus: arguments,
            ),
          );
        }
        return CupertinoPageRoute(
          builder: (context) => PaymentConfigurationScreen(
            argus: const {},
          ),
        );
      case '/remainder':
        if (arguments is Map<String, dynamic>) {
          return CupertinoPageRoute(
            builder: (context) => ReminderActivity(
              argus: arguments,
            ),
          );
        }
        return CupertinoPageRoute(
          builder: (context) => ReminderActivity(
            argus: const {},
          ),
        );
      case '/reward-point':
        if (arguments is Map<String, dynamic>) {
          return CupertinoPageRoute(
            builder: (context) => RewardScreen(
              argus: arguments,
            ),
          );
        }
        return CupertinoPageRoute(
          builder: (context) => RewardScreen(
            argus: const {},
          ),
        );
      case '/subscription':
        if (arguments is Map<String, dynamic>) {
          return CupertinoPageRoute(
            builder: (context) => SubscriptionScreen(
              argus: arguments,
            ),
          );
        }
        return CupertinoPageRoute(
          builder: (context) => SubscriptionScreen(
            argus: const {},
          ),
        );
      case '/emi':
        if (arguments is Map<String, dynamic>) {
          return CupertinoPageRoute(
            builder: (context) => EmiScreen(
              argus: arguments,
            ),
          );
        }
        return CupertinoPageRoute(
          builder: (context) => EmiScreen(
            argus: const {},
          ),
        );
      case '/emi-plan':
        if (arguments is Map<String, dynamic>) {
          return CupertinoPageRoute(
            builder: (context) => EmiPlanScreen(
              argus: arguments,
            ),
          );
        }
        return CupertinoPageRoute(
          builder: (context) => EmiPlanScreen(
            argus: const {},
          ),
        );
      case '/check-diamond':
        if (arguments is Map<String, dynamic>) {
          return CupertinoPageRoute(
            builder: (context) => CheckoutDiamondScreen(
              argus: arguments,
            ),
          );
        }
        return CupertinoPageRoute(
          builder: (context) => CheckoutDiamondScreen(
            argus: const {},
          ),
        );
      case '/check-platinum':
        if (arguments is Map<String, dynamic>) {
          return CupertinoPageRoute(
            builder: (context) => CheckoutPlatinumScreen(
              argus: arguments,
            ),
          );
        }
        return CupertinoPageRoute(
          builder: (context) => CheckoutPlatinumScreen(
            argus: const {},
          ),
        );
      case '/select-customer':
        if (arguments is Map<String, dynamic>) {
          return CupertinoPageRoute(
            builder: (context) => SelectCustomerScreen(
              argus: arguments,
            ),
          );
        }
        return CupertinoPageRoute(
          builder: (context) => SelectCustomerScreen(
            argus: const {},
          ),
        );
      case '/upi-payment':
        if (arguments is Map<String, dynamic>) {
          return CupertinoPageRoute(
            builder: (context) => UpiPaymentScreen(
              argus: arguments,
            ),
          );
        }
        return CupertinoPageRoute(
          builder: (context) => UpiPaymentScreen(
            argus: const {},
          ),
        );
      case '/no-internet':
        if (arguments is Map<String, dynamic>) {
          return CupertinoPageRoute(
            builder: (context) => NetworkErrorScreen(
              argus: arguments,
            ),
          );
        }
        return CupertinoPageRoute(
          builder: (context) => NetworkErrorScreen(
            argus: const {},
          ),
        );
      case '/service':
        if (arguments is Map<String, dynamic>) {
          return CupertinoPageRoute(
            builder: (context) => ServiceScreen(
              argus: arguments,
            ),
          );
        }
        return CupertinoPageRoute(
          builder: (context) => ServiceScreen(
            argus: const {},
          ),
        );
      case '/service-details':
        if (arguments is Map<String, dynamic>) {
          return CupertinoPageRoute(
            builder: (context) => ServiceDetailScreen(
              argus: arguments,
            ),
          );
        }
        return CupertinoPageRoute(
          builder: (context) => ServiceDetailScreen(
            argus: const {},
          ),
        );
      case '/discount':
        if (arguments is Map<String, dynamic>) {
          return CupertinoPageRoute(
            builder: (context) => DiscountScreen(
              argus: arguments,
            ),
          );
        }
        return CupertinoPageRoute(
          builder: (context) => DiscountScreen(
            argus: const {},
          ),
        );
      case '/tax':
        if (arguments is Map<String, dynamic>) {
          return CupertinoPageRoute(
            builder: (context) => TaxScreen(
              argus: arguments,
            ),
          );
        }
        return CupertinoPageRoute(
          builder: (context) => TaxScreen(
            argus: const {},
          ),
        );
      case '/product':
        if (arguments is Map<String, dynamic>) {
          return CupertinoPageRoute(
            builder: (context) => ProductScreen(
              argus: arguments,
            ),
          );
        }
        return CupertinoPageRoute(
          builder: (context) => ProductScreen(
            argus: const {},
          ),
        );
      case '/product-detail':
        if (arguments is Map<String, dynamic>) {
          return CupertinoPageRoute(
            builder: (context) => ProductDetailScreen(
              argus: arguments,
            ),
          );
        }
        return CupertinoPageRoute(
          builder: (context) => ProductDetailScreen(
            argus: const {},
          ),
        );
      case '/plan':
        if (arguments is Map<String, dynamic>) {
          return CupertinoPageRoute(
            builder: (context) => PlanScreen(
              argus: arguments,
            ),
          );
        }
        return CupertinoPageRoute(
          builder: (context) => PlanScreen(
            argus: const {},
          ),
        );
      case '/bill-plan':
        if (arguments is Map<String, dynamic>) {
          return CupertinoPageRoute(
            builder: (context) => BillPlansScreen(
              argus: arguments,
            ),
          );
        }
        return CupertinoPageRoute(
          builder: (context) => BillPlansScreen(
            argus: const {},
          ),
        );
      case '/custom-amount':
        if (arguments is Map<String, dynamic>) {
          return CupertinoPageRoute(
            builder: (context) => CustomAmountScreen(
              argus: arguments,
            ),
          );
        }
        return CupertinoPageRoute(
          builder: (context) => CustomAmountScreen(
            argus: const {},
          ),
        );
      case '/select-sms-template':
        if (arguments is Map<String, dynamic>) {
          return CupertinoPageRoute(
            builder: (context) => SelectSmsTemplatesScreen(
              argus: arguments,
            ),
          );
        }
        return CupertinoPageRoute(
          builder: (context) => SelectSmsTemplatesScreen(
            argus: const {},
          ),
        );
      case '/sms-remainder-settings':
        if (arguments is Map<String, dynamic>) {
          return CupertinoPageRoute(
            builder: (context) => SmsReminderSettingscreen(
              argus: arguments,
            ),
          );
        }
        return CupertinoPageRoute(
          builder: (context) => SmsReminderSettingscreen(
            argus: const {},
          ),
        );
      default:
        return _errorRoute(settings);
    }
  }

  static Route<dynamic> _errorRoute(RouteSettings settings) {
    var arguments = settings.arguments;
    if (arguments is Map<String, dynamic>) {
      return CupertinoPageRoute(
        builder: (context) => PageErrorScreen(
          argus: arguments,
        ),
      );
    }
    return CupertinoPageRoute(
      builder: (context) => PageErrorScreen(
        argus: const {},
      ),
    );
  }
}
