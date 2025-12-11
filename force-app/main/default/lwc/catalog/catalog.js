import { LightningElement, wire } from 'lwc';
import { getRecord, getFieldValue } from 'lightning/uiRecordApi';
import CONTACT_NATION from '@salesforce/schema/Contact.Nationality__c';
import mdtMap from '@salesforce/apex/ReqController.mdtMap';
import USER_ID from '@salesforce/user/Id';
import CONTACT_ID_FIELD from '@salesforce/schema/User.ContactId';

export default class Catalog extends LightningElement {
    records = [];
    columns = [
        { label: 'Label', fieldName: 'MasterLabel' },
        { label: 'Requirement Type', fieldName: 'Requirement_Type__c' }
    ];
    nationality;
    contactId;
    @wire(mdtMap)
    wireMdt({ data, error }) {
        if (data) {
            this.records = data;
        } else if (error) {
            console.error('Error fetching MDT:', error);
            this.records = [];
        }
    }

    @wire(getRecord, { recordId: USER_ID, fields: [CONTACT_ID_FIELD] })
    wiredUser({ data, error }) {
        if (data) {
            this.contactId = getFieldValue(data, CONTACT_ID_FIELD);
            console.log('Current user contactId:', this.contactId);
        } else if (error) {
            console.error('Error fetching user:', error);
        }
    }

    @wire(getRecord, { recordId: '$contactId', fields: [CONTACT_NATION] })
    wiredContact({ data, error }) {
        if (data) {
            this.nationality = getFieldValue(data, CONTACT_NATION);
            console.log('User nationality:', this.nationality);
        } else if (error) {
            console.error('Error fetching contact:', error);
        }
    }

    get filteredRecords() {
        if (!this.records || !this.nationality) {
            return [];
        }

        if (this.nationality === 'Malaysian') {
            return this.records.filter(rec => rec.Requirement_Type__c === 'Domestic');
        } else {
            return this.records.filter(rec => rec.Requirement_Type__c === 'International');
        }
    }


get isDomestic() {
    return this.nationality === 'Malaysian' ? 'Domestic' : 'International';
}


    
}