const cds = require('@sap/cds');
const { SELECT, UPDATE } = require('@sap/cds/lib/ql/cds-ql');

module.exports = class TechnicianService extends cds.ApplicationService {
    async init() {

        this.on('reqParts', 'Parts', async (req) => {

            const partID = req.params[0].ID
            const { quantity } = req.data

            if (!quantity || quantity <= 0) {
                req.error('Quantity must be greater than 0')
            }

            await INSERT.into('music.store.PartRequests').entries({
                part_ID: partID,
                quantity: quantity,
                status: 'REQUESTED'
            })

            return 'Part request submitted successfully'
        })

        this.on('inprog', 'RepairIncidents', async (req) => {
            const requestID = req.params[0].ID

            await UPDATE('music.store.RepairIncidents')
                .set({
                    status: 'IN_PROGRESS'
                }).where({
                    ID: requestID
                })
            return 'Incident in progress'
        })

        this.on('onhold', 'RepairIncidents', async (req) => {
            const requestID = req.params[0].ID

            await UPDATE('music.store.RepairIncidents')
                .set({
                    status: 'ONHOLD'
                }).where({
                    ID: requestID
                })
            return 'Incident set on hold'
        })

        this.on('resolved', 'RepairIncidents', async (req) => {
            const requestID = req.params[0].ID

            await UPDATE('music.store.RepairIncidents')
                .set({
                    status: 'RESOLVED'
                }).where({
                    ID: requestID
                })
            return 'Incident resolved'
        })

        this.on('cancelled', 'RepairIncidents', async (req) => {
            const requestID = req.params[0].ID

            await UPDATE('music.store.RepairIncidents')
                .set({
                    status: 'CANCELED'
                }).where({
                    ID: requestID
                })
            return 'Incident cancelled'
        })

        return super.init()
    }
}