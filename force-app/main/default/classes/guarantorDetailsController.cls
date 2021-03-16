public with sharing class guarantorDetailsController{

    Public obj_GuarantorCollection__c objGrnt{ get;set;}
    Public String sId {get;set;}
    Public String appId {get;set;}
    
    public guarantorDetailsController(){
    
        objGrnt= new obj_GuarantorCollection__c();
        sId  = ApexPages.currentPage().getParameters().get('sId');
        appId  = ApexPages.currentPage().getParameters().get('appId');
    }    

    public PageReference addOrEdit() {
        try{
            Upsert objGrnt;
        }
        catch(DmlException e){
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING, e.getMessage()));
            return null;
        }
         
         PageReference pg;
         pg = new PageReference('/apex/GuarantorDetails?appId=' + appId + '&sId=' + sId );
         return pg.setRedirect(true); 
    }
    
    public PageReference Cancel() {
       PageReference pg;
       pg = new PageReference('/apex/GuarantorDetails?appId=' + appId + '&sId=' + sId );
       return pg.setRedirect(true);
    }
}