/**
 * @description       : 
 * @author            : juan.parra@unosquare.com
 * @group             : 
 * @last modified on  : 23-05-2022
 * @last modified by  : juan.parra@unosquare.com
**/
public with sharing class AccountsSelector {
    public AccountsSelector() {}

    public static AccountsSelector instance {
        get {
            if(instance == null){
                instance = new AccountsSelector();
            }
            return instance;
        }
        set;
    }

    public List<AggregateResult> selectAggregatesGroupByParentId(Set<String> accountIds) {
        return [
            SELECT ParentId,MAX(Oldest_Contact_Years_Old__c) YOUNGEST,MIN(Yongest_Contact_Years_Old__c) OLDEST,SUM(Number_Of_Contacts__c) NUMOFCONTACTS
            FROM Account 
            WHERE Id IN :accountIds 
            AND ParentId != null
            GROUP BY ParentId
            ORDER BY COUNT(Id) DESC
        ];
    }
}