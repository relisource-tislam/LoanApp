public with sharing class gurantorDetailsController {
   
    Public obj_Guarantor__c objGuarant{ get;set;}
    Public List<obj_Guarantor__c> chkObjGuarantList{ get;set;}
    Public List<obj_Guarantor__c> dupGuarantorList { get;set;}    
    
    Public String sId {get;set;}
    Public String appId {get;set;}
    Public String btnText {get;set;}
    Public boolean primaryFlag {get;set;}
    Public boolean dupliFlag {get;set;}
    
    
    Public Id gId {get;set;}
    
    public gurantorDetailsController (){
    
        objGuarant = new obj_Guarantor__c();    
        
        appId  = ApexPages.currentPage().getParameters().get('appId');
        sId  = ApexPages.currentPage().getParameters().get('sId');
        btnText ='Save';
        primaryFlag =false;
        dupliFlag = false;
        
        if(! String.isBlank(sId)){
            try{
                objGuarant= [SELECT Id, Name, Percentage__c, Relation__c, Primary__c,obj_GuarantorCollection__c FROM obj_Guarantor__c Where Id =:sId ];
                
                primaryFlag = (objGuarant.Primary__c == true) ? true : false;
                dupliFlag = String.isNotBlank(objGuarant.obj_GuarantorCollection__c) ? true : false;
                btnText ='Update';
            }
            catch(Exception e){
                objGuarant = new obj_Guarantor__c();
                btnText ='Save';
            }            
        }        
    }  
       
        
     public PageReference addOrUpdate() {
         
         try{
             objGuarant.Application__c = appId;              
             
             chkObjGuarantList = [SELECT Id, Name, Percentage__c, Relation__c, Primary__c, obj_GuarantorCollection__c FROM obj_Guarantor__c Where Application__c =:appId and Primary__c=true ]; //or Self_guarantor__c = true
             
             for(obj_Guarantor__c chkObjGuarant : chkObjGuarantList ){
             
                //Duplicate Primary duplicate Check....
                if(chkObjGuarant.Primary__c == true && objGuarant.Primary__c == true  && primaryFlag !=true ){  //&& String.isBlank(sId)
                        ApexPages.Message msg = new ApexPages.Message(ApexPages.Severity.Error, 'Primary guarantor already exist');
                        ApexPages.addMessage(msg );
                        return null;
                  }                      
              }              
                
            //Duplicate Checking...............
                
            dupGuarantorList =  [SELECT Id, obj_GuarantorCollection__c FROM obj_Guarantor__c Where obj_GuarantorCollection__c=:objGuarant.obj_GuarantorCollection__c and Application__c=:appId  and Id !=: sId Limit 1];
            for(obj_Guarantor__c dupGuarantor: dupGuarantorList ){                
                if( String.isNotBlank(dupGuarantor.obj_GuarantorCollection__c) ){  
                    ApexPages.Message msg = new ApexPages.Message(ApexPages.Severity.Error, 'Selected guarantor already exist');
                    ApexPages.addMessage(msg );
                    return null;  
                } 
            } 
                         
             upsert objGuarant;  
             
            }
         catch(Exception ex){         
            ApexPages.Message msg = new ApexPages.Message(ApexPages.Severity.Error, ex.getmessage());
            ApexPages.addMessage(msg );
            return null;
         }  
           
         PageReference pg = new PageReference('/apex/GuarantorList?appId=' + appId);
         return pg.setRedirect(true); 
    }    
    
    public PageReference addGuarantor() {
         PageReference pg = new PageReference('/apex/addGuarantor?appId=' + appId + '&sId=' + sId );
         return pg.setRedirect(false); 
        }
    
    public PageReference Cancel() {
         PageReference pg = new PageReference('/apex/GuarantorList?appId=' + appId);
         return pg.setRedirect(true); 
        }        
  }