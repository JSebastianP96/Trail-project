/**
 * @description       : 
 * @author            : juan.parra@unosquare.com
 * @group             : 
 * @last modified on  : 22-05-2022
 * @last modified by  : juan.parra@unosquare.com
**/
trigger TriggerAccount on Account (before insert, before update, before delete, after insert, after update, after delete, after undelete) {
    new AccountTriggerHandler().run();
}