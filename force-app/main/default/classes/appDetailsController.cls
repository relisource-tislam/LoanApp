public with sharing class appDetailsController{

    Public obj_Application__c objApp{ get;set;}
    Public obj_Lease__c objLeas{ get;set;}
    
    Public String sId {get;set;}
    Public String ssn{get;set;}
    Public String appId {get;set;}
    Public String btnText {get;set;}
    
    public appDetailsController(){
        objApp= new obj_Application__c();
        objLeas= new obj_Lease__c ();
        
        sId  = ApexPages.currentPage().getParameters().get('id');
        btnText ='Next';
        if(! String.isBlank(sId)){
            try{
                objApp = [SELECT Id, Name, Loan_title__c,Lease__c, Requested_Amount__c, Maturity__c, Proposed_collaterals__c from obj_Application__c Where Id =:  sId]; 
                objLeas=[SELECT Id, First_Name__c, Name, Father_s_Name__c, Mother_s_Name__c, Occupation__c, SSN__c,Date_of_Birth__c,Cell_no__c, Address__c, Email__c  FROM obj_Lease__c Where Id=: objApp.Lease__c ];
                ssn= String.valueOf(objLeas.SSN__c);
                btnText ='Update';
            }
            catch(exception ex){
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING, ex.getMessage()));               
            } 
        }        
    }  
    
    public PageReference addOrUpdate() {
    
        try{
            If(!String.isBlank(ssn)) {      
             Upsert objApp;
             appId = sId;
         }
         else{
              Upsert objLeas;
              objApp.Lease__c = objLeas.Id;
              objApp.Status__c = 'In Progress';
              Upsert objApp;
              appId = objApp.Id;
         } 
        }
        catch(exception ex){
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING, ex.getMessage()));
            return null;
        } 
         PageReference pg; 
         pg = new PageReference('/apex/assetList?appId=' + appId);
         return pg.setRedirect(true); 
    }
    
    public PageReference Cancel() {
        PageReference pg; 
        pg = new PageReference('/apex/ApplicationList');
        return pg.setRedirect(true); 
    }
}