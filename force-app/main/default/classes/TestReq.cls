@IsTest
public class TestReq {

    @TestSetup
    static void setupData() {
        // Create Accounts
        List<Account> accs = new List<Account>{
            new Account(Name='DomesticAcc'),
            new Account(Name='IntlAcc')
        };
        insert accs;

        // Create Contacts using valid picklist values
        List<Contact> contacts = new List<Contact>{
            new Contact(LastName='DomesticUser', Nationality__c='Malaysian', AccountId=accs[0].Id),
            new Contact(LastName='IntlUser', Nationality__c='Singaporean', AccountId=accs[1].Id)
        };
        insert contacts;
    }

    @IsTest
    static void testDomesticApplication() {
        // Query domestic contact
        Contact domesticCon = [SELECT Id FROM Contact WHERE Nationality__c='Malaysian' LIMIT 1];

        // Create Application for Domestic contact
        Application__c app = new Application__c(
            Name='DomesticApp',
            Contact__c = domesticCon.Id
        );
        insert app;

        // Verify Application_Requirements__c created
        List<Application_Requirements__c> reqs = [
            SELECT Name, Requirement_Type__c, Application__c
            FROM Application_Requirements__c
            WHERE Application__c = :app.Id
        ];

        System.assert(reqs.size() > 0, 'Domestic requirements should be created');

    }

    @IsTest
    static void testInternationalApplication() {
        // Query international contact
        Contact intlCon = [SELECT Id FROM Contact WHERE Nationality__c='Singaporean' LIMIT 1];

        // Create Application for International contact
        Application__c app = new Application__c(
            Name='IntlApp',
            Contact__c = intlCon.Id
        );
        insert app;

        // Verify Application_Requirements__c created
        List<Application_Requirements__c> reqs = [
            SELECT Name, Requirement_Type__c, Application__c
            FROM Application_Requirements__c
            WHERE Application__c = :app.Id
        ];

        System.assert(reqs.size() > 0, 'International requirements should be created');

     
    }


@IsTest
static void testBulkApplications() {
    // Query all contacts
    List<Contact> cons = [SELECT Id, Nationality__c FROM Contact];

    // Create multiple Applications with Contact__c
    List<Application__c> apps = new List<Application__c>();
    for(Contact c : cons){
        for(Integer i = 0; i < 5; i++){
            apps.add(new Application__c(
                Name = 'App' + i + '-' + c.Nationality__c,
                Contact__c = c.Id  
            ));
        }
    }
    insert apps;

    // Verify Application_Requirements__c created
    List<Application_Requirements__c> allReqs = [
        SELECT Id, Name, Application__c
        FROM Application_Requirements__c
        WHERE Application__c IN :apps
    ];
}

}