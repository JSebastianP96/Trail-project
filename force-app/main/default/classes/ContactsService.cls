/**
 * @description       : 
 * @author            : juan.parra@unosquare.com
 * @group             : 
 * @last modified on  : 24-05-2022
 * @last modified by  : juan.parra@unosquare.com
**/
public inherited sharing class ContactsService {


    /**
     *  First Challenge: Pass Contact information in an Account description
     *  
     *  New Challenge: Having Contact information in an Account description
     *  Pass the Account description information to the ParentId/Parent Account
     *
     *
     *
     */

    public static void rollSummaryAccount(List<Contact> contacts) {

        String template = 'There are {0} Contacts related \n The oldest Contact has: {1} years \n The youngest Contact has: {2} years';
        Integer yerasOld;
        Set<Id> accountIds = new Set<Id>();
        Set<Id> aStrIds = new Set<Id>();
        Set<String> accountHierarchyIds = new Set<String>();

        for(Contact contact : contacts){
            accountIds.add(contact.AccountId);
        }
        List<Contact> allContactsReleated = new List<Contact>();

        List<AggregateResult> aggregates = ContactsSelector.instance.selectAggregatesGroupByAccountId(accountIds);

        Map<Id, AggregateResult> aggregatesByAccountIds = new Map<Id, AggregateResult>();
        Account updateAccount = new Account();
        // List<Account> accountsToUpdate = new List<Account>();
        Map<Id, Account> accountsToUpdate = new Map<Id, Account>();
        Map<Id, Account> accountsWithContactInfo = new Map<Id, Account>();
        for(AggregateResult aggregate :  aggregates){
            updateAccount.Id = String.valueOf(aggregate.get('AccountId'));
            
            updateAccount.Number_Of_Contacts__c = Integer.valueOf(aggregate.get('NUMOFCONTACTS'));
            updateAccount.Oldest_Contact_Years_Old__c = Integer.valueOf(date.TODAY().YEAR() - date.valueOf(aggregate.get('OLDEST')).YEAR());
            updateAccount.Yongest_Contact_Years_Old__c = Integer.valueOf(date.TODAY().YEAR() - date.valueOf(aggregate.get('YOUNGEST')).YEAR());
            List<String> argument = new List<String>{
                String.valueOf(String.valueOf(updateAccount.Number_Of_Contacts__c)),
                String.valueOf(String.valueOf(updateAccount.Oldest_Contact_Years_Old__c)),
                String.valueOf(String.valueOf(updateAccount.Yongest_Contact_Years_Old__c))
            };
            updateAccount.Description = String.format(template, argument);
            accountsWithContactInfo.put(updateAccount.Id, updateAccount);
            accountHierarchyIds.addAll(new List<String>(String.valueOf(aggregate.get('HIERARCHY')).Split(':')));
        }


        List<AggregateResult> aggregatesAcc = AccountsSelector.instance.selectAggregatesGroupByParentId(accountHierarchyIds);
        Integer oldestContactYearsOld;
        Integer youngestContactYearsOld;
        Integer numberOfContacts;
        Integer currentOldestContactYearsOld;
        Integer currentYoungestContactYearsOld;

        for(AggregateResult aggregateResult :  aggregatesAcc){
            Account currentAccount = new Account();
            if(accountsWithContactInfo.get(String.valueOf(aggregateResult.get('ParentId'))) != null){
                currentAccount = accountsWithContactInfo.get(String.valueOf(aggregateResult.get('ParentId')));
            }else{
                currentAccount.Id = String.valueOf(aggregateResult.get('ParentId'));
                currentAccount.Number_Of_Contacts__c = currentAccount.Number_Of_Contacts__c != null ? currentAccount.Number_Of_Contacts__c : 0;
                currentAccount.Oldest_Contact_Years_Old__c = currentAccount.Oldest_Contact_Years_Old__c != null ? currentAccount.Oldest_Contact_Years_Old__c : 0;
                currentAccount.Yongest_Contact_Years_Old__c = currentAccount.Yongest_Contact_Years_Old__c != null ? currentAccount.Yongest_Contact_Years_Old__c : 0;
            }
            currentOldestContactYearsOld = aggregateResult.get('OLDEST') != null ? Integer.valueOf(aggregateResult.get('OLDEST')) : 0;
            currentYoungestContactYearsOld = aggregateResult.get('YOUNGEST') != null ? Integer.valueOf(aggregateResult.get('YOUNGEST')) : 9999;
            oldestContactYearsOld = Integer.valueOf(currentOldestContactYearsOld < currentAccount.Oldest_Contact_Years_Old__c ? currentAccount.Oldest_Contact_Years_Old__c : currentOldestContactYearsOld);
            youngestContactYearsOld = Integer.valueOf(currentYoungestContactYearsOld > currentAccount.Yongest_Contact_Years_Old__c ? currentAccount.Yongest_Contact_Years_Old__c : currentYoungestContactYearsOld);
            numberOfContacts = Integer.valueOf(Integer.valueOf(aggregateResult.get('NUMOFCONTACTS') != null ? aggregateResult.get('NUMOFCONTACTS') : 0) + currentAccount.Number_Of_Contacts__c);
            List<String> argument = new List<String>{
                String.valueOf(String.valueOf(numberOfContacts)),
                String.valueOf(oldestContactYearsOld),
                String.valueOf(youngestContactYearsOld)
            };
            currentAccount.Description = String.format(template, argument);
            accountsToUpdate.put(currentAccount.Id, currentAccount);
        }
        for(Id atu : accountsWithContactInfo.keySet()){
            if(!accountsToUpdate.containsKey(atu)){
                accountsToUpdate.put(atu, accountsWithContactInfo.get(atu));
            }
        }


        if(!accountsToUpdate.values().isEmpty()){
            update accountsToUpdate.values(); //Repository.doUpdate()
        }
    }
}