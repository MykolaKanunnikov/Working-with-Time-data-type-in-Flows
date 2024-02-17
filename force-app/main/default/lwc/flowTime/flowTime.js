import { LightningElement, api } from 'lwc';

export default class FlowTime extends LightningElement {

    @api label = 'Enter Time';
    //e.g. 18:30:00.000 (HH:MM:SS.MS)
    @api value;
    //e.g. 2000-01-01 18:30:00 (YYYY-MM-DD HH:MM:SS)
    @api timeInDateTimeString;

    handleChange(event) {
        let value = event.detail.value;
        this.value = value;
        //any date can replace 2000-01-01. We can attach it in the Flow instead
        //we remove milliseconds since they are not expected by DATETIMEVALUE() formula function 
        this.timeInDateTimeString = `2000-01-01 ${value.split('.')[0]}`;
    }

}