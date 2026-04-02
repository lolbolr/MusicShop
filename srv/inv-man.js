module.exports = class InvMan extends cds.ApplicationService {
  async init() {
    this.on('approve', 'PartRequests', async (req) => {

      const requestID = req.params[0].ID

      const request = await SELECT.one
        .from('music.store.PartRequests')
        .where({ ID: requestID })

      if (!request) {
        req.error('Request not found')
      }

      if (request.status !== 'REQUESTED') {
        req.error('Request already processed')
      }

      await UPDATE('music.store.Parts')
        .set({
          quantity: { '+=': request.quantity }
        })
        .where({ ID: request.part_ID })

      await UPDATE('music.store.PartRequests')
        .set({ status: 'APPROVED' })
        .where({ ID: requestID })

      return 'Request approved and stock updated'
    })

    this.on('reject', 'PartRequests', async (req) => {

      const requestID = req.params[0].ID

      const request = await SELECT.one
        .from('music.store.PartRequests')
        .where({ ID: requestID })

      if (!request) {
        req.error('Request not found')
      }

      if (request.status !== 'REQUESTED') {
        req.error('Request already processed')
      }

      await UPDATE('music.store.PartRequests')
        .set({ status: 'REJECTED' })
        .where({ ID: requestID })

      return 'Request rejected'
    })
    return super.init()
  }
}