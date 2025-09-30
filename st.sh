#!/bin/bash

echo "🚀 Starting project setup..."

# Create directory structure
echo "📁 Creating directories..."
mkdir -p src/components/Header
mkdir -p src/components/SearchBar
mkdir -p src/components/FilterDropdown
mkdir -p src/components/TableHeader
mkdir -p src/components/CustomerCard
mkdir -p src/data

# --- File: src/index.css (Global Styles) ---
echo "🎨 Creating src/index.css..."
cat << 'EOF' > src/index.css
* {
  margin: 0;
  padding: 0;
  box-sizing: border-box;
}

body {
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', 'Roboto', sans-serif;
  background-color: #f9fafb;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}
EOF

# --- File: src/App.css (Main App Styles) ---
echo "🎨 Creating src/App.css..."
cat << 'EOF' > src/App.css
.app-container {
  min-height: 100vh;
}

.content {
  padding: 24px;
  max-width: 1400px;
  margin: 0 auto;
}

.title-section {
  display: flex;
  align-items: center;
  gap: 12px;
  margin-bottom: 24px;
}

.page-title {
  font-size: 24px;
  font-weight: 600;
  color: #111827;
}

.customer-count-badge {
  background-color: #10b981;
  color: white;
  padding: 2px 10px;
  border-radius: 12px;
  font-size: 14px;
  font-weight: 500;
}

.toolbar {
  display: flex;
  gap: 12px;
  margin-bottom: 20px;
}

.table-container {
  background-color: white;
  border-radius: 12px;
  border: 1px solid #e5e7eb;
  overflow: hidden;
}

.customer-list {
  max-height: calc(100vh - 300px);
  overflow-y: auto;
}
EOF

# --- File: src/data/mockData.js ---
echo "📄 Creating src/data/mockData.js..."
cat << 'EOF' > src/data/mockData.js
import { faker } from '@faker-js/faker';

// Generate 20 realistic mock customers
export const generateMockCustomers = () => {
  return Array.from({ length: 20 }, (_, i) => {
    const firstName = faker.person.firstName();
    const lastName = faker.person.lastName();
    const name = `${firstName} ${lastName}`;

    return {
      id: faker.string.uuid(),
      name: name,
      phone: faker.phone.number(),
      email: faker.internet.email({ firstName, lastName }),
      messageCount: faker.number.int({ min: 1, max: 99 }),
      lastMessageDate: faker.date.recent().toLocaleDateString('en-US', {
        month: 'long',
        day: 'numeric',
        year: 'numeric',
        hour: '2-digit',
        minute: '2-digit'
      }),
      addedBy: faker.person.fullName(),
      // Using a placeholder for local images.
      // Replace '/avatars/avatar_1.png' with your actual image paths in the public folder.
      avatar: `https://ui-avatars.com/api/?name=${encodeURIComponent(name)}&background=ff8c42&color=fff`
    };
  });
};
EOF

# --- File: src/components/Header/Header.jsx ---
echo "📄 Creating src/components/Header/Header.jsx..."
cat << 'EOF' > src/components/Header/Header.jsx
import React from 'react';
import './Header.css';

const Header = () => {
  return (
    <header className="header">
      <div className="logo-container">
        {/* You can replace this inline SVG with an <img src="/logo.svg" /> from your public folder */}
        <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="#10b981" strokeWidth="2">
          <polyline points="20 6 9 17 4 12"></polyline>
          <polyline points="20 6 9 17 4 12" transform="translate(0, 4)"></polyline>
        </svg>
        <h1 className="logo-text">DoubleTick</h1>
      </div>
    </header>
  );
};

export default Header;
EOF

# --- File: src/components/Header/Header.css ---
echo "🎨 Creating src/components/Header/Header.css..."
cat << 'EOF' > src/components/Header/Header.css
.header {
  background-color: white;
  border-bottom: 1px solid #e5e7eb;
  padding: 16px 24px;
}

.logo-container {
  display: flex;
  align-items: center;
  gap: 8px;
}

.logo-text {
  font-size: 20px;
  font-weight: 600;
  color: #111827;
}
EOF

# --- File: src/components/SearchBar/SearchBar.jsx ---
echo "📄 Creating src/components/SearchBar/SearchBar.jsx..."
cat << 'EOF' > src/components/SearchBar/SearchBar.jsx
import React from 'react';
import './SearchBar.css';

const SearchBar = ({ value, onChange }) => {
  return (
    <div className="search-container">
      {/* You can replace this inline SVG with an <img src="/icons/search.svg" /> */}
      <svg className="search-icon" width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2">
        <circle cx="11" cy="11" r="8"></circle>
        <path d="m21 21-4.35-4.35"></path>
      </svg>
      <input
        type="text"
        placeholder="Search Customers"
        value={value}
        onChange={(e) => onChange(e.target.value)}
        className="search-input"
      />
    </div>
  );
};

export default SearchBar;
EOF

# --- File: src/components/SearchBar/SearchBar.css ---
echo "🎨 Creating src/components/SearchBar/SearchBar.css..."
cat << 'EOF' > src/components/SearchBar/SearchBar.css
.search-container {
  position: relative;
  flex: 1;
  max-width: 300px;
}

.search-icon {
  position: absolute;
  left: 12px;
  top: 50%;
  transform: translateY(-50%);
  color: #9ca3af;
}

.search-input {
  width: 100%;
  padding: 10px 12px 10px 40px;
  border: 1px solid #e5e7eb;
  border-radius: 8px;
  font-size: 14px;
  outline: none;
  transition: border-color 0.2s;
}

.search-input:focus {
  border-color: #10b981;
}
EOF

# --- File: src/components/FilterDropdown/FilterDropdown.jsx ---
echo "📄 Creating src/components/FilterDropdown/FilterDropdown.jsx..."
cat << 'EOF' > src/components/FilterDropdown/FilterDropdown.jsx
import React from 'react';
import './FilterDropdown.css';

const FilterDropdown = ({ isOpen, onToggle, filters, onFilterSelect }) => {
  return (
    <div className="filter-container">
      <button className="filter-button" onClick={onToggle}>
        {/* You can replace this inline SVG with an <img src="/icons/filter.svg" /> */}
        <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2">
          <polygon points="22 3 2 3 10 12.46 10 19 14 21 14 12.46 22 3"></polygon>
        </svg>
        Add Filters
      </button>

      {isOpen && (
        <div className="filter-dropdown">
          {filters.map((filter, index) => (
            <div
              key={index}
              className="filter-option"
              onClick={() => onFilterSelect(filter)}
            >
              {filter}
            </div>
          ))}
        </div>
      )}
    </div>
  );
};

export default FilterDropdown;
EOF

# --- File: src/components/FilterDropdown/FilterDropdown.css ---
echo "🎨 Creating src/components/FilterDropdown/FilterDropdown.css..."
cat << 'EOF' > src/components/FilterDropdown/FilterDropdown.css
.filter-container {
  position: relative;
}

.filter-button {
  display: flex;
  align-items: center;
  gap: 8px;
  padding: 10px 16px;
  background-color: white;
  border: 1px solid #e5e7eb;
  border-radius: 8px;
  font-size: 14px;
  cursor: pointer;
  transition: all 0.2s;
}

.filter-button:hover {
  background-color: #f9fafb;
  border-color: #d1d5db;
}

.filter-dropdown {
  position: absolute;
  top: 100%;
  left: 0;
  margin-top: 4px;
  background-color: white;
  border: 1px solid #e5e7eb;
  border-radius: 8px;
  box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1);
  min-width: 160px;
  z-index: 10;
}

