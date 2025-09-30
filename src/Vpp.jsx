
import React, { useCallback, useMemo, useRef, useState } from "react";

// Memoized child for list items
const VppList = React.memo(({ items, onSelect }) => {
    console.log("VppList rendered");
    return (
        <ul>
            {items.map((item) => {
                console.log("Render item:", item.name);
                return (
                    <li key={item.id}>
                        {item.name} <button onClick={() => onSelect(item.id)}>Select</button>
                    </li>
                );
            })}
        </ul>
    );
});

export default function Vpp() {
    const [items, setItems] = useState([
        { id: 1, name: "🍎 Apple" },
        { id: 2, name: "🍌 Banana" },
        { id: 3, name: "🍒 Cherry" },
    ]);

    const [selectedId, setSelectedId] = useState(null);

    // useRef → keep button reference
    const shuffleBtnRef = useRef(null);

    // useCallback → memoize shuffle function
    const shuffle = useCallback(() => {
        setItems((prev) => [...prev].reverse());
    }, []);

    // useCallback → memoize select function
    const handleSelect = useCallback((id) => {
        setSelectedId(id);
    }, []);

    // useMemo → memoize sorted items (example)
    const sortedItems = useMemo(() => {
        console.log("Sorting items...");
        return [...items].sort((a, b) => a.name.localeCompare(b.name));
    }, [items]);

    return (
        <div>
            <h2>Vpp Component with Hooks</h2>
            <VppList items={sortedItems} onSelect={handleSelect} />
            <button ref={shuffleBtnRef} onClick={shuffle}>
                Shuffle
            </button>
            {selectedId && <p>Selected Item ID: {selectedId}</p>}
        </div>
    );
}
