# DoubleTick Customer List App

A performant React app for displaying, searching, filtering, and sorting a large list of customers with virtualization and infinite loading.

---
## Example Screenshots

<img width="1845" height="825" alt="image" src="https://github.com/user-attachments/assets/bc94a383-496c-457f-a415-9cdbe135f6d4" />



## Features

- **Virtualized List:** Efficiently renders up to 1,000,000 customers using [`react-window`](https://github.com/bvaughn/react-window).
- **Infinite Loading:** Loads customer data in batches as you scroll, using a mock API and cache.
- **Search & Sort:** Instantly filter and sort customers by name, email, or added by.
- **Custom Avatars:** Uses Unsplash images for customer avatars.
- **Responsive UI:** Styled with CSS Grid and Flexbox for a clean, modern look.
- **Filter Dropdown:** UI for adding filters (demo only).
- **Selection:** Checkbox for selecting customers (UI only).

---



## Folder Structure

```
src/
  components/
    CustomerCard/
      CustomerCard.jsx
      CustomerCard.css
    TableHeader/
      TableHeader.jsx
      TableHeader.css
  data/
    CustomerData.js
  page/
    CustomersList.jsx
  App.jsx
  index.js
public/
  (static assets)
```

---

## How It Works

- **Data Generation:**  
  Uses [`@faker-js/faker`](https://github.com/faker-js/faker) to generate realistic customer data on the fly.
- **Virtualization:**  
  Only renders visible rows using `react-window` for performance.
- **Infinite Loading:**  
  `fetchCustomers(startIndex, stopIndex)` simulates an API call and caches results.
- **UI Components:**  
  - `TableHeader`: Renders the table header with grid alignment.
  - `CustomerCard`: Renders each customer row with avatar, details, and added by icon.
- **Search & Sort:**  
  Controlled input and dropdown for filtering and sorting the customer list.
- **Styling:**  
  Custom CSS for grid layout, hover effects, and responsive design.

---

## Getting Started

### 1. Clone the Repository

```sh
git clone <your-repo-url>
cd my-app
```

### 2. Install Dependencies

```sh
npm install
npm install @faker-js/faker react-window react-window-infinite-loader react-icons
```

### 3. Run the App

```sh
npm start
```
or (if using Vite)
```sh
npm run dev
```

### 4. Open in Browser

Visit [http://localhost:3000](http://localhost:3000) (or the port shown in your terminal).

---

## Customization

- **Avatars:**  
  Change the Unsplash image URL in `CustomerData.js` for different avatars.
- **Batch Size:**  
  Adjust `BATCH_SIZE` in `CustomerData.js` for faster/slower loading.
- **Filters:**  
  Extend filter dropdown logic in `CustomersList.jsx` for real filtering.

---



---

## Credits

- [React](https://react.dev/)
- [react-window](https://github.com/bvaughn/react-window)
- [@faker-js/faker](https://github.com/faker-js/faker)
- [Unsplash](https://unsplash.com/) (for avatars)
- [Icons8](https://icons8.com/icons/set/user) (for user icons)

---

## License

MIT
