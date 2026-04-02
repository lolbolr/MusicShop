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

        return super.init()
    }
}