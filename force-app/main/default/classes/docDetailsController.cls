public with sharing class docDetailsController {

    public obj_Document__c objDoc { get; set; }   
    Public string sId {get;set;}
    Public string appId {get;set;}
    Public string btnText {get;set;}
    
    public string fileName{get;set;}    
    public Blob fileBody{get;set;}       
    
    Public String docId {get;set;}
    
    public docDetailsController (){
    
        objDoc = new obj_Document__c ();
        sId = ApexPages.currentPage().getParameters().get('sId');
        appId  = ApexPages.currentPage().getParameters().get('appId');       
        
        btnText ='Save';
        docId = sId ;
        if(! String.isEmpty(sId)){
            try{
                objDoc = [SELECT Id, Name, Name__c, Type__c FROM obj_Document__c Where Id =:  sId];
                btnText ='Update';
              }
              Catch(Exception e){
                  objDoc = new obj_Document__c ();
              }           
            }        
        }    

     public PageReference addOrEdit() {
        
        ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING, 'App = > ' +appId));
        try{
        
            if(String.isBlank(objDoc.Id)){            
                objDoc.Application__c = appId;
            }         
            
            Upsert objDoc;
            docId = objDoc.Id; 
            UploadFile();            
        }
        catch(exception ex){
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING, ex.getMessage()));
            return null;
        }       
        PageReference pg = new PageReference('/apex/DocumentList?appId=' + appId);
        return pg.setRedirect(true);  
    }
    
    public PageReference Cancel() {
        PageReference pg = new PageReference('/apex/DocumentList?appId=' + appId);
        return pg.setRedirect(true);
    }              
  
    public void UploadFile()
    {    
            if(fileBody != null && fileName != null)
            {
              Attachment myAttachment  = new Attachment();
              myAttachment.Body = fileBody;
              myAttachment.Name = fileName;
              myAttachment.ParentId = docId;
              insert myAttachment;
              //pr = new PageReference('/' + myAttachment.Id);
            }
        }
        
}