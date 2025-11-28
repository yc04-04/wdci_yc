@IsTest
public class TestReqCont {

    @IsTest
    static void testMdtMap() {
        Test.startTest();
        List<Program_Requirement__mdt> result = ReqController.mdtMap();
        Test.stopTest();

        System.assertNotEquals(null, result, 'Result should not be null');

        System.assert(result.size() > 0, 'Expected at least one Program_Requirement__mdt record');

        Program_Requirement__mdt rec = result[0];
        System.assertNotEquals(null, rec.MasterLabel, 'MasterLabel should not be null');
        System.assertNotEquals(null, rec.Requirement_Type__c, 'Requirement_Type__c should not be null');
    }
}