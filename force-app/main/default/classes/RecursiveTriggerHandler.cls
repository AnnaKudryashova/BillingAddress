public with sharing class RecursiveTriggerHandler {
	
	private static Boolean isUpdated = false;
	public static Boolean isUpdated() {
		return isUpdated;
	    }
	public static void setUpdated(Boolean updated) {
		isUpdated = updated;
	    }
}
