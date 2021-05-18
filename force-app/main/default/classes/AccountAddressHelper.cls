public with sharing class AccountAddressHelper {
    
    public static void updateAddress(Map<Id, BillingAddress__c> oldMap, Map<Id, BillingAddress__c> newMap) {
        
        List<Id> ids = new List<Id>();
        for (BillingAddress__c address : newMap.values()) {            
            BillingAddress__c oldAddress = oldMap.get(address.id);
            if (address.BillingStreet__c != oldAddress.BillingStreet__c ||
                address.BillingCity__c != oldAddress.BillingCity__c ||
                address.BillingCountry__c != oldAddress.BillingCountry__c ||
                address.BillingState__c != oldAddress.BillingState__c ||
                address.BillingPostalCode__c != oldAddress.BillingPostalCode__c) {
                    ids.add(address.id);
                }                
        }
        if (!ids.isEmpty()) {
            updateAccountAddresses(ids);
        }
    }
    
    @future
    public static void updateAccountAddresses(List<Id> ids) {
        	List<BillingAddress__c> addresses = [SELECT Id, BillingStreet__c, 
                                                 BillingPostalCode__c, BillingState__c, 
                                                 BillingCountry__c, BillingCity__c, AccountId__c                                                                                                 
                                                 FROM BillingAddress__c WHERE Id IN :ids];
        	List<Account> accountsList = [SELECT Id, BillingCity, BillingCountry, BillingPostalCode, BillingState, BillingStreet FROM Account];
            Map<Id, Account> accountsMap = new Map<Id, Account>();
        	for (Account account : accountsList) {
                accountsMap.put(account.Id, account);
            }
        	List<Account> updatedAccountsList = new List<Account>();
            for (BillingAddress__c address : addresses) {
                Account account = accountsMap.get(address.AccountId__c);
                account.BillingCity = address.BillingCity__c;
                account.BillingCountry = address.BillingCountry__c;
                account.BillingPostalCode = address.BillingPostalCode__c;
                account.BillingState = address.BillingState__c;
                account.BillingStreet = address.BillingStreet__c;           
                updatedAccountsList.add(account);
            }
        	RecursiveTriggerHandler.setUpdated(true);
            if (updatedAccountsList.size() > 0) {
                update updatedAccountsList;
            } 	   
    }   
}
