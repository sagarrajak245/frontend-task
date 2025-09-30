// src/data.js
import { faker } from '@faker-js/faker';

export const TOTAL_RECORDS = 1000000;
export const BATCH_SIZE = 100;

// Generate all customers at once (for the simple version)
// For production, you'd want lazy loading with the fetchCustomers function
export function generateCustomers(count = 100000) {
    console.log(`Generating ${count} customers...`);
    const customers = [];

    for (let i = 0; i < count; i++) {
        customers.push({
            id: i + 1,
            name: faker.person.fullName(),
            email: faker.internet.email(),
            phone: faker.phone.number(),
            lastMessage: faker.date.recent().toLocaleString(),
            addedBy: faker.person.fullName(),
        });
    }

    console.log(`Generated ${customers.length} customers`);
    return customers;
}

// Async function to fetch customers in batches (for lazy loading)
export function fetchCustomers(startIndex) {
    return new Promise((resolve) => {
        setTimeout(() => {
            const batch = Array.from({ length: BATCH_SIZE }).map((_, i) => {
                const id = startIndex + i + 1;
                return {
                    id,
                    name: faker.person.fullName(),
                    email: faker.internet.email(),
                    phone: faker.phone.number(),
                    lastMessage: faker.date.recent().toLocaleString(),
                    addedBy: faker.person.fullName(),
                };
            });
            resolve(batch);
        }, 500); // simulate network delay
    });
}