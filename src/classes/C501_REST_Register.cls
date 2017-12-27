@RestResource(urlMapping='/C501_REST_Register/*')
global class C501_REST_Register {

    public class InvalidParameterValueException extends Exception {}
    public class NoDataFoundException extends Exception {}

  @HttpPost
    global static void doPost(String source, String email, String name, Boolean newsletter, String message) {
        
        RestResponse res = RestContext.response;
        if (res == null) {
            res = new RestResponse();
            RestContext.response = res;
        }
        
        try {
            
            res.responseBody = Blob.valueOf(JSON.serialize(post(source, email, name, newsletter, message)));
            res.statusCode = 201;
        }
        catch (InvalidParameterValueException e) {
            
            res.responseBody = Blob.valueOf(
                String.valueOf(e) + '\n\n' + e.getStackTraceString()
            );
            res.statusCode = 400;
        }
        catch (NoDataFoundException e) {
            
            res.responseBody = Blob.valueOf(
                String.valueOf(e) + '\n\n' + e.getStackTraceString()
            );
            res.statusCode = 400;
        }
        catch (Exception e) {
            res.responseBody = Blob.valueOf(
                'General Exception: ' + String.valueOf(e) + '\n\n' + e.getStackTraceString()
            );
            res.statusCode = 500;
        }
    }
    
    private static Boolean ValidateEmail(String email) {
        
        Boolean res = true;
        String emailRegex = '^[a-zA-Z0-9._|\\\\%#~`=?&/$^*!}{+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,4}$'; // source: <a href="http://www.regular-expressions.info/email.html" target="_blank" rel="nofollow">http://www.regular-expressions.info/email.html</a>
        Pattern MyPattern = Pattern.compile(emailRegex);
        Matcher MyMatcher = MyPattern.matcher(email);
    
        if (!MyMatcher.matches()) 
            res = false;
        return res; 
    }
    
    private static Lead post(String source, String email, String name, Boolean newsletter, String message) {
        
        if (String.isBlank(source)) {
   	        throw new InvalidParameterValueException('Error: Required source field is blank.');
        }

        if (String.isBlank(email) || email.length() < 4 || !ValidateEmail(email)) {
  	        throw new InvalidParameterValueException('Error: Required email address is invalid: ' + email);
        }
 
        // Check if name blank then set to front part of email address since last name required for a Salesforce contact
        if (string.isBlank(name)) {
            List<String> nameTokens = email.split('@');
            name = nameTokens[0];
        }
        
	    if (newsletter == null) {
            newsletter = true;
        }

	    if (message == null) {
            message = '';
        }
        
        Lead lead = new Lead();
        
        lead.Message__c = message;
        lead.email = email;
        lead.Company = 'VROOM_WEB';
        lead.LeadSource = 'VROOM_' + source;
        lead.HasOptedOutOfEmail = !newsletter;
        lead.LastName = name;
        if (lead.LastName.contains(' ')) {
            List<String> nameTokens = lead.LastName.split(' ');
            lead.FirstName = nameTokens[0];
            lead.LastName = lead.LastName.substring(nameTokens[0].length());
        }
                
       	insert lead;
        
        return lead;
    }
}