class APIPathList {
  // Production Server
  static const String mainDomain = "64.227.150.208";
  static const String subfolder = "/khatabook/api/";
  static const String userLogin = "${subfolder}loginUser";
  static const String resendOTP = "${subfolder}resendOtp";
  static const String fetchUserProfile = "${subfolder}getUserProfile";
  static const String getCountryList = "${subfolder}GetCountry";
  static const String updateProfileImage = "${subfolder}updateProfileImage";
  static const String updateUserProfile = "${subfolder}updateUserProfile";
  static const String getBusinessListUserWise =
      "${subfolder}getBusinessListUserWise";
  static const String deleteSelectedBusiness =
      "${subfolder}deleteBusinessAccount";
  static const String updateBusinessProfileImage =
      "${subfolder}updateBusinessProfileImage";
  static const String updateBusinessProfileData = "${subfolder}updateBusiness";
  static const String createBusiness = "${subfolder}createBusiness";
  static const String getBusinessType = "${subfolder}getBusinessType";
  static const String getUserGroupList = "${subfolder}getGroupList";
  static const String createUserGroup = "${subfolder}CreateGroup";
  static const String updateUserGroup = "${subfolder}updateGroupData";

  static const String deleteUserGroup = "${subfolder}deleteGroupData";
  static const String createCustomer = "${subfolder}AddCustomer";
  static const String updateCustomer = "${subfolder}updateCustomer";
  static const String deleteCustomer = "${subfolder}deleteCustomer";
  static const String getCustomerList = "${subfolder}getcustomerList";
  static const String getCustomerDetails = "${subfolder}getcustomeDetails";

  static const String cashTransaction =
      "${subfolder}cash_transaction";
  static const String cashTransactionUpdate =
      "${subfolder}Updatecash_transaction";
  static const String getCashTransactionList = "${subfolder}cash_transactionList";
}
