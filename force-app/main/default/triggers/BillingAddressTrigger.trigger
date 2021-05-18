trigger BillingAddressTrigger on BillingAddress__c (after update) {
              
    if (Trigger.isAfter && Trigger.isUpdate) {        
        AccountAddressHandler.handleAfterUpdate(Trigger.oldMap, Trigger.newMap);
    	}
}