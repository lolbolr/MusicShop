const cds = require('@sap/cds');
const { SELECT, UPDATE } = require('@sap/cds/lib/ql/cds-ql');

module.exports = class MusicService extends cds.ApplicationService {
    init() {
        const { InstrumentModels, Instruments } = cds.entities('music.store');


        this.after('READ', 'InstrumentModels', async (imodels) => {

            const modelId = imodels.map(imodel => imodel.ID);
            const instCounts = await SELECT.from(Instruments)
                .columns('model_ID', { func: 'count' })
                .where({ model_ID: { in: modelId } })
                .groupBy('model_ID');

            for (const imodel of imodels) {
                const instCount = instCounts.find(ic => ic.model_ID === imodel.ID);
                imodel.InstrumentCount = instCount ? instCount.count : 0;
            }
        })

        this.on('READ', 'A_BusinessPartner', async req => {
            const bp = await cds.connect.to('API_BUSINESS_PARTNER');
            return bp.run(req.query);
        })
        this.before('*', (req) => {
            console.log('________________________________________________')
            console.log(req.user)
        })
        this.on('dispSupp', async (req) => {
            const { myString } = req.data;
            const bp = await cds.connect.to('API_BUSINESS_PARTNER');

            const result = await bp.run(
                SELECT.from('A_BusinessPartner')
                    .where({ BusinessPartner: myString })
            )
            console.log(result);
            return result[0].BusinessPartnerFullName;
        })

        this.on('assignTechnician', async (req) => {
            const incidentID = req.params[0].ID;
            const { employeeID } = req.data;

            const { RepairIncidents, Employees } = cds.entities;

            const emp = await SELECT.one.from(Employees).where({ ID: employeeID })
            if (!emp) {
                req.error('Employee not present')
            }

            await UPDATE(RepairIncidents)
                .set({ assignedTo_ID: employeeID })
                .where({ ID: incidentID });

            return 'Success';
        })
        return super.init()
    }
}
