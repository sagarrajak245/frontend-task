// src/page/CustomersList.jsx
import { useMemo, useState } from "react";

import { FixedSizeList } from "react-window";
import { generateCustomers } from "./CustomerData";
import "./CustomersList.css"; // optional custom styles 

// Generate data once
const customers = generateCustomers();
console.log("Generated customers:", customers.slice(0, 5)); // Log first 5 customers for verification 

function CustomerRow({ index, style, data }) {
    const customer = data[index];
    return (
        <div style={style} className="customer-row">
            <span>{customer.name}</span>
            <span>{customer.phone}</span>
            <span>{customer.email}</span>
            <span>{customer.lastMessage}</span>
            <span>{customer.addedBy}</span>
        </div>
    );
}

export default function CustomersList() {
    const [search, setSearch] = useState("");
    const [sortField, setSortField] = useState("name");

    // Filtering + sorting
    const filtered = useMemo(() => {
        return customers
            .filter(
                (c) =>
                    c.name.toLowerCase().includes(search.toLowerCase()) ||
                    c.email.toLowerCase().includes(search.toLowerCase())
            )
            .sort((a, b) => {
                const valA = a[sortField] ?? "";
                const valB = b[sortField] ?? "";
                return valA.toString().localeCompare(valB.toString());
            });
    }, [search, sortField]);


    return (
        <div>
            <h1>Customers List</h1>

            <div className="controls">
                <input
                    type="text"
                    placeholder="Search Customers"
                    value={search}
                    onChange={(e) => setSearch(e.target.value)}
                />

                <select onChange={(e) => setSortField(e.target.value)} value={sortField}>
                    <option value="name">Name</option>
                    <option value="email">Email</option>
                    <option value="addedBy">Added By</option>
                </select>

                <button onClick={() => alert("Dummy filters here!")}>Add Filters</button>
            </div>

            <FixedSizeList
                height={600}
                itemCount={filtered.length}
                itemSize={40}
                width={"100%"}
                itemData={filtered}
            >
                {CustomerRow}
            </FixedSizeList>
        </div>
    );
}