.filter-option {
  padding: 10px 16px;
  font-size: 14px;
  cursor: pointer;
  transition: background-color 0.2s;
}

.filter-option:hover {
  background-color: #f3f4f6;
}

.filter-option:first-child {
  border-radius: 8px 8px 0 0;
}

.filter-option:last-child {
  border-radius: 0 0 8px 8px;
}
EOF

# --- File: src/components/TableHeader/TableHeader.jsx ---
echo "📄 Creating src/components/TableHeader/TableHeader.jsx..."
cat << 'EOF' > src/components/TableHeader/TableHeader.jsx
import React from 'react';
import './TableHeader.css';

const TableHeader = () => {
  return (
    <div className="table-header">
      <div className="header-cell header-checkbox"></div>
      <div className="header-cell header-customer">Customer</div>
      <div className="header-cell header-count"></div>
      <div className="header-cell header-email"></div>
      <div className="header-cell header-date">Last message sent at</div>
      <div className="header-cell header-added">Added by</div>
    </div>
  );
};

export default TableHeader;
EOF

# --- File: src/components/TableHeader/TableHeader.css ---
echo "🎨 Creating src/components/TableHeader/TableHeader.css..."
cat << 'EOF' > src/components/TableHeader/TableHeader.css
.table-header {
  display: grid;
  grid-template-columns: 40px 300px 60px 250px 220px 1fr;
  padding: 12px 16px;
  background-color: #f9fafb;
  border-bottom: 1px solid #e5e7eb;
  font-size: 12px;
  font-weight: 600;
  color: #6b7280;
  text-transform: uppercase;
  letter-spacing: 0.5px;
}
EOF

# --- File: src/components/CustomerCard/CustomerCard.jsx ---
echo "📄 Creating src/components/CustomerCard/CustomerCard.jsx..."
cat << 'EOF' > src/components/CustomerCard/CustomerCard.jsx
import React from 'react';
import './CustomerCard.css';

