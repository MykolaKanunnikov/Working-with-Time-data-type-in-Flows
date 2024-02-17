/**
 * @description workaround for time manipulations in Flows
 */
public with sharing class FlowAction_GetTime {

    /**
     * @description getTime returns Time converted to Datetime we can use in Flows.
     * If the field has no value, the method will return null. 
     * The number of elements in the returned array is always equal to the number of fields passed to the parameter
     * @param  params  List<FlowTime>
     * @return         List<List<Datetime>> that actually acts like just a List<Datetime>
     */
    @InvocableMethod(label='Get Time' description='Returns Time converted to Datetime. It returns null when field has no value' iconName='slds:standard:date_time')
    public static List<List<Datetime>> getTime(List<FlowTime> params) {

        List<Datetime> dateTimes = new List<Datetime>();
        List<String> timeFields = new List<String>();
        String datePart = '2000-01-01'; // any date can replace this

        for (FlowTime ft : params) {
            sObject record = ft.record;
            for (String field :  ft.timeFields.split(',')) {
                if (field == null || field.isWhitespace()) {
                    continue; // skip items without actual value
                }
                if (record.get(field.trim()) != null) {
                    Time timeValue = (Time)record.get(field.trim());
                    String timePart = String.valueOf(timeValue).left(8); // without milliseconds
                    dateTimes.add(Datetime.valueOfGmt(datePart + ' ' + timePart));
                } else {
                    dateTimes.add(null); // indicates that field has no value
                }
            }    
        }

        return new List<List<Datetime>>{ dateTimes };
    }

    /**
     * @description Wrapper for input parameters
     */
    public class FlowTime {
        /**
         * @description record with fields of Time datatype
         */
        @InvocableVariable(label='Record with Time fields'  required=true)
        public sObject record;
        /**
         * @description API names of Time fields of the given record like: 'timeField1__c, timeField2__c'
         */
        @InvocableVariable(label='Comma-separated list of Time fields API names' required=true)
        public String timeFields;
    }

}