import './FilterDropdown.css';

const FilterDropdown = ({ isOpen, onToggle, filters, onFilterSelect }) => {
  return (
    <div className="filter-container">
      <button className="filter-button" onClick={onToggle}>

        <img src="public\test_Filter.svg" alt="Filter Icon" className="filter-icon" />
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
