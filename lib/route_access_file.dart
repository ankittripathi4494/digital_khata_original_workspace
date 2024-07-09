import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';
import 'module/emi/emi_screen.dart';
import 'module/account/account_screen.dart';
import 'module/add_business/add_address_business_screen.dart';
import 'module/add_business/add_new_business_screen.dart';
import 'module/applock/app_lock_screen.dart';
import 'module/applock/lock_type_screen.dart';
import 'module/applock/pattern/confirm_pattern_screen.dart';
import 'module/applock/pattern/set_pattern_screen.dart';
import 'module/applock/pinlock/confirm_pin_lock_screen.dart';
import 'module/applock/pinlock/pin_lock_screen.dart';
import 'module/bill/create_bill_screen.dart';
import 'module/bill_plan/bill_plan_screen.dart';
import 'module/business/business_bloc/business_bloc.dart';
import 'module/business/business_screen.dart';
import 'module/business/contact_verifiction_screen.dart';
import 'module/business/manage_user_groups.dart';
import 'module/business/update_business_profile_screen.dart';
import 'module/business/user_group_bloc/user_group_bloc.dart';
import 'module/business_type/business_type_bloc/business_type_bloc.dart';
import 'module/business_type/business_type_screen.dart';
import 'module/custom_amount/custom_amount_screen.dart';
import 'module/customers/add_customer_screen.dart';
import 'module/customers/customer_bloc/customer_bloc.dart';
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
import 'module/login/login_bloc/login_bloc.dart';
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
import 'module/profile/amount_due_receive_screen.dart';
import 'module/profile/cashin_screen.dart';
import 'module/profile/cashout_screen.dart';
import 'module/profile/edit_customer_profile_screen.dart';
import 'module/profile/profile_detail_screeen.dart';
import 'module/profile/profile_screen.dart';
import 'module/profile/settlement_screen.dart';
import 'module/profile/transactions/transactions_bloc.dart';
import 'module/profile/writeoff_screen.dart';
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
          return PageTransition(
            duration: const Duration(milliseconds: 500),
            alignment: Alignment.topLeft,
            type: PageTransitionType.fade,
            child: SplashScreen(
              argus: arguments,
            ),
          );
        }
        return PageTransition(
          alignment: Alignment.topLeft,
          duration: const Duration(milliseconds: 500),
          type: PageTransitionType.fade,
          child: SplashScreen(
            argus: const {},
          ),
        );
      case '/dashboard':
        if (arguments is Map<String, dynamic>) {
          return PageTransition(
            duration: const Duration(milliseconds: 500),
            type: PageTransitionType.fade,
            child: BlocProvider(
              create: (context) => BusinessBloc(),
              child: DashboardScreen(
                argus: arguments,
              ),
            ),
          );
        }
        return PageTransition(
          duration: const Duration(milliseconds: 500),
          type: PageTransitionType.fade,
          child: BlocProvider(
            create: (context) => BusinessBloc(),
            child: DashboardScreen(
              argus: const {},
            ),
          ),
        );
      case '/manage-user-group':
        if (arguments is Map<String, dynamic>) {
          return PageTransition(
            duration: const Duration(milliseconds: 500),
            type: PageTransitionType.fade,
            child: BlocProvider(
              create: (context) => UserGroupBloc(),
              child: ManageUseGroups(
                argus: arguments,
              ),
            ),
          );
        }
        return PageTransition(
          duration: const Duration(milliseconds: 500),
          type: PageTransitionType.fade,
          child: BlocProvider(
            create: (context) => UserGroupBloc(),
            child: ManageUseGroups(
              argus: const {},
            ),
          ),
        );
      case '/how-It-works':
        if (arguments is Map<String, dynamic>) {
          return PageTransition(
            duration: const Duration(milliseconds: 500),
            type: PageTransitionType.fade,
            child: HowItWorksScreen(
              argus: arguments,
            ),
          );
        }
        return PageTransition(
          duration: const Duration(milliseconds: 500),
          type: PageTransitionType.fade,
          child: HowItWorksScreen(
            argus: const {},
          ),
        );
      case '/login':
        if (arguments is Map<String, dynamic>) {
          return PageTransition(
            duration: const Duration(milliseconds: 500),
            type: PageTransitionType.fade,
            child: BlocProvider(
              create: (context) => LoginBloc(),
              child: LoginScreen(
                argus: arguments,
              ),
            ),
          );
        }
        return PageTransition(
          duration: const Duration(milliseconds: 500),
          type: PageTransitionType.fade,
          child: BlocProvider(
            create: (context) => LoginBloc(),
            child: LoginScreen(
              argus: const {},
            ),
          ),
        );
      case '/app-lock':
        if (arguments is Map<String, dynamic>) {
          return PageTransition(
            duration: const Duration(milliseconds: 500),
            type: PageTransitionType.fade,
            child: AppLockScreen(
              argus: arguments,
            ),
          );
        }
        return PageTransition(
          duration: const Duration(milliseconds: 500),
          type: PageTransitionType.fade,
          child: AppLockScreen(
            argus: const {},
          ),
        );
      case '/app-lock/set-pattern':
        if (arguments is Map<String, dynamic>) {
          return PageTransition(
            duration: const Duration(milliseconds: 500),
            type: PageTransitionType.fade,
            child: SetPatternScreen(
              argus: arguments,
            ),
          );
        }
        return PageTransition(
          duration: const Duration(milliseconds: 500),
          type: PageTransitionType.fade,
          child: SetPatternScreen(
            argus: const {},
          ),
        );
      case '/app-lock/confirm-set-pattern':
        if (arguments is Map<String, dynamic>) {
          return PageTransition(
            duration: const Duration(milliseconds: 500),
            type: PageTransitionType.fade,
            child: ConfirmPatternScreen(
              argus: arguments,
            ),
          );
        }
        return PageTransition(
          duration: const Duration(milliseconds: 500),
          type: PageTransitionType.fade,
          child: ConfirmPatternScreen(
            argus: const {},
          ),
        );
      case '/app-lock/pin-lock':
        if (arguments is Map<String, dynamic>) {
          return PageTransition(
            duration: const Duration(milliseconds: 500),
            type: PageTransitionType.fade,
            child: PinLockScreen(
              argus: arguments,
            ),
          );
        }
        return PageTransition(
          duration: const Duration(milliseconds: 500),
          type: PageTransitionType.fade,
          child: PinLockScreen(
            argus: const {},
          ),
        );
      case '/app-lock/confirm-pin-lock':
        if (arguments is Map<String, dynamic>) {
          return PageTransition(
            duration: const Duration(milliseconds: 500),
            type: PageTransitionType.fade,
            child: ConfirmPinLockScreen(
              argus: arguments,
            ),
          );
        }
        return PageTransition(
          duration: const Duration(milliseconds: 500),
          type: PageTransitionType.fade,
          child: ConfirmPinLockScreen(
            argus: const {},
          ),
        );
      case '/lock-type':
        if (arguments is Map<String, dynamic>) {
          return PageTransition(
            duration: const Duration(milliseconds: 500),
            type: PageTransitionType.fade,
            child: LockTypeScreen(
              argus: arguments,
            ),
          );
        }
        return PageTransition(
          duration: const Duration(milliseconds: 500),
          type: PageTransitionType.fade,
          child: LockTypeScreen(
            argus: const {},
          ),
        );
      case '/mobile-otp':
        if (arguments is Map<String, dynamic>) {
          return PageTransition(
            duration: const Duration(milliseconds: 500),
            type: PageTransitionType.fade,
            child: MobileOtpScreen(
              argus: arguments,
            ),
          );
        }
        return PageTransition(
          duration: const Duration(milliseconds: 500),
          type: PageTransitionType.fade,
          child: MobileOtpScreen(
            argus: const {},
          ),
        );
      case '/choose-language':
        if (arguments is Map<String, dynamic>) {
          return PageTransition(
            duration: const Duration(milliseconds: 500),
            type: PageTransitionType.fade,
            child: ChooseLanguageScreen(
              argus: arguments,
            ),
          );
        }
        return PageTransition(
          duration: const Duration(milliseconds: 500),
          type: PageTransitionType.fade,
          child: ChooseLanguageScreen(
            argus: const {},
          ),
        );
      case '/enable-notification':
        if (arguments is Map<String, dynamic>) {
          return PageTransition(
            duration: const Duration(milliseconds: 500),
            type: PageTransitionType.fade,
            child: EnableNotificationScreen(
              argus: arguments,
            ),
          );
        }
        return PageTransition(
          duration: const Duration(milliseconds: 500),
          type: PageTransitionType.fade,
          child: EnableNotificationScreen(
            argus: const {},
          ),
        );
      case '/privacy-policy':
        if (arguments is Map<String, dynamic>) {
          return PageTransition(
            duration: const Duration(milliseconds: 500),
            type: PageTransitionType.fade,
            child: PrivacyPolicyScreen(
              argus: arguments,
            ),
          );
        }
        return PageTransition(
          duration: const Duration(milliseconds: 500),
          type: PageTransitionType.fade,
          child: PrivacyPolicyScreen(
            argus: const {},
          ),
        );
      case '/terms-and-condition':
        if (arguments is Map<String, dynamic>) {
          return PageTransition(
            duration: const Duration(milliseconds: 500),
            type: PageTransitionType.fade,
            child: TermsConditionScreen(
              argus: arguments,
            ),
          );
        }
        return PageTransition(
          duration: const Duration(milliseconds: 500),
          type: PageTransitionType.fade,
          child: TermsConditionScreen(
            argus: const {},
          ),
        );
      case '/invoice':
        if (arguments is Map<String, dynamic>) {
          return PageTransition(
            duration: const Duration(milliseconds: 500),
            type: PageTransitionType.fade,
            child: InVoiceScreen(
              argus: arguments,
            ),
          );
        }
        return PageTransition(
          duration: const Duration(milliseconds: 500),
          type: PageTransitionType.fade,
          child: InVoiceScreen(
            argus: const {},
          ),
        );
      case '/create-invoice':
        if (arguments is Map<String, dynamic>) {
          return PageTransition(
            duration: const Duration(milliseconds: 500),
            type: PageTransitionType.fade,
            child: CreateInvoiceScreen(
              argus: arguments,
            ),
          );
        }
        return PageTransition(
          duration: const Duration(milliseconds: 500),
          type: PageTransitionType.fade,
          child: CreateInvoiceScreen(
            argus: const {},
          ),
        );
      case '/create-bill':
        if (arguments is Map<String, dynamic>) {
          return PageTransition(
            duration: const Duration(milliseconds: 500),
            type: PageTransitionType.fade,
            child: CreateBillScreen(
              argus: arguments,
            ),
          );
        }
        return PageTransition(
          duration: const Duration(milliseconds: 500),
          type: PageTransitionType.fade,
          child: CreateBillScreen(
            argus: const {},
          ),
        );
      case '/accounts':
        if (arguments is Map<String, dynamic>) {
          return PageTransition(
            duration: const Duration(milliseconds: 500),
            type: PageTransitionType.fade,
            child: AccountScreeen(
              argus: arguments,
            ),
          );
        }
        return PageTransition(
          duration: const Duration(milliseconds: 500),
          type: PageTransitionType.fade,
          child: AccountScreeen(
            argus: const {},
          ),
        );
      case '/business':
        if (arguments is Map<String, dynamic>) {
          return PageTransition(
            duration: const Duration(milliseconds: 500),
            type: PageTransitionType.fade,
            child: BlocProvider(
              create: (context) => BusinessBloc(),
              child: BusinessScreen(
                argus: arguments,
              ),
            ),
          );
        }
        return PageTransition(
          duration: const Duration(milliseconds: 500),
          type: PageTransitionType.fade,
          child: BlocProvider(
            create: (context) => BusinessBloc(),
            child: BusinessScreen(
              argus: const {},
            ),
          ),
        );
      case '/add-new-business':
        if (arguments is Map<String, dynamic>) {
          return PageTransition(
            duration: const Duration(milliseconds: 500),
            type: PageTransitionType.fade,
            child: BlocProvider(
              create: (context) => BusinessBloc(),
              child: AddNewBusinessScreen(
                argus: arguments,
              ),
            ),
          );
        }
        return PageTransition(
          duration: const Duration(milliseconds: 500),
          type: PageTransitionType.fade,
          child: BlocProvider(
            create: (context) => BusinessBloc(),
            child: AddNewBusinessScreen(
              argus: const {},
            ),
          ),
        );
      case '/business-type':
        if (arguments is Map<String, dynamic>) {
          return MaterialPageRoute(
            fullscreenDialog: true,
            builder: (context) => BlocProvider(
              create: (context) => BusinessTypeBloc(),
              child: BusinessTypeScreen(
                argus: arguments,
              ),
            ),
          );
        }
        return MaterialPageRoute(
          fullscreenDialog: true,
          builder: (context) => BlocProvider(
            create: (context) => BusinessTypeBloc(),
            child: BusinessTypeScreen(
              argus: const {},
            ),
          ),
        );
      case '/add-business-address':
        if (arguments is Map<String, dynamic>) {
          return MaterialPageRoute(
            fullscreenDialog: true,
            builder: (context) => BlocProvider(
              create: (context) => BusinessBloc(),
              child: AddBusinessAddressScreen(
                argus: arguments,
              ),
            ),
          );
        }
        return MaterialPageRoute(
          fullscreenDialog: true,
          builder: (context) => BlocProvider(
            create: (context) => BusinessBloc(),
            child: AddBusinessAddressScreen(
              argus: const {},
            ),
          ),
        );
      case '/edit-personal-profile':
        if (arguments is Map<String, dynamic>) {
          return PageTransition(
            duration: const Duration(milliseconds: 500),
            type: PageTransitionType.fade,
            child: EditPersonalProfileScreen(
              argus: arguments,
            ),
          );
        }
        return PageTransition(
          duration: const Duration(milliseconds: 500),
          type: PageTransitionType.fade,
          child: EditPersonalProfileScreen(
            argus: const {},
          ),
        );
      case '/update-business-profile':
        if (arguments is Map<String, dynamic>) {
          return PageTransition(
            duration: const Duration(milliseconds: 500),
            type: PageTransitionType.fade,
            child: BlocProvider(
              create: (context) => BusinessBloc(),
              child: UpdateBusinessProfileScreen(
                argus: arguments,
              ),
            ),
          );
        }
        return PageTransition(
          duration: const Duration(milliseconds: 500),
          type: PageTransitionType.fade,
          child: BlocProvider(
            create: (context) => BusinessBloc(),
            child: UpdateBusinessProfileScreen(
              argus: const {},
            ),
          ),
        );
      case '/recurring-transaction':
        if (arguments is Map<String, dynamic>) {
          return PageTransition(
            duration: const Duration(milliseconds: 500),
            type: PageTransitionType.fade,
            child: RecurringTransactionScreen(
              argus: arguments,
            ),
          );
        }
        return PageTransition(
          duration: const Duration(milliseconds: 500),
          type: PageTransitionType.fade,
          child: RecurringTransactionScreen(
            argus: const {},
          ),
        );
      case '/recurring-new-bill-plan':
        if (arguments is Map<String, dynamic>) {
          return PageTransition(
            duration: const Duration(milliseconds: 500),
            type: PageTransitionType.fade,
            child: RecurringNewBillPlanScreen(
              argus: arguments,
            ),
          );
        }
        return PageTransition(
          duration: const Duration(milliseconds: 500),
          type: PageTransitionType.fade,
          child: RecurringNewBillPlanScreen(
            argus: const {},
          ),
        );
      case '/new-transaction-plan':
        if (arguments is Map<String, dynamic>) {
          return PageTransition(
            duration: const Duration(milliseconds: 500),
            type: PageTransitionType.fade,
            child: NewTransactionPlanScreen(
              argus: arguments,
            ),
          );
        }
        return PageTransition(
          duration: const Duration(milliseconds: 500),
          type: PageTransitionType.fade,
          child: NewTransactionPlanScreen(
            argus: const {},
          ),
        );
      case '/new-emi-plan':
        if (arguments is Map<String, dynamic>) {
          return PageTransition(
            duration: const Duration(milliseconds: 500),
            type: PageTransitionType.fade,
            child: NewEmiPlanScreen(
              argus: arguments,
            ),
          );
        }
        return PageTransition(
          duration: const Duration(milliseconds: 500),
          type: PageTransitionType.fade,
          child: NewEmiPlanScreen(
            argus: const {},
          ),
        );
      case '/recurring-invoice':
        if (arguments is Map<String, dynamic>) {
          return PageTransition(
            duration: const Duration(milliseconds: 500),
            type: PageTransitionType.fade,
            child: RecurringInvoiceScreen(
              argus: arguments,
            ),
          );
        }
        return PageTransition(
          duration: const Duration(milliseconds: 500),
          type: PageTransitionType.fade,
          child: RecurringInvoiceScreen(
            argus: const {},
          ),
        );
      case '/recurring-bill':
        if (arguments is Map<String, dynamic>) {
          return PageTransition(
            duration: const Duration(milliseconds: 500),
            type: PageTransitionType.fade,
            child: RecurringBillScreen(
              argus: arguments,
            ),
          );
        }
        return PageTransition(
          duration: const Duration(milliseconds: 500),
          type: PageTransitionType.fade,
          child: RecurringBillScreen(
            argus: const {},
          ),
        );
      case '/sms-credit':
        if (arguments is Map<String, dynamic>) {
          return PageTransition(
            duration: const Duration(milliseconds: 500),
            type: PageTransitionType.fade,
            child: SmsCreditScreen(
              argus: arguments,
            ),
          );
        }
        return PageTransition(
          duration: const Duration(milliseconds: 500),
          type: PageTransitionType.fade,
          child: SmsCreditScreen(
            argus: const {},
          ),
        );
      case '/whatsapp-credit':
        if (arguments is Map<String, dynamic>) {
          return PageTransition(
            duration: const Duration(milliseconds: 500),
            type: PageTransitionType.fade,
            child: SmsCreditScreen(
              argus: arguments,
            ),
          );
        }
        return PageTransition(
          duration: const Duration(milliseconds: 500),
          type: PageTransitionType.fade,
          child: SmsCreditScreen(
            argus: const {},
          ),
        );
      case '/my-purchase':
        if (arguments is Map<String, dynamic>) {
          return PageTransition(
            duration: const Duration(milliseconds: 500),
            type: PageTransitionType.fade,
            child: MyPurchasesScreen(
              argus: arguments,
            ),
          );
        }
        return PageTransition(
          duration: const Duration(milliseconds: 500),
          type: PageTransitionType.fade,
          child: MyPurchasesScreen(
            argus: const {},
          ),
        );
      case '/help-and-support':
        if (arguments is Map<String, dynamic>) {
          return PageTransition(
            duration: const Duration(milliseconds: 500),
            type: PageTransitionType.fade,
            child: HelpSupportScreen(
              argus: arguments,
            ),
          );
        }
        return PageTransition(
          duration: const Duration(milliseconds: 500),
          type: PageTransitionType.fade,
          child: HelpSupportScreen(
            argus: const {},
          ),
        );
      case '/my-payments':
        if (arguments is Map<String, dynamic>) {
          return PageTransition(
            duration: const Duration(milliseconds: 500),
            type: PageTransitionType.fade,
            child: MyPaymentScreen(
              argus: arguments,
            ),
          );
        }
        return PageTransition(
          duration: const Duration(milliseconds: 500),
          type: PageTransitionType.fade,
          child: MyPaymentScreen(
            argus: const {},
          ),
        );
      case '/payment-configuration':
        if (arguments is Map<String, dynamic>) {
          return PageTransition(
            duration: const Duration(milliseconds: 500),
            type: PageTransitionType.fade,
            child: PaymentConfigurationScreen(
              argus: arguments,
            ),
          );
        }
        return PageTransition(
          duration: const Duration(milliseconds: 500),
          type: PageTransitionType.fade,
          child: PaymentConfigurationScreen(
            argus: const {},
          ),
        );
      case '/remainder':
        if (arguments is Map<String, dynamic>) {
          return PageTransition(
            duration: const Duration(milliseconds: 500),
            type: PageTransitionType.fade,
            child: ReminderActivity(
              argus: arguments,
            ),
          );
        }
        return PageTransition(
          duration: const Duration(milliseconds: 500),
          type: PageTransitionType.fade,
          child: ReminderActivity(
            argus: const {},
          ),
        );
      case '/reward-point':
        if (arguments is Map<String, dynamic>) {
          return PageTransition(
            duration: const Duration(milliseconds: 500),
            type: PageTransitionType.fade,
            child: RewardScreen(
              argus: arguments,
            ),
          );
        }
        return PageTransition(
          duration: const Duration(milliseconds: 500),
          type: PageTransitionType.fade,
          child: RewardScreen(
            argus: const {},
          ),
        );
      case '/subscription':
        if (arguments is Map<String, dynamic>) {
          return PageTransition(
            duration: const Duration(milliseconds: 500),
            type: PageTransitionType.fade,
            child: SubscriptionScreen(
              argus: arguments,
            ),
          );
        }
        return PageTransition(
          duration: const Duration(milliseconds: 500),
          type: PageTransitionType.fade,
          child: SubscriptionScreen(
            argus: const {},
          ),
        );
      case '/emi':
        if (arguments is Map<String, dynamic>) {
          return PageTransition(
            duration: const Duration(milliseconds: 500),
            type: PageTransitionType.fade,
            child: EmiScreen(
              argus: arguments,
            ),
          );
        }
        return PageTransition(
          duration: const Duration(milliseconds: 500),
          type: PageTransitionType.fade,
          child: EmiScreen(
            argus: const {},
          ),
        );
      case '/emi-plan':
        if (arguments is Map<String, dynamic>) {
          return PageTransition(
            duration: const Duration(milliseconds: 500),
            type: PageTransitionType.fade,
            child: EmiPlanScreen(
              argus: arguments,
            ),
          );
        }
        return PageTransition(
          duration: const Duration(milliseconds: 500),
          type: PageTransitionType.fade,
          child: EmiPlanScreen(
            argus: const {},
          ),
        );
      case '/check-diamond':
        if (arguments is Map<String, dynamic>) {
          return PageTransition(
            duration: const Duration(milliseconds: 500),
            type: PageTransitionType.fade,
            child: CheckoutDiamondScreen(
              argus: arguments,
            ),
          );
        }
        return PageTransition(
          duration: const Duration(milliseconds: 500),
          type: PageTransitionType.fade,
          child: CheckoutDiamondScreen(
            argus: const {},
          ),
        );
      case '/check-platinum':
        if (arguments is Map<String, dynamic>) {
          return PageTransition(
            duration: const Duration(milliseconds: 500),
            type: PageTransitionType.fade,
            child: CheckoutPlatinumScreen(
              argus: arguments,
            ),
          );
        }
        return PageTransition(
          duration: const Duration(milliseconds: 500),
          type: PageTransitionType.fade,
          child: CheckoutPlatinumScreen(
            argus: const {},
          ),
        );
      case '/select-customer':
        if (arguments is Map<String, dynamic>) {
          return PageTransition(
            duration: const Duration(milliseconds: 500),
            type: PageTransitionType.fade,
            child: SelectCustomerScreen(
              argus: arguments,
            ),
          );
        }
        return PageTransition(
          duration: const Duration(milliseconds: 500),
          type: PageTransitionType.fade,
          child: SelectCustomerScreen(
            argus: const {},
          ),
        );
      case '/add-customer':
        if (arguments is Map<String, dynamic>) {
          return PageTransition(
            duration: const Duration(milliseconds: 500),
            type: PageTransitionType.fade,
            child: BlocProvider(
              create: (context) => CustomerBloc(),
              child: AddCustomerScreen(
                argus: arguments,
              ),
            ),
          );
        }
        return PageTransition(
          duration: const Duration(milliseconds: 500),
          type: PageTransitionType.fade,
          child: BlocProvider(
            create: (context) => CustomerBloc(),
            child: AddCustomerScreen(
              argus: const {},
            ),
          ),
        );
      case '/customer-screen-details':
        if (arguments is Map<String, dynamic>) {
          return PageTransition(
            duration: const Duration(milliseconds: 500),
            type: PageTransitionType.fade,
            child: BlocProvider(
              create: (context) => CustomerBloc(),
              child: ProfileScreen(
                argus: arguments,
              ),
            ),
          );
        }
        return PageTransition(
          duration: const Duration(milliseconds: 500),
          type: PageTransitionType.fade,
          child: BlocProvider(
            create: (context) => CustomerBloc(),
            child: ProfileScreen(
              argus: const {},
            ),
          ),
        );
      case '/edit-customer-screen':
        if (arguments is Map<String, dynamic>) {
          return PageTransition(
            duration: const Duration(milliseconds: 500),
            type: PageTransitionType.fade,
            child: BlocProvider(
              create: (context) => CustomerBloc(),
              child: EditCustomerScreen(
                argus: arguments,
              ),
            ),
          );
        }
        return PageTransition(
          duration: const Duration(milliseconds: 500),
          type: PageTransitionType.fade,
          child: BlocProvider(
            create: (context) => CustomerBloc(),
            child: EditCustomerScreen(
              argus: const {},
            ),
          ),
        );
      case '/customer-screen-full-details':
        if (arguments is Map<String, dynamic>) {
          return PageTransition(
            duration: const Duration(milliseconds: 500),
            type: PageTransitionType.fade,
            child: BlocProvider(
              create: (context) => CustomerBloc(),
              child: ProfileDetailScreen(
                argus: arguments,
              ),
            ),
          );
        }
        return PageTransition(
          duration: const Duration(milliseconds: 500),
          type: PageTransitionType.fade,
          child: BlocProvider(
            create: (context) => CustomerBloc(),
            child: ProfileDetailScreen(
              argus: const {},
            ),
          ),
        );
      case '/contact-verification':
        if (arguments is Map<String, dynamic>) {
          return PageTransition(
              duration: const Duration(milliseconds: 500),
              type: PageTransitionType.fade,
              child: ContactVerificationScreen(
                argus: arguments,
              ),
              fullscreenDialog: true);
        }
        return PageTransition(
            duration: const Duration(milliseconds: 500),
            type: PageTransitionType.fade,
            child: ContactVerificationScreen(
              argus: const {},
            ),
            fullscreenDialog: true);
      case '/cash-in-screen':
        if (arguments is Map<String, dynamic>) {
          return PageTransition(
            duration: const Duration(milliseconds: 500),
            type: PageTransitionType.fade,
            child: BlocProvider(
              create: (context) => TransactionsBloc(),
              child: CashInScreen(
                argus: arguments,
              ),
            ),
          );
        }
        return PageTransition(
          duration: const Duration(milliseconds: 500),
          type: PageTransitionType.fade,
          child: BlocProvider(
            create: (context) => TransactionsBloc(),
            child: CashInScreen(
              argus: const {},
            ),
          ),
        );
      case '/cash-out-screen':
        if (arguments is Map<String, dynamic>) {
          return PageTransition(
            duration: const Duration(milliseconds: 500),
            type: PageTransitionType.fade,
            child: BlocProvider(
              create: (context) => TransactionsBloc(),
              child: CashOutScreen(
                argus: arguments,
              ),
            ),
          );
        }
        return PageTransition(
          duration: const Duration(milliseconds: 500),
          type: PageTransitionType.fade,
          child: BlocProvider(
            create: (context) => TransactionsBloc(),
            child: CashOutScreen(
              argus: const {},
            ),
          ),
        );
      case '/amount-due-receive-screen':
        if (arguments is Map<String, dynamic>) {
          return PageTransition(
            duration: const Duration(milliseconds: 500),
            type: PageTransitionType.fade,
            child: BlocProvider(
              create: (context) => TransactionsBloc(),
              child: AmountDueReceiveScreen(
                argus: arguments,
              ),
            ),
          );
        }
        return PageTransition(
          duration: const Duration(milliseconds: 500),
          type: PageTransitionType.fade,
          child: BlocProvider(
            create: (context) => TransactionsBloc(),
            child: AmountDueReceiveScreen(
              argus: const {},
            ),
          ),
        );
      case '/settlement-screen':
        if (arguments is Map<String, dynamic>) {
          return PageTransition(
            duration: const Duration(milliseconds: 500),
            type: PageTransitionType.fade,
            child: BlocProvider(
              create: (context) => TransactionsBloc(),
              child: SettlementScreen(
                argus: arguments,
              ),
            ),
          );
        }
        return PageTransition(
          duration: const Duration(milliseconds: 500),
          type: PageTransitionType.fade,
          child: BlocProvider(
            create: (context) => TransactionsBloc(),
            child: SettlementScreen(
              argus: const {},
            ),
          ),
        );
      case '/writoff-screen':
        if (arguments is Map<String, dynamic>) {
          return PageTransition(
            duration: const Duration(milliseconds: 500),
            type: PageTransitionType.fade,
            child: BlocProvider(
              create: (context) => TransactionsBloc(),
              child: WriteOffScreen(
                argus: arguments,
              ),
            ),
          );
        }
        return PageTransition(
          duration: const Duration(milliseconds: 500),
          type: PageTransitionType.fade,
          child: BlocProvider(
            create: (context) => TransactionsBloc(),
            child: WriteOffScreen(
              argus: const {},
            ),
          ),
        );
      case '/upi-payment':
        if (arguments is Map<String, dynamic>) {
          return PageTransition(
            duration: const Duration(milliseconds: 500),
            type: PageTransitionType.fade,
            child: UpiPaymentScreen(
              argus: arguments,
            ),
          );
        }
        return PageTransition(
          duration: const Duration(milliseconds: 500),
          type: PageTransitionType.fade,
          child: UpiPaymentScreen(
            argus: const {},
          ),
        );
      case '/no-internet':
        if (arguments is Map<String, dynamic>) {
          return PageTransition(
            duration: const Duration(milliseconds: 500),
            type: PageTransitionType.fade,
            child: NetworkErrorScreen(
              argus: arguments,
            ),
          );
        }
        return PageTransition(
          duration: const Duration(milliseconds: 500),
          type: PageTransitionType.fade,
          child: NetworkErrorScreen(
            argus: const {},
          ),
        );
      case '/service':
        if (arguments is Map<String, dynamic>) {
          return PageTransition(
            duration: const Duration(milliseconds: 500),
            type: PageTransitionType.fade,
            child: ServiceScreen(
              argus: arguments,
            ),
          );
        }
        return PageTransition(
          duration: const Duration(milliseconds: 500),
          type: PageTransitionType.fade,
          child: ServiceScreen(
            argus: const {},
          ),
        );
      case '/service-details':
        if (arguments is Map<String, dynamic>) {
          return PageTransition(
            duration: const Duration(milliseconds: 500),
            type: PageTransitionType.fade,
            child: ServiceDetailScreen(
              argus: arguments,
            ),
          );
        }
        return PageTransition(
          duration: const Duration(milliseconds: 500),
          type: PageTransitionType.fade,
          child: ServiceDetailScreen(
            argus: const {},
          ),
        );
      case '/discount':
        if (arguments is Map<String, dynamic>) {
          return PageTransition(
            duration: const Duration(milliseconds: 500),
            type: PageTransitionType.fade,
            child: DiscountScreen(
              argus: arguments,
            ),
          );
        }
        return PageTransition(
          duration: const Duration(milliseconds: 500),
          type: PageTransitionType.fade,
          child: DiscountScreen(
            argus: const {},
          ),
        );
      case '/tax':
        if (arguments is Map<String, dynamic>) {
          return PageTransition(
            duration: const Duration(milliseconds: 500),
            type: PageTransitionType.fade,
            child: TaxScreen(
              argus: arguments,
            ),
          );
        }
        return PageTransition(
          duration: const Duration(milliseconds: 500),
          type: PageTransitionType.fade,
          child: TaxScreen(
            argus: const {},
          ),
        );
      case '/product':
        if (arguments is Map<String, dynamic>) {
          return PageTransition(
            duration: const Duration(milliseconds: 500),
            type: PageTransitionType.fade,
            child: ProductScreen(
              argus: arguments,
            ),
          );
        }
        return PageTransition(
          duration: const Duration(milliseconds: 500),
          type: PageTransitionType.fade,
          child: ProductScreen(
            argus: const {},
          ),
        );
      case '/product-detail':
        if (arguments is Map<String, dynamic>) {
          return PageTransition(
            duration: const Duration(milliseconds: 500),
            type: PageTransitionType.fade,
            child: ProductDetailScreen(
              argus: arguments,
            ),
          );
        }
        return PageTransition(
          duration: const Duration(milliseconds: 500),
          type: PageTransitionType.fade,
          child: ProductDetailScreen(
            argus: const {},
          ),
        );
      case '/plan':
        if (arguments is Map<String, dynamic>) {
          return PageTransition(
            duration: const Duration(milliseconds: 500),
            type: PageTransitionType.fade,
            child: PlanScreen(
              argus: arguments,
            ),
          );
        }
        return PageTransition(
          duration: const Duration(milliseconds: 500),
          type: PageTransitionType.fade,
          child: PlanScreen(
            argus: const {},
          ),
        );
      case '/bill-plan':
        if (arguments is Map<String, dynamic>) {
          return PageTransition(
            duration: const Duration(milliseconds: 500),
            type: PageTransitionType.fade,
            child: BillPlansScreen(
              argus: arguments,
            ),
          );
        }
        return PageTransition(
          duration: const Duration(milliseconds: 500),
          type: PageTransitionType.fade,
          child: BillPlansScreen(
            argus: const {},
          ),
        );
      case '/custom-amount':
        if (arguments is Map<String, dynamic>) {
          return PageTransition(
            duration: const Duration(milliseconds: 500),
            type: PageTransitionType.fade,
            child: CustomAmountScreen(
              argus: arguments,
            ),
          );
        }
        return PageTransition(
          duration: const Duration(milliseconds: 500),
          type: PageTransitionType.fade,
          child: CustomAmountScreen(
            argus: const {},
          ),
        );
      case '/select-sms-template':
        if (arguments is Map<String, dynamic>) {
          return PageTransition(
            duration: const Duration(milliseconds: 500),
            type: PageTransitionType.fade,
            child: SelectSmsTemplatesScreen(
              argus: arguments,
            ),
          );
        }
        return PageTransition(
          duration: const Duration(milliseconds: 500),
          type: PageTransitionType.fade,
          child: SelectSmsTemplatesScreen(
            argus: const {},
          ),
        );
      case '/sms-remainder-settings':
        if (arguments is Map<String, dynamic>) {
          return PageTransition(
            duration: const Duration(milliseconds: 500),
            type: PageTransitionType.fade,
            child: SmsReminderSettingscreen(
              argus: arguments,
            ),
          );
        }
        return PageTransition(
          duration: const Duration(milliseconds: 500),
          type: PageTransitionType.fade,
          child: SmsReminderSettingscreen(
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
      return MaterialPageRoute(
        builder: (context) => PageErrorScreen(
          argus: arguments,
        ),
      );
    }
    return MaterialPageRoute(
      builder: (context) => PageErrorScreen(
        argus: const {},
      ),
    );
  }
}
