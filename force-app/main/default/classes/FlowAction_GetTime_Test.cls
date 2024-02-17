@isTest
private with sharing class FlowAction_GetTime_Test {
    @isTest
    static void testGetTime() {
        // prepare data
        Time originalTime = Time.newInstance(10, 10, 10, 10);
        Account acc = new Account(Name = 'Test', Working_Hours_Start__c = originalTime);
        insert acc;

        FlowAction_GetTime.FlowTime ft = new FlowAction_GetTime.FlowTime();
        ft.record = acc;
        ft.timeFields = 'Working_Hours_Start__c';

        Test.startTest();
            List<List<Datetime>> dateTimes = FlowAction_GetTime.getTime(new List<FlowAction_GetTime.FlowTime>{ ft });
        Test.stopTest();

        // verify
        Assert.areNotEqual(null, dateTimes[0][0], 'null is not expected');
        Assert.areEqual(originalTime.hour(), dateTimes[0][0].timeGmt().hour(), 'Original and exracted hours are not expected to be different');
    }
}
