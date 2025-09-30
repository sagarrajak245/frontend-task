import { memo } from 'react';
import './CustomerCard.css';

const CustomerCard = memo(({ index, style, items, selectedCustomers, onSelect }) => {
  const customer = items[index];

  if (!customer) {
    return (
      <div style={style} className="customer-card loading-card">
        Loading...
      </div>
    );
  }

  const isSelected = selectedCustomers.has(customer.id);

  return (
    <div style={style} className="customer-card">
      <input
        type="checkbox"
        checked={isSelected}
        onChange={() => onSelect(customer.id)}
        className="customer-checkbox"
      />
      <div className="customer-info">
        <img src={customer.avatar} alt={customer.name} className="customer-avatar" />
        <div className="customer-details">
          <span className="customer-name">{customer.name}</span>
          <span className="customer-phone">{customer.phone}</span>
        </div>
      </div>
      <div className="customer-count">{customer.messageCount}</div>
      <div className="customer-email">{customer.email}</div>
      <div className="customer-date">{customer.lastMessageDate}</div>
      <div className="customer-added-by">

        <img src="\public\test_user-3 3.svg" alt="user" className="added-by-avatar" />
        <span>{customer.addedBy}</span>
      </div>
    </div>
  );
});

CustomerCard.displayName = 'CustomerCard';

export default CustomerCard; 