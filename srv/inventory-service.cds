using { com.inventory as inv } from '../db/schema';

service InventoryService {
  entity Items as projection on inv.Items;
  entity Suppliers as projection on inv.Suppliers;
  
  action replenishStock(itemId: UUID, quantity: Integer) returns String;
  function getLowStockItems() returns array of Items;
}
