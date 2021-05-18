public with sharing class AccountAddressHandler {
      
    public static void handleAfterUpdate(Map<Id, BillingAddress__c> oldMap, Map<Id, BillingAddress__c> newMap) {
        if (!RecursiveTriggerHandler.isUpdated()) {
            AccountAddressHelper.updateAddress(oldMap, newMap);
        }   
    }
}