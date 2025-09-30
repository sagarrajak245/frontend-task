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
