/**
 * @description       : 
 * @author            : juan.parra@unosquare.com
 * @group             : 
 * @last modified on  : 20-05-2022
 * @last modified by  : juan.parra@unosquare.com
**/
public with sharing class AccountsSelector {
    public AccountsSelector() {}

    public List<AggregateResult> selectAggregatesGroupByParentId(Set<Id> accountIds) {
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
