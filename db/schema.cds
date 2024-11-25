namespace com.inventory;

entity Items {
  key id          : UUID;
      name        : String(100) @title: 'Name';
      description : String(500) @title: 'Description';
      quantity    : Integer @title: 'Quantity';
      unit        : String(20) @title: 'Unit';
      category    : String(50) @title: 'Category';
      location    : String(100) @title: 'Storage Location';
      minStock    : Integer @title: 'Minimum Stock';
      supplier    : Association to Suppliers;
      createdAt   : Timestamp @cds.on.insert: $now;
      modifiedAt  : Timestamp @cds.on.insert: $now @cds.on.update: $now;
}

entity Suppliers {
  key id      : UUID;
      name    : String(100) @title: 'Name';
      email   : String(100) @title: 'Email';
      phone   : String(20) @title: 'Phone';
      address : String(200) @title: 'Address';
      items   : Association to many Items on items.supplier = $self;
}
