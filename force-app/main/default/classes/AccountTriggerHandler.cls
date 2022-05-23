/**
 * @description       : 
 * @author            : juan.parra@unosquare.com
 * @group             : 
 * @last modified on  : 23-05-2022
 * @last modified by  : juan.parra@unosquare.com
**/
public with sharing class AccountTriggerHandler extends TriggerHandler {

    public override void AfterInsert() {
        // AccountsService.hierarchyAccountsContactsInfo(trigger.new);
    }
}
