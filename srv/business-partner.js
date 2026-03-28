module.exports = class BusinessPartner extends cds.ApplicationService {
  async init() {

    this.on('READ', 'A_BusinessPartner', async req => {
                const bp = await cds.connect.to('API_BUSINESS_PARTNER');
                return bp.run(req.query);
            })

    return super.init()
  }
}