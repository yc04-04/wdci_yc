trigger ReqTrigger on Application__c (after insert) {

    Set<Id> appIds = new Set<Id>();
    for (Application__c app : Trigger.new) {
        appIds.add(app.Id);
    }

    List<Program_Requirement__mdt> domReqs = [
        SELECT MasterLabel, Requirement_Type__c 
        FROM Program_Requirement__mdt 
        WHERE Requirement_Type__c = 'Domestic'
    ];

    List<Program_Requirement__mdt> intlReqs = [
        SELECT MasterLabel, Requirement_Type__c 
        FROM Program_Requirement__mdt 
        WHERE Requirement_Type__c = 'International'
    ];

    List<Application_Requirements__c> reqList = new List<Application_Requirements__c>();

    for (Application__c app : Trigger.new) {


        String appType = app.Application_Type__c;

        List<Program_Requirement__mdt> selectedReqs;

        if (appType == 'Domestic') {
            selectedReqs = domReqs;
        } else {
            selectedReqs = intlReqs;
        }

        for (Program_Requirement__mdt req : selectedReqs) {
            reqList.add(new Application_Requirements__c(
                Name = req.MasterLabel,
                Requirement_Type__c = req.Requirement_Type__c,
                Application__c = app.Id
            ));
        }
    }

    if (!reqList.isEmpty()) {
        insert reqList;
    }
}
