/**
 * @description       : 
 * @author            : juan.parra@unosquare.com
 * @group             : 
 * @last modified on  : 22-05-2022
 * @last modified by  : juan.parra@unosquare.com
**/
public inherited sharing class AccountsService {
    public static void hierarchyAccountsContactsInfo(List<Account> accounts) {

        List<Id> accountsIds = new List<Id>();
        for (Account account : accounts) {
            accountsIds.addAll(account.hierarchy__c.Split(':'));
        }

        List<AggregateResult> aggregatesAcc = AccountsSelector.instance.selectAggregatesGroupByParentId(new Set<Id>(accountsIds));

        for (AggregateResult aggregateResult : aggregatesAcc) {
            
        }
    }


}
