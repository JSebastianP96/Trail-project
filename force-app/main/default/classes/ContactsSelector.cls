/**
 * @description       : 
 * @author            : juan.parra@unosquare.com
 * @group             : 
 * @last modified on  : 19-05-2022
 * @last modified by  : juan.parra@unosquare.com
**/
public with sharing class ContactsSelector {
    private ContactsSelector() {}

    public static ContactsSelector instance {
        get {
            if(instance == null){
                instance = new ContactsSelector();
            }
            return instance;
        }
        set;
    }

    public List<Contact> selectByAccountId(Set<Id> accountIds) {
        return [
            SELECT Id, AccountId, Birthdate 
            FROM Contact 
            WHERE AccountId IN :accountIds 
            LIMIT 5000
        ];
    }

    public List<AggregateResult> selectAggregatesGroupByAccountId(Set<Id> accountIds) {
        return [
            SELECT AccountId,MAX(Birthdate) YOUNGEST,MIN(Birthdate) OLDEST,COUNT(Id) NUMOFCONTACTS
            FROM Contact 
            WHERE AccountId != null
            AND Birthdate != null
            GROUP BY AccountId
            HAVING COUNT(Id) > 0
            ORDER BY COUNT(Id) DESC
            LIMIT 10
        ];
    }
}