public class leaseController{   

   public List<obj_Lease__c> objleas{ get; set; }
     public String vfParam{get;set;}
     
    PUblic leaseController(){
         objleas=  [SELECT Id, Name, First_Name__c, Last_Name__c, Father_s_Name__c, Mother_s_Name__c, SSN__c, Cell_no__c, Email__c, Address__c,Occupation__c FROM obj_Lease__c];
    }

    public PageReference newOrAddLease() {   
        PageReference pg; 
        if(String.IsNotBlank(vfParam)){
            pg = new PageReference('/apex/LeaseDetails?id=' + vfParam);
        }
        else{
            pg = new PageReference('/apex/LeaseDetails');
        }
        return pg.setRedirect(true);
    }

}