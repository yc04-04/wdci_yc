public with sharing class ReqController {
    @AuraEnabled(cacheable=true)

    /*
    public static Map<String, List<Program_Requirement__mdt>> mdtMap() { 
        List<Program_Requirement__mdt> proList = [SELECT Id,MasterLabel, Requirement_Type__c FROM Program_Requirement__mdt];

        Map<String, List<Program_Requirement__mdt>> mdtMap = new Map<String, List<Program_Requirement__mdt>>();
        
        for(Program_Requirement__mdt pro : proList){
            if(mdtMap.containsKey(pro.Requirement_Type__c)){
               mdtMap.get(pro.Requirement_Type__c).add(pro);
            }
        }
        return mdtMap;
    }


    */


    public static List<Program_Requirement__mdt> mdtMap() { 
        return [SELECT Id,MasterLabel, Requirement_Type__c FROM Program_Requirement__mdt];
    }

}