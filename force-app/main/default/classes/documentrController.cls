public class documentrController {

    public PageReference addOrUpdate() {
        return null;
    }
    
   public List<obj_Document__c> objDoc{ get; set; }
     public String vfParam{get;set;}
     
    PUblic documentrController (){
         objDoc=  [SELECT Id, Name, Name__c, Type__c, Application__c FROM obj_Document__c];
    }

    public PageReference doEdit() {
        PageReference pg = new PageReference('/apex/GuarantorDetails?id=' + vfParam);
        return pg.setRedirect(true);
    }   

    public PageReference nextGrid() {
        return null;
    }

    public PageReference addNew() {
        PageReference pg = new PageReference('/apex/GuarantorDetails');
        return pg.setRedirect(true);
    }

}