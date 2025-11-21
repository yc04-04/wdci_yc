trigger ReqTrigger on Application (after insert) {

    List<ApplicationRequirement> ReqList = new List<ApplicationRequirement>();

    Map<Name, Application> mapName = new Map<Name, Application>([SELECT Id,(SELECT Id FROM ApplicationRequirement) FROM Account WHERE Id IN :Trigger.new]);


}
