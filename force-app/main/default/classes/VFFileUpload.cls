public with sharing class VFFileUpload {

    public Id recId{    get;set;    }
    public Id appId  {    get;set;    }
   // public Id sId  {    get;set;    }
           
    public VFFileUpload(docDetailsController controller) {
         appId  = ApexPages.currentPage().getParameters().get('appId');
         //sId  = ApexPages.currentPage().getParameters().get('sId');
    }
    
    public VFFileUpload(ApexPages.StandardController ctlr)
    {
      appId  = ApexPages.currentPage().getParameters().get('appId');
     // sId  = ApexPages.currentPage().getParameters().get('sId');
    }
    
    public string fileName 
    {    get;set;    }
    
    public Blob fileBody 
    {    get;set;    }
  
    public PageReference UploadFile()
    {
        PageReference pr;
        if(fileBody != null && fileName != null)
        {
          Attachment myAttachment  = new Attachment();
          myAttachment.Body = fileBody;
          myAttachment.Name = fileName;
          myAttachment.ParentId = appId;
          insert myAttachment;
           //pr = new PageReference('/' + myAttachment.Id);
           //pr.setRedirect(true);
         //  return pr;
          return null;
        }
        return null;
    }  
}