using {API_BUSINESS_PARTNER as s4} from './external/API_BUSINESS_PARTNER.cds';

service BusinessPartner {

    entity A_BusinessPartner as
        projection on s4.A_BusinessPartner {
            key BusinessPartner,
                BusinessPartnerFullName
        };

}