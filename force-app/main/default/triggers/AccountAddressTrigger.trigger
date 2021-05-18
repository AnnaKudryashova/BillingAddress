trigger AccountAddressTrigger on Account (after insert, after update) {
    
		if (Trigger.isAfter && Trigger.isInsert) {
        	BillingAddressHandler.handleAfterInsert(Trigger.newMap);
    	}
            
        if (Trigger.isAfter && Trigger.isUpdate) {
        	BillingAddressHandler.handleAfterUpdate(Trigger.oldMap, Trigger.newMap);
    	}
}