@isTest
public class TestDataFactory {
    
    public static List<Account> createAccounts(Integer numAccts, String name) {
        List<Account> accounts = new List<Account>();
        Integer numAddress = numAccts / 5;
        for (Integer i = 0; i < numAddress; i++) {
            Account account  = new Account(Name = name + ' 1 ' + i, BillingStreet = 'Test Street ' + i);
            accounts.add(account);
        }
        for (Integer i = 0; i < numAddress; i++) {
            Account account  = new Account(Name = name + ' 2 ' + i, BillingCity = 'Test City ' + i);
            accounts.add(account);
        }
        for (Integer i = 0; i < numAddress; i++) {
            Account account  = new Account(Name = name + ' 3 ' + i, BillingPostalCode = 'Test Code' + i);
            accounts.add(account);
        }
        for (Integer i = 0; i < numAddress; i++) {
            Account account  = new Account(Name = name + ' 4 ' + i, BillingState = 'Test State ' + i);
            accounts.add(account);
        }
        for (Integer i = 0; i < numAddress; i++) {
            Account account  = new Account(Name = name + ' 5 ' + i, BillingCountry = 'Test Country ' + i);
            accounts.add(account);
        }
        
        return accounts;      
    }
}