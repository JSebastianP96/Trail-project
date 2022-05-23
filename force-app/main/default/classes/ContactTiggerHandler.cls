/**
 * @description       : 
 * @author            : juan.parra@unosquare.com
 * @group             : 
 * @last modified on  : 23-05-2022
 * @last modified by  : juan.parra@unosquare.com
**/
public with sharing class ContactTiggerHandler extends TriggerHandler {
    public override void AfterInsert() {
        ContactsService.rollSummaryAccount(trigger.new);
    }

    public override void AfterUpdate() {
        ContactsService.rollSummaryAccount(trigger.new);
    }

    public override void BeforeDelete() {
        try{
            ContactsService.rollSummaryAccount(trigger.old);
        }catch(Exception e){
            Logger.error('Nico Message',trigger.new,e);
            Logger.saveLog();
        }
    }

    public override void AfterUndelete() {
        ContactsService.rollSummaryAccount(trigger.new);
    }


}