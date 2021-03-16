public with sharing class guarantorController {  

     public List<obj_Guarantor__c> objGuarantor{ get; set; }
     public String appId {get;set;}
     public String vfParam {get;set;}
     
     
    PUblic guarantorController(){
         appId = ApexPages.currentPage().getParameters().get('appId');
         objGuarantor=  [SELECT Id, Name, Percentage__c, Relation__c, Primary__c, obj_GuarantorCollection__c, Application__c FROM obj_Guarantor__c where Application__c=: appId];
    }    
    
    public PageReference editOrAdd() {
    
        PageReference  pg = new PageReference('/apex/GuarantorDetails?sId=' + vfParam + '&appId='+ appId);
        return pg.setRedirect(true);
    }  
    public PageReference nextGrid() {
        PageReference pg = new PageReference('/apex/DocumentList?appId='+ appId);
        return pg.setRedirect(true);
    }   
}