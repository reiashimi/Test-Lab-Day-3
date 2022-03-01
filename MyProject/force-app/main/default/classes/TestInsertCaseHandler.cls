/**
 * Created by rashimi on 3/1/2022.
 */
@IsTest
public with sharing class TestInsertCaseHandler {

    @IsTest
    private static void TestInsertCaseHandlerOpen(){
        Case c = TestDataFactory.createTestCase('Open', 'Medium');

        test.startTest();
        InsertCaseHandler.updateCase(c);
        test.stopTest();

        System.assert(c.Priority == 'Low');
    }

    private static void TestInsertCaseHandlerNotOpen(){
        Case c = TestDataFactory.createTestCase('Approved', 'Low');

        test.startTest();
        InsertCaseHandler.updateCase(c);
        test.stopTest();

        System.assert(c.Priority == 'Medium');
    }
}