public with sharing class submitController {

    Public String appId {get;set;}
    Public  obj_Application__c objApp{get;set;}    
    
    Public submitController(){
        
        try{
            objApp= new obj_Application__c ();
            appId  = ApexPages.currentPage().getParameters().get('appId');
            objApp= [SELECT  Lease__r.First_Name__c,Lease__r.Name,Lease__r.Date_of_Birth__c,Lease__r.SSN__c FROM obj_Application__c where Id=:appId ];
        }
        catch(exception ex){
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING, ex.getMessage()));
        }        
    } 
    
    public PageReference Submit() {
    
        try{
            objApp = new obj_Application__c ();
            objApp.Id = appId;  
            objApp.Status__c = 'Submitted';
            upsert objApp;
        }
        catch(exception ex){
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING, ex.getMessage()));
            return null;
        }  
         PageReference pg = new PageReference('/apex/applicationList');
         return pg.setRedirect(true); 
    }
    
    public PageReference Cancel() {
        PageReference pg = new PageReference('/apex/applicationList');
        return pg.setRedirect(true); 
    }
}