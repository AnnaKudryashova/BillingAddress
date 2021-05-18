public with sharing class BillingAddressHelper {
    public static Boolean isDisabled = false;
    
    public static void createAddress(Set<Id> ids) {
        if (!isDisabled) {
            createBillingAddress(ids);
            isDisabled = true;
        }
    }
	
    @future
    public static void createBillingAddress(Set<Id> ids) {
        List<BillingAddress__c> billingAddresses = new List<BillingAddress__c>();
        for (Account acc : [SELECT Id, BillingStreet, BillingPostalCode, BillingState, BillingCountry, BillingCity FROM Account WHERE Id IN :ids]) {
            if (acc.BillingStreet != NULL ||
                acc.BillingPostalCode != NULL ||
                acc.BillingState != NULL ||
                acc.BillingCountry != NULL ||
                acc.BillingCity != NULL) {
                    BillingAddress__c billingAddress = new BillingAddress__c(
                        BillingStreet__c = acc.BillingStreet,
                        BillingPostalCode__c = acc.BillingPostalCode,
                        BillingState__c = acc.BillingState,
                        BillingCountry__c = acc.BillingCountry,
                        BillingCity__c = acc.BillingCity,
                        AccountId__c = acc.Id,
                        isSync__c = true
                    );
                    billingAddresses.add(billingAddress);
                }
        }
        if(!billingAddresses.isEmpty()) {
            upsert billingAddresses;
        }	
    }
    
    public static void updateAddress(Map<Id, Account> oldMap, Map<Id, Account> newMap) {
        List<Id> ids = new List<Id>();
        for (Account account : newMap.values()) {
            Account oldAccount = oldMap.get(account.id);
            if (account.BillingStreet != oldAccount.BillingStreet ||
                account.BillingCity != oldAccount.BillingCity ||
                account.BillingCountry != oldAccount.BillingCountry ||
                account.BillingState != oldAccount.BillingState ||
                account.BillingPostalCode != oldAccount.BillingPostalCode) {
                    ids.add(account.id);
                }                
        }
        if (!ids.isEmpty()) {
            updateBillingAddresses(ids);
        }
    }
    
    @future
    public static void updateBillingAddresses(List<Id> ids) {
        	List<BillingAddress__c> addresses = [SELECT IsSync__c, BillingStreet__c, 
                                                        BillingPostalCode__c, BillingState__c, 
                                                        BillingCountry__c, BillingCity__c, AccountId__c                                                                                                 
                                              			FROM BillingAddress__c WHERE AccountId__c IN :ids];
        	Map<Id, Account> accountsMap = new Map<Id, Account>([SELECT Id, BillingCity, BillingCountry, BillingPostalCode, 
                                                                 BillingState, BillingStreet FROM Account WHERE Id IN :ids]);
            for (BillingAddress__c address : addresses) {
                Account account = accountsMap.get(address.AccountId__c);
                address.BillingCity__c = account.BillingCity;
                address.BillingCountry__c = account.BillingCountry;
                address.BillingPostalCode__c = account.BillingPostalCode;
                address.BillingState__c = account.BillingState;
                address.BillingStreet__c = account.BillingStreet;
                address.IsSync__c = true;
            }
        	RecursiveTriggerHandler.setUpdated(true);
            update addresses;   
    }    
}