/**
 * Created by rashimi on 3/1/2022.
 */
@IsTest
public with sharing class TestRestrictContactByName {
    @IsTest
    private static void TestRestrictContactByLastName(){
        Contact contact = new Contact(FirstName = 'Test Contact 1', LastName = 'INVALIDNAME');
        insert contact;
        Database.SaveResult result;

        test.startTest();
        try{
            result = Database.insert(Contact, false);
        } catch(Exception exc){

        }

        test.stopTest();

        System.assert(!result.isSuccess());
        system.assertEquals('The Last Name of the contact is invalid', result.getErrors()[0].getMessage());
    }


    private static void TestRestrictContactByLastName2(){
        Contact contact = new Contact(FirstName = 'Test Contact 1', LastName = 'INVALIDNAME');
        insert contact;

        test.startTest();
        Database.SaveResult result = Database.insert(Contact);
        test.stopTest();

        System.assert(!result.isSuccess());
        system.assert(result.getErrors().size()>0);
        system.assertEquals('The Last Name of the contact is invalid', result.getErrors()[0].getMessage());
    }
}