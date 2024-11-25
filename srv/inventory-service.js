const cds = require('@sap/cds')

module.exports = cds.service.impl(async function() {
  const { Items } = this.entities
  
  this.on('replenishStock', async (req) => {
    const { itemId, quantity } = req.data
    const tx = cds.transaction(req)
    
    const item = await tx.read(Items).where({ id: itemId })
    if (!item.length) {
      return `Item with ID ${itemId} not found`
    }
    
    await tx.update(Items)
      .set({ quantity: { '+=': quantity } })
      .where({ id: itemId })
    
    return `Stock updated successfully. Added ${quantity} units.`
  })
  
  this.on('getLowStockItems', async () => {
    const items = await cds.read(Items)
      .where({ quantity: { '<=': { ref: 'minStock' } } })
    return items
  })
  
  this.before('CREATE', 'Items', async (req) => {
    if (!req.data.id) {
      req.data.id = cds.utils.uuid()
    }
  })
  
  this.before('CREATE', 'Suppliers', async (req) => {
    if (!req.data.id) {
      req.data.id = cds.utils.uuid()
    }
  })
})
