/*
 * ClassName: orlRetailStoreTableController
 * Author: Pooja V
 * Date: 26-10-2023
 * Description:The Apex class provides a method, getRetailStoreData, that retrieves retail store data based on the user Id provided. 
	The class is designed to be used in Lightning components, and the method is exposed to the Lightning framework using the @AuraEnabled annotation. 
	The code includes error handling to catch and handle exceptions that may occur during the data retrieval process.
*/

public without sharing class orlRetailStoreTableController {
    
    @AuraEnabled  // makes the method accessible to Lightning components via Aura framework.
    
// This is a static method that accepts a parameter of type Id named userIds, This userId is coming from LWC component orlRetailStoreTable.
    
    public static List<Account_Retail_Store__c> getRetailStoreData(Id userIds) {
        String accountId = [SELECT AccountId FROM User WHERE Id = :userIds].AccountId;
        List<Account_Retail_Store__c> retlist = new List<Account_Retail_Store__c>(); 
      try {
          
/*
 * SOQL query is used to retrieve specific fields from the junction object 'Account_Retail_Store__c',
 * The query filters the records based on the AccountId obtained earlier.
 * If the query is successful, the retrieved records are assigned to the retlist 
 * If an exception occurs during the query execution, an AuraHandledException is thrown with an error message. 
*/   
            retlist = [
                SELECT Id, Retail_Store__r.Name, Retail_Store__r.Address, Retail_Store__r.DeliveryMethod, Retail_Store__r.StoreType, Account__c 
                FROM Account_Retail_Store__c
                WHERE Account__c = :accountId
            ];
        } catch (Exception e) {
            throw new AuraHandledException('An error occurred: ' + e.getMessage());
        }
        return retlist;
    }
}