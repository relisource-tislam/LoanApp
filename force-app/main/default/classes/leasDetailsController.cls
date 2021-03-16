public with sharing class leasDetailsController{

    Public obj_Lease__c objLeas{ get;set;}
    Public String sId {get;set;}
    Public String btnText {get;set;}
    
    public leasDetailsController(){
        objLeas= new obj_Lease__c();
        sId  = ApexPages.currentPage().getParameters().get('id');
        btnText ='Next';
        if(! String.isBlank(sId)){
            objLeas= [SELECT Id, Name, First_Name__c, Last_Name__c, Father_s_Name__c, Mother_s_Name__c,Occupation__c, SSN__c, Cell_no__c, Email__c, Address__c FROM obj_Lease__c Where Id =:  sId];
            btnText ='Update';
        }        
    }    

    public PageReference addOrEdit() {
       Upsert objLeas;
         PageReference pg;
         if(String.IsNotBlank(sId)){
             pg = new PageReference('/apex/AssetList');
         }
         else{
             pg = new PageReference('/apex/AssetList');
         }
         return pg.setRedirect(true); 
    }
    public PageReference Cancel() {
       PageReference pg;
       pg = new PageReference('/apex/LeaseList');
       return pg.setRedirect(true);
    }
}