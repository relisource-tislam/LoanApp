public with sharing class assetController { 

    public String asstList { get; set; }
    public List<obj_Assets__c> objAsset{get;set;}
    public String appId {get;set;}
    public String sId {get;set;}
    public String vfParam{get;set;}    
    
    public assetController(){
        try{
            appId   = ApexPages.currentPage().getParameters().get('appId');
            objAsset =  [SELECT Id, Name, Model__c, Make__c, Year__c, Used__c, Price__c,Application__c  FROM obj_Assets__c where Application__c=: appId];
        }
        catch(exception ex){
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING, ex.getMessage()));
        }
    } 
    
    public PageReference nextGrid() {
        PageReference pg = new PageReference('/apex/GuarantorList?appId='+ appId);
        return pg.setRedirect(true);   
    }
    public PageReference addorEdit() {
        PageReference pg = new PageReference('/apex/AssetDetails?sId=' + vfParam + '&appId='+ appId);
        return pg.setRedirect(true);
    }
}