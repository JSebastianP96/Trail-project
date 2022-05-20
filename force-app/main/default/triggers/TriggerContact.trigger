/**
 * @description       : 
 * @author            : juan.parra@unosquare.com
 * @group             : 
 * @last modified on  : 16-05-2022
 * @last modified by  : juan.parra@unosquare.com
**/
trigger TriggerContact on Contact (before insert, before update, before delete, after insert, after update, after delete, after undelete) {

    new ContactTiggerHandler().run();

}