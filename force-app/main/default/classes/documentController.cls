public with sharing class documentController {

    public List<obj_Document__c> objDoc{ get; set; }
    public String vfParam{get;set;}
    public String appId {get;set;}
     
    PUblic documentController(){
         try{
             appId   = ApexPages.currentPage().getParameters().get('appId');
             objDoc=  [SELECT Id, Name, Name__c, Type__c, Application__c FROM obj_Document__c where Application__c=:appId ];
        }
        catch(exception ex){
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING, ex.getMessage()));
        }         
    }
   
    public PageReference nextGrid() {
        PageReference pg = new PageReference('/apex/Summary?appId='+ appId);
        return pg.setRedirect(true);  
    }    
    
    public PageReference addOrUpdate() {
        PageReference pg;        
        pg = new PageReference('/apex/DocumentDetails?appId=' + appId +'&sId=' + vfParam);
        return pg.setRedirect(true);
    } 
}