const CustomerCard = ({ customer, isSelected, onSelect }) => {
  return (
    <div className="customer-card">
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
        {/* You can replace this inline SVG with an <img src="/icons/user.svg" /> */}
        <svg className="user-icon" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2">
          <path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"></path>
          <circle cx="12" cy="7" r="4"></circle>
        </svg>
        <span>{customer.addedBy}</span>
      </div>
    </div>
  );
};

export default CustomerCard;
EOF

# --- File: src/components/CustomerCard/CustomerCard.css ---
echo "🎨 Creating src/components/CustomerCard/CustomerCard.css..."
cat << 'EOF' > src/components/CustomerCard/CustomerCard.css
.customer-card {
  display: grid;
  grid-template-columns: 40px 300px 60px 250px 220px 1fr;
  padding: 16px;
  border-bottom: 1px solid #f3f4f6;
  align-items: center;
  transition: background-color 0.2s;
}

.customer-card:hover {
  background-color: #f9fafb;
}

.customer-card:last-child {
  border-bottom: none;
}

.customer-checkbox {
  width: 18px;
  height: 18px;
  cursor: pointer;
  accent-color: #10b981;
}

.customer-info {
  display: flex;
  align-items: center;
  gap: 12px;
}

.customer-avatar {
  width: 40px;
  height: 40px;
  border-radius: 50%;
  object-fit: cover;
}

.customer-details {
  display: flex;
  flex-direction: column;
  gap: 4px;
}

.customer-name {
  font-size: 14px;
  font-weight: 500;
  color: #111827;
}

.customer-phone {
  font-size: 12px;
  color: #6b7280;
}

.customer-count,
.customer-email,
.customer-date {
  font-size: 14px;
  color: #374151;
  font-weight: 500;
}

.customer-added-by {
  display: flex;
  align-items: center;
  gap: 6px;
  font-size: 14px;
  color: #374151;
}

.user-icon {
  color: #6b7280;
}
EOF

# --- File: src/App.jsx ---
echo "✅ Creating src/App.jsx..."
cat << 'EOF' > src/App.jsx
import React, { useState, useMemo } from 'react';
import { generateMockCustomers } from './data/mockData';
import Header from './components/Header/Header';
import SearchBar from './components/SearchBar/SearchBar';
import FilterDropdown from './components/FilterDropdown/FilterDropdown';
import TableHeader from './components/TableHeader/TableHeader';
import CustomerCard from './components/CustomerCard/CustomerCard';
import './App.css';

const App = () => {
  const [customers] = useState(generateMockCustomers());
  const [searchTerm, setSearchTerm] = useState('');
  const [selectedCustomers, setSelectedCustomers] = useState([]);
  const [isFilterOpen, setIsFilterOpen] = useState(false);

  const filters = ['Filter by Name', 'Filter by Date', 'Filter by Count'];

  const handleSelectCustomer = (id) => {
    setSelectedCustomers(prev =>
      prev.includes(id)
        ? prev.filter(custId => custId !== id)
        : [...prev, id]
    );
  };

  const filteredCustomers = useMemo(() => {
    if (!searchTerm) return customers;
    return customers.filter(customer =>
      customer.name.toLowerCase().includes(searchTerm.toLowerCase()) ||
      customer.phone.includes(searchTerm) ||
      customer.email.toLowerCase().includes(searchTerm.toLowerCase())
    );
  }, [customers, searchTerm]);

  return (
    <div className="app-container">
      <Header />

      <main className="content">
        <div className="title-section">
          <h2 className="page-title">All Customers</h2>
          <span className="customer-count-badge">{customers.length}</span>
        </div>

        <div className="toolbar">
          <SearchBar value={searchTerm} onChange={setSearchTerm} />
          <FilterDropdown
            isOpen={isFilterOpen}
            onToggle={() => setIsFilterOpen(!isFilterOpen)}
            filters={filters}
            onFilterSelect={(filter) => {
              console.log('Selected filter:', filter);
              setIsFilterOpen(false);
            }}
          />
        </div>

        <div className="table-container">
          <TableHeader />
          <div className="customer-list">
            {filteredCustomers.map(customer => (
              <CustomerCard
                key={customer.id}
                customer={customer}
                isSelected={selectedCustomers.includes(customer.id)}
                onSelect={handleSelectCustomer}
              />
            ))}
          </div>
        </div>
      </main>
    </div>
  );
};

export default App;
EOF   

echo ""
echo "✅✅✅ Project setup complete! ✅✅✅"
echo ""
echo "Next steps:"
echo "1. Install dependencies:"
echo "   npm install @faker-js/faker"
echo "2. Run the development server:"
echo "   npm run dev"
echo ""