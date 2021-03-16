public with sharing class assetDetailsController {
    
    Public obj_Assets__c objAst{ get;set;}
    Public String sId {get;set;}
    Public String  appId {get;set;}
    Public String btnText {get;set;}    
    
    public assetDetailsController() {
        objAst  = new obj_Assets__c();
        appId = ApexPages.currentPage().getParameters().get('appId');
        
         sId  = ApexPages.currentPage().getParameters().get('sId');
         btnText ='Save';
        if(! String.isBlank(sId)){
            try{
                 objAst = [SELECT Id, Model__c, Price__c, Used__c, Year__c, Make__c,Application__c FROM obj_Assets__c Where Id =: sId];
                 btnText ='Update';
            }
            catch(Exception e){
                 objAst  = new obj_Assets__c();
                 btnText ='Save';
            }    
         }
       }   
   public PageReference addOrEdit() {         
       
        try{
            if( String.isBlank(objAst.Application__c)){
                objAst.Application__c = appId;
            }
            Upsert objAst;
        }
        catch(exception ex){
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING, ex.getMessage()));
            return null;
        } 
        PageReference pg = new PageReference('/apex/AssetList?appId='+ appId);
        return pg.setRedirect(true); 
    }  
     public PageReference Cancel() {
        PageReference pg = new PageReference('/apex/AssetList?appId='+ appId);
        return pg.setRedirect(true);
    }     
 }