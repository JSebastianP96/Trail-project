/**
 * @description       : 
 * @author            : juan.parra@unosquare.com
 * @group             : 
 * @last modified on  : 19-05-2022
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
        Map<Id, contactInfo>  contactInfoMap = new Map<Id, ContactInfo>();
        contactInfo ctInfo = new ContactInfo();
        Set<Id> accountIds = new Set<Id>();
        Set<Id> aStrIds = new Set<Id>();
        // List<String> cStrIds = new List<String>();
        for(Contact contact : contacts){
            accountIds.add(contact.AccountId);
            // cStrIds.add(c.Id);
        }
        List<Contact> allContactsReleated = new List<Contact>();
        // allContactsReleated = [SELECT Id, AccountId, Birthdate FROM Contact WHERE AccountId IN :aStrIds LIMIT 50000];
        List<AggregateResult> aggregates = ContactsSelector.instance.selectAggregatesGroupByAccountId(accountIds);

        Map<Id, AggregateResult> aggregatesByAccountIds = new Map<Id, AggregateResult>();
        List<Account> accountsToUpdate = new List<Account>();
        for(AggregateResult aggregate :  aggregates){
            aggregatesByAccountIds.put(aggregate.get('AccountId'), aggregate);
            accountsToUpdate.add(new Account);
        }


        
        // for (Contact con : allContactsReleated) {
        //     if(con.AccountId == null) continue;

        //     ctInfo =  contactInfoMap.get(con.AccountId);
            
        //     if(ctInfo == null){
        //         ctInfo = new ContactInfo();
        //         contactInfoMap.put(con.AccountId, ctInfo);
        //     }
            
        //     yerasOld = date.TODAY().YEAR() - con.Birthdate.YEAR();
            
        //     if(yerasOld < ctInfo.yongestContactYearsOld){
        //         ctInfo.yongestContactYearsOld = yerasOld;
        //     }
        //     if(yerasOld > ctInfo.oldestContactYearsOld){
        //         ctInfo.oldestContactYearsOld = yerasOld;
        //     }
        //     ctInfo.numberOfContacts++ ;

        //     // accountIds.add(con.AccountId);
        // }

        // contactInfo newCtInfo = new ContactInfo();
        // Account updateAccount = new Account();
        // List<Account> updateAccounts = new List<Account>();
        // for(Id accId : accountIds) {
        //     newCtInfo = contactInfoMap.get(accId);
        //     if(newCtInfo != null){
        //         updateAccount.Id = accId;
        //         List<Integer> argument = new List<Integer>{
        //             newCtInfo.numberOfContacts,
        //             newCtInfo.oldestContactYearsOld,
        //             newCtInfo.yongestContactYearsOld
        //         };
        //         updateAccount.Description = String.format(template, argument);
        //         updateAccounts.add(updateAccount);
        //     }
        // }
        // if(!updateAccounts.isEmpty()){
        //     update updateAccount;Repository.doUpdate()
        // }
    }

    public class contactInfo {

        Id AccId;
        Integer yongestContactYearsOld;
        Integer oldestContactYearsOld;
        Integer numberOfContacts;

        public contactInfo(){
            this.yongestContactYearsOld = 9999;
            this.oldestContactYearsOld = 0;
            this.numberOfContacts = 0;
        }

    }
}