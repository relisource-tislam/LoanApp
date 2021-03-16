public class ContactListController {

    public String vfParam {get;set;}
    
    public PageReference doCommandLink() {    
        PageReference pg = new PageReference('/apex/test2?id=' + vfParam);
        return pg.setRedirect(true);         
    }
    public List<Contact> getContacts(){
        List<Contact> results = [Select Name, FirstName, LastName, Email, Title From Contact];
        return results;
    }    
}