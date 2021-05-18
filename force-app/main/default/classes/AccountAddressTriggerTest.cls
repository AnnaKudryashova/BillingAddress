@isTest
private class AccountAddressTriggerTest {
	@testSetup
    static void initData() {
        List<Account> accounts = TestDataFactory.createAccounts(200, 'Test Account');
        Test.startTest();
        insert accounts;
        Test.stopTest();
    }
    
    @isTest
    static void testCreateBillingAddress() {
		List<Account> verifyAccounts = [SELECT Id FROM Account];
        System.assertEquals(200, verifyAccounts.size()); 
        List<BillingAddress__c> verifyAddresses = [SELECT Id FROM BillingAddress__c];
        System.debug(verifyAddresses.size());
        System.assertEquals(200, verifyAddresses.size());    
    }
    
    @isTest
    static void testUpdateBillingAddress() {
        List<Account> accounts = [SELECT Id, BillingStreet, BillingPostalCode, BillingState, BillingCountry, BillingCity FROM Account];
        Test.startTest();
        for (Integer i = 0; i < 40; i++) {
            accounts[i].BillingStreet = 'Updated Street'; 
        }
        for (Integer i = 41; i < 80; i++) {
            accounts[i].BillingPostalCode = 'Updated PostalCode'; 
        }
        for (Integer i = 81; i < 120; i++) {
            accounts[i].BillingState = 'Updated State'; 
        }
        for (Integer i = 121; i < 160; i++) {
            accounts[i].BillingCountry = 'Updated Country'; 
        }
        for (Integer i = 161; i < 200; i++) { 
            accounts[i].BillingCity = 'Updated City'; 
        }
        
        update accounts;
        Test.stopTest();
        List<BillingAddress__c> verifyUpdatedStreets = [SELECT Id FROM BillingAddress__c WHERE BillingStreet__c = 'Updated Street'];
        System.assertEquals(40, verifyUpdatedStreets.size());
        List<BillingAddress__c> verifyUpdatedPostalCodes = [SELECT Id FROM BillingAddress__c WHERE BillingPostalCode__c = 'Updated PostalCode'];
        System.assertEquals(40, verifyUpdatedPostalCodes.size());
        List<BillingAddress__c> verifyUpdatedStates = [SELECT Id FROM BillingAddress__c WHERE BillingState__c = 'Updated State'];
        System.assertEquals(40, verifyUpdatedStates.size());
        List<BillingAddress__c> verifyUpdatedCountries = [SELECT Id FROM BillingAddress__c WHERE BillingCountry__c = 'Updated Country'];
        System.assertEquals(40, verifyUpdatedCountries.size());
        List<BillingAddress__c> verifyUpdatedCities = [SELECT Id FROM BillingAddress__c WHERE BillingCity__c = 'Updated City'];
        System.assertEquals(40, verifyUpdatedCities.size());
        
    }
}