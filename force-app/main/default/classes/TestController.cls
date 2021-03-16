public class TestController {
    
    Public String testId {get;set;}
    Public Contact cnt{ get;set;}
    
    Public TestController (){
        //cnt = [Select Id, FirstName, LastName, Email,Title From Contact Where Id =:  ApexPages.currentPage().getParameters().get('id')];
        testId  = ApexPages.currentPage().getParameters().get('id');
        getContact();
    }
    
    Public Contact getContact(){
      cnt = [Select Id, FirstName, LastName, Email,Title From Contact Where Id =:  ApexPages.currentPage().getParameters().get('id')];
      return null;
     }
     
    Public PageReference UpdateMe() {
     Upsert cnt;
     PageReference pg = new PageReference('/apex/LoanApplications');
     return pg.setRedirect(true); 
    }
}