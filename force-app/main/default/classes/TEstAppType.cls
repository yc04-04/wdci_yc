@isTest
public class TEstAppType {

    @isTest
    static void TestContact() {
        // Create test Contacts
        List<Contact> contact = new List<Contact>{
            new Contact(LastName='yc', Nationality__c='Malaysian'),
            new Contact(LastName='Users', Nationality__c='Singaporean')
        };
        insert contact;
        
    }
    
        @IsTest
    static void testDomesticApplication() {
        // Query the Domestic contact
        Contact domesticCon = [SELECT Id ,  Nationality__c FROM Contact];

       List<Application__c> app = new List<Application__c>{
            new Application__c(Name='Domestic'  ),
            new Application__c(Name='International')
        };
        insert app;
       
    }
    
    @IsTest
    static void testSelectDom(){
     List<Program_Requirement__mdt> InterProgReqs = [
        SELECT MasterLabel, Requirement_Type__c FROM Program_Requirement__mdt
        WHERE Requirement_Type__c = 'International'
    ];
    }
    

}