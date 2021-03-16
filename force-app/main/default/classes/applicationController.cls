public with sharing class applicationController {   

    public List<obj_Application__c> objApp{ get; set; }
    public String vfParam{get;set;}
     
    PUblic applicationController (){
        try{
            objApp=  [SELECT Id, Name, Loan_title__c,Lease__r.Last_Name__c,Lease__r.SSN__c,Lease__r.Cell_no__c, Requested_Amount__c, Maturity__c, Proposed_collaterals__c, Status__c FROM obj_Application__c];
        }
        catch(exception ex){
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING, ex.getMessage()));
        }
    }

    public PageReference newOrAddapp() {   
        PageReference pg; 
        if(String.IsNotBlank(vfParam)){
            pg = new PageReference('/apex/ApplicationDetails?id=' + vfParam);
        }
        else{
            pg = new PageReference('/apex/ApplicationDetails');
        }
        return pg.setRedirect(true);
    }
}