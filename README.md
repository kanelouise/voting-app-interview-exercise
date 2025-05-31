# Voting App – ActBlue Interview Exercise

This is a completed version of the Rails + React Voting App exercise. Users can register, log in, vote for a candidate (or write one in), and view a live results dashboard. The app is designed to be simple, functional, and clear.

---

## Installation

Your development environment should have:

* Ruby v3.1.2
* [Bundler](https://bundler.io/)
* Node v20.18.2
* Yarn v1.22.19
* git
* [SQLite3](https://www.sqlite.org/)

Initialize the app:

```sh
# Clone this repo

# Install backend dependencies
bundle install
bundle exec rake db:setup

# Install JS packages, including React
yarn install
```

---

## Running the app

```sh
# Start Rails server
bundle exec rails server

# For asset reloading run:
./bin/shakapacker-dev-server
```

Then open [http://localhost:3000](http://localhost:3000) in your browser.

If the assets ever get out of sync, delete \`/public/packs\` and restart your

Rails server (and your shakapacker-dev-server if it was running).

---

## Project Overview

* **Frontend:** React
* **Backend:** Rails API
* **Auth:** Session-based login with cookie storage
* **Database:** SQLite (local dev)

### Features:

* Login + session management
* Candidate listing
* Vote submission with write-in support, with confirmation or error message of vote result
* Results Dashboard accessible without login
* Redirect users to Results Dashboard after vote attempt (whether or not vote was successful)

---

## Thought Process

This app prioritizes:

* **Clarity:** Clean, minimal UI and simple navigation
* **Functionality:** Covers all core requirements and one bonus (write-in candidates)
* **Maintainability:** Logical folder structure and reusable React components

The goal was to showcase strong Rails and React integration, clean controller design, and clear user flows rather than advanced styling or edge case testing.

---

## Important Structure + Files

* Following the MVC structure
* `app/models` - Backbone for CRUD (`Candidate`, `Vote`, `Voter` )
* `app/controllers/api/` – Namespaced Rails API controllers (`candidate`, `vote`, `voter`, `results`, `sessions`)
* `app/javascript/components/` – React components (`Login`, `Vote`, `ResultsDashboard`)
* `routes.rb` – API and frontend routing configuration

## Opportunities for further building

**Testing**
With more time, high-value tests would include:
[ ] Authentication flow tests (login success/failure)
[ ] Vote submission (with and without write-in)
[ ] Candidate listing and results aggregation

**Styling**
[ ] Make it pretty with tailwindcss

**Error handling**
[ ] Rely on rails logic for more robust error handing especially when it comes to missing required fields

**Candidate name normalizations**
[ ] Implement fuzzy matching/name normalization logic to account for typos and accents

**Deploying**
[ ] Solve failed build without credentials to deploy app on Render or Railway

