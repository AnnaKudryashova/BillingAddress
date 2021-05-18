public with sharing class BillingAddressHandler {
    
    public static void handleAfterInsert(Map<Id, Account> newMap) {
        BillingAddressHelper.createAddress(newMap.keySet());
    }
    
    public static void handleAfterUpdate(Map<Id, Account> oldMap, Map<Id, Account> newMap) {
        if (!RecursiveTriggerHandler.isUpdated()) {
            BillingAddressHelper.updateAddress(oldMap, newMap);
        }        
    }
 }