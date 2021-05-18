@isTest
private class BillingAddressTriggerTest { 
	@testSetup
    static void initData() {
        List<Account> accounts = TestDataFactory.createAccounts(200, 'Test Account');
        Test.startTest();
        insert accounts;
        Test.stopTest();
    }
    
	@isTest
	static void testUpdateAccountAddress() {
		List<BillingAddress__c> billingAddresses = [SELECT Id, BillingStreet__c, BillingPostalCode__c, BillingState__c, 
													BillingCountry__c, BillingCity__c FROM BillingAddress__c];
		Test.startTest();
		for (Integer i = 0; i < 40; i++) {
			billingAddresses[i].BillingStreet__c = 'Updated Street'; 
		}
		for (Integer i = 41; i < 80; i++) {		
			billingAddresses[i].BillingPostalCode__c = 'Updated PostalCode'; 
		}
		for (Integer i = 81; i < 120; i++) {
			billingAddresses[i].BillingState__c = 'Updated State'; 
		}
		for (Integer i = 121; i < 160; i++) {
			billingAddresses[i].BillingCountry__c = 'Updated Country'; 
		}
		for (Integer i = 161; i < 200; i++) {
			billingAddresses[i].BillingCity__c = 'Updated City'; 
		}       
		update billingAddresses;
		Test.stopTest();
		List<Account> verifyUpdatedStreets = [SELECT Id, BillingStreet FROM Account WHERE BillingStreet = 'Updated Street'];
		System.assertEquals(40, verifyUpdatedStreets.size()); 
		List<Account> verifyUpdatedPostalCodes = [SELECT Id, BillingPostalCode FROM Account WHERE BillingPostalCode = 'Updated PostalCode'];
		System.assertEquals(40, verifyUpdatedPostalCodes.size());
		List<Account> verifyUpdatedStates = [SELECT Id, BillingState FROM Account WHERE BillingState = 'Updated State'];
		System.assertEquals(40, verifyUpdatedStates.size());
		List<Account> verifyUpdatedCountries = [SELECT Id, BillingCountry FROM Account WHERE BillingCountry = 'Updated Country'];
		System.assertEquals(40, verifyUpdatedCountries.size());
		List<Account> verifyUpdatedCities = [SELECT Id, BillingCity FROM Account WHERE BillingCity = 'Updated City'];
		System.assertEquals(40, verifyUpdatedCities.size());
	}   
}
