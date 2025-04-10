# 🔎 Helpjuice Realtime Search Analytics App

A real-time search and analytics application built with **Ruby on Rails** and **Vanilla JavaScript**, designed to demonstrate your ability to handle live user inputs, track analytics, and build scalable full-stack solutions.

This app captures user search queries in real time, stores only meaningful (finalized) searches per user, and displays insightful analytics about the most common searches across all users. It provides a seamless, fast, and intuitive user experience with a clean UI and solid backend performance.

---

## 🚀 Live Demo

👉 [Live Demo (Coming Soon)](https://your-demo-link.com)

---

## 📚 Features

- **Rails Full-Stack App**: Built using Rails for both frontend and backend logic.
- **PostgreSQL Database**: For robust data storage and performance.
- **Real-Time Search**: As users type, matching articles are displayed instantly.
- **Smart Query Filtering**: Stores only the final (complete) version of a user’s search — avoids the “pyramid problem”.
- **User Tracking via Cookies**: Each user’s search history is isolated using browser cookies (no login system required).
- **Analytics Dashboard**: Aggregates and ranks the most searched terms across all users.
- **Responsive Navigation**: Easily switch between Home, History, and Analytics pages using a shared navigation bar.
- **Scalable Design**: Engineered to handle thousands of requests per hour.
- **Clean UI & UX**: Minimalist interface with fast interactions.

---

## 🧽 Pages

### 🏠 Home

- Real-time search input field
- Instant display of matching articles (based on title or content)
- Logs completed queries to database

### 🕒 History

- Shows a personal table of past search queries
- Data is filtered by user using a persistent cookie

### 📊 Analytics

- Displays top searches across **all users**
- Ranks based on search frequency

---

## 🛠️ Installation & Setup

To run the app locally, follow these steps:

1. **Clone the repository**

```bash
git clone https://github.com/your-username/helpjuice-search-analytics.git
cd helpjuice-search-analytics
```

2. **Install dependencies**

Make sure you have Ruby, Rails, and PostgreSQL installed.

```bash
bundle install
```

3. **Set up the database**

```bash
rails db:create
rails db:migrate
rails db:seed
```

4. **Run the app**

```bash
rails server
```

Then visit: `http://localhost:3000`

---


## ⚙️ Technical Notes

- **No Devise**: User tracking is handled via `cookies`, not a user model or login system.
- **Smart Filtering Logic**: Only the **most complete query** is stored for each session — intermediate fragments are ignored.
- **Vanilla JS**: Used for real-time frontend search behavior (no frontend frameworks).
- **Rails Controllers**: Handle storing, filtering, and retrieving searches based on the cookie-assigned user ID.

---

## 📈 Scalability

The app is designed to scale for high search volumes:
- Optimized database queries
- Debounced input handling on the frontend


