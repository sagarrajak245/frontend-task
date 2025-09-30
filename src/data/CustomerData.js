
import { faker } from '@faker-js/faker';

export const TOTAL_RECORDS = 1000000;
const BATCH_SIZE = 50;


const customerCache = {};

const generateCustomer = (index) => {
    if (customerCache[index]) {
        return customerCache[index];
    }

    const firstName = faker.person.firstName();
    const lastName = faker.person.lastName();
    const name = `${firstName} ${lastName}`;

    const customer = {
        id: faker.string.uuid(),
        name: name,
        phone: faker.phone.number(),
        email: faker.internet.email({ firstName, lastName }),
        messageCount: faker.number.int({ min: 1, max: 99 }),
        lastMessageDate: faker.date.recent().toLocaleDateString('en-US', {
            month: 'long',
            day: 'numeric',
            year: 'numeric',
        }),
        addedBy: faker.person.fullName(),
        // Using the random Unsplash URL format you provided
        avatar: `https://source.unsplash.com/random/40x40?sig=${index}&face`,
    };

    customerCache[index] = customer;
    return customer;
};


export const fetchCustomers = (startIndex, stopIndex) => {
    console.log(`Fetching records from ${startIndex} to ${stopIndex}`);
    return new Promise((resolve) => {

        setTimeout(() => {
            const batch = [];
            for (let i = startIndex; i <= stopIndex; i++) {
                batch.push(generateCustomer(i));
            }
            resolve(batch);
        }, 300);
    });
};      