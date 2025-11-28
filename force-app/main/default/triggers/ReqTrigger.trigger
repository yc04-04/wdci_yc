trigger ReqTrigger on Application__c (after insert) {

    // Collect all Contact Ids
    Set<Id> contactIds = new Set<Id>();

    for (Application__c app : Trigger.new) {
                                System.debug('App cord Debug ' + app);

        if (app.Contact__c != null) {
            contactIds.add(app.Contact__c);
                        System.debug('ContactID Debug ' + contactIds);

        }
    }
 System.debug('test1' + contactIds);
    // Build Contact map for nationality lookup
    Map<Id, Contact> contactMap = new Map<Id, Contact>(
        [SELECT Id, Nationality__c FROM Contact WHERE Id IN :contactIds]
    );

    List<Program_Requirement__mdt> DomReqType = [SELECT MasterLabel, Requirement_Type__c FROM Program_Requirement__mdt WHERE Requirement_Type__c = 'Domestic'];
    List<Program_Requirement__mdt> InterProgReqs = [SELECT MasterLabel, Requirement_Type__c FROM Program_Requirement__mdt WHERE Requirement_Type__c = 'International'];

    
System.debug('test2' + DomReqType);

    List<Application_Requirements__c> reqList = new List<Application_Requirements__c>();
    System.debug('ContactMAp Debug ' + Json.Serialize(contactMap));

    for (Application__c app : Trigger.new) {

        Contact con = contactMap.get(app.Contact__c);
            System.debug('Contact Debug ' + con);

        if (con == null) continue;
            System.debug('Contact');


        String appType = (con.Nationality__c == 'Malaysian') ? 'Domestic' : 'International';

        // Loop CMDT
        if (appType == 'Domestic') {
                System.debug('Dom');

            for (Program_Requirement__mdt req : DomReqType) {
                reqList.add(new Application_Requirements__c(
                    Name = req.MasterLabel,
                    Requirement_Type__c = req.Requirement_Type__c,
                    Application__c = app.Id
                ));
            }
        } else {
                System.debug('Int');

            for (Program_Requirement__mdt req : InterProgReqs) {
                reqList.add(new Application_Requirements__c(
                    Name = req.MasterLabel,
                    Requirement_Type__c = req.Requirement_Type__c,
                    Application__c = app.Id
                ));
            }
        }    

    }        
    if (!reqList.isEmpty()) {
        insert reqList;
    }
    System.debug('test3' + reqList);

    List<Application_Requirements__c> appList = [SELECT Id, Name, Requirement_Type__c, Application__c FROM Application_Requirements__c WHERE Application__c IN : Trigger.new];
    System.debug('test4' + appList);



}