
import { useCallback, useMemo, useRef, useState } from 'react';
import { List } from 'react-window';
import './App.css';
import CustomerCard from './components/CustomerCard/CustomerCard';
import FilterDropdown from './components/FilterDropdown/FilterDropdown';
import Header from './components/Header/Header';
import SearchBar from './components/SearchBar/SearchBar';
import TableHeader from './components/TableHeader/TableHeader';
import { fetchCustomers, TOTAL_RECORDS } from './data/CustomerData';

const App = () => {
  const [items, setItems] = useState([]);
  const [searchTerm, setSearchTerm] = useState('');
  const [selectedCustomers, setSelectedCustomers] = useState(new Set());
  const [isFilterOpen, setIsFilterOpen] = useState(false);
  const loadingRef = useRef(new Set());
  const filters = ['Filter 1', 'Filter 2', 'Filter 3'];


  const filteredItems = useMemo(() => {
    if (!searchTerm.trim()) {
      return items;
    }

    const lowerSearch = searchTerm.toLowerCase();
    return items.filter(item => {
      if (!item) return false;

      return (
        item.name?.toLowerCase().includes(lowerSearch) ||
        item.email?.toLowerCase().includes(lowerSearch) ||
        item.phone?.toLowerCase().includes(lowerSearch) ||
        item.addedBy?.toLowerCase().includes(lowerSearch)
      );
    });
  }, [items, searchTerm]);

  // Get the actual count of filtered items
  const displayCount = searchTerm.trim() ? filteredItems.length : TOTAL_RECORDS;

  const loadMoreItems = useCallback(async (startIndex, stopIndex) => {
    const key = `${startIndex}-${stopIndex}`;

    if (loadingRef.current.has(key)) return;
    loadingRef.current.add(key);

    try {
      const batch = await fetchCustomers(startIndex, stopIndex);

      setItems((prev) => {
        const newItems = [...prev];
        batch.forEach((item, i) => {
          newItems[startIndex + i] = item;
        });
        return newItems;
      });
    } catch (error) {
      console.error('Failed to load items:', error);
    } finally {
      loadingRef.current.delete(key);
    }
  }, []);

  const handleRowsRendered = useCallback((visibleRows, allRows) => {
    // Only load more if we're not searching
    if (searchTerm.trim()) return;

    const { startIndex, stopIndex } = allRows;

    let needsLoading = false;
    for (let i = startIndex; i <= stopIndex; i++) {
      if (!items[i]) {
        needsLoading = true;
        break;
      }
    }

    if (needsLoading) {
      loadMoreItems(startIndex, stopIndex);
    }
  }, [items, loadMoreItems, searchTerm]);

  const handleSelectCustomer = (id) => {
    setSelectedCustomers(prev => {
      const newSelection = new Set(prev);
      if (newSelection.has(id)) {
        newSelection.delete(id);
      } else {
        newSelection.add(id);
      }
      return newSelection;
    });
  };

  return (
    <div className="app-container">
      <Header />
      <main className="content">
        <div className="title-section">
          <h2 className="page-title">All Customers</h2>
          <span className="customer-count-badge">{displayCount.toLocaleString()}</span>
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
            {searchTerm.trim() ? (

              <div className="search-results">
                {filteredItems.length > 0 ? (
                  filteredItems.map((customer, index) => (
                    <CustomerCard
                      key={customer.id}
                      index={index}
                      style={{}}
                      items={filteredItems}
                      selectedCustomers={selectedCustomers}
                      onSelect={handleSelectCustomer}
                    />
                  ))
                ) : (
                  <div className="no-results">
                    <p>No customers found matching "{searchTerm}"</p>
                  </div>
                )}
              </div>
            ) : (
              <List
                rowComponent={CustomerCard}
                rowCount={TOTAL_RECORDS}
                rowHeight={74}
                rowProps={{
                  items,
                  selectedCustomers,
                  onSelect: handleSelectCustomer
                }}
                onRowsRendered={handleRowsRendered}
                overscanCount={15}
                style={{ height: '600px', width: '100%' }}
              />
            )}
          </div>
        </div>
      </main>
    </div>
  );
};

export default App; 