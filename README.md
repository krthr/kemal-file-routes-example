# Kemal File Routes Example

A proof-of-concept Crystal application demonstrating file-based server routing with [Kemal](https://kemalcr.com/), inspired by [Nitro.js](https://nitro.unjs.io/)'s file routing system.

## 🎯 Overview

This project showcases the [`kemal-file-routes`](http://github.com/krthr/kemal-file-routes) shard, a work-in-progress library that brings file-based routing to Crystal web applications using the Kemal framework. Similar to how Nitro.js and other modern frameworks handle routing, this approach allows you to define routes simply by creating files in a specific directory structure.

## 🚀 Features

- **File-based routing**: Define routes by creating files in the `src/routes` directory
- **Convention over configuration**: File names determine HTTP methods and paths
- **Dynamic route parameters**: Support for parameterized routes using bracket notation
- **Zero route configuration**: Routes are automatically discovered and registered
- **Clean separation**: Each route handler lives in its own file

## 📁 Project Structure

```
src/
├── app-test.cr           # Main application entry point
├── database/
│   ├── data.cr          # Database module
│   └── data.json        # Sample data
└── routes/              # File-based routes directory
    ├── index.get.cr     # GET /
    ├── users.get.cr     # GET /users
    └── users/
        └── [id].get.cr  # GET /users/:id
```

## 🛠️ How It Works

The `kemal-file-routes` shard automatically scans the `src/routes` directory and registers routes based on file naming conventions:

### File Naming Convention

- **`index.get.cr`** → `GET /`
- **`users.get.cr`** → `GET /users`
- **`users/[id].get.cr`** → `GET /users/:id`

### Route Definition

Each route file uses the `define_handler` macro to define the route logic:

```crystal
# src/routes/users.get.cr
define_handler do |env|
  Database.list.to_json
end
```

For parameterized routes:

```crystal
# src/routes/users/[id].get.cr
define_handler do |env|
  id = env.params.url["id"]
  user = Database.get(id)
  
  halt(env, status_code: 404, response: "Not Found") if user.nil?
  
  user.to_json
end
```

## 📦 Installation

1. Install Crystal (>= 1.17.1)
2. Clone this repository:
   ```bash
   git clone https://github.com/krthr/kemal-file-routes-example.git
   cd kemal-file-routes-example
   ```
3. Install dependencies:
   ```bash
   shards install
   ```

## 🏃 Usage

### Development

Run the development server:

```bash
crystal run src/app-test.cr
```

The server will start on `http://localhost:3000`

### Building

Build the application:

```bash
crystal build src/app-test.cr --release
./app-test
```

### Testing

Run the test suite:

```bash
crystal spec
```

### Formatting

Format the code:

```bash
bb format
```

Run tests after formatting:

```bash
bb && bb test
```

## 🔌 API Endpoints

| Method | Path         | Description          |
|--------|-------------|----------------------|
| GET    | `/`         | Returns current time |
| GET    | `/users`    | List all users       |
| GET    | `/users/:id`| Get user by ID       |

## 🚧 Work in Progress

This is a proof-of-concept implementation. The `kemal-file-routes` shard is still under development and may have limitations:

- Currently supports basic HTTP methods (GET, POST, PUT, DELETE)
- Route discovery happens at compile time
- No support for nested dynamic parameters yet

## 🤝 Contributing

1. Fork it (<https://github.com/krthr/kemal-file-routes-example/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## 📚 Related Projects

- [kemal-file-routes](https://github.com/krthr/kemal-file-routes) - The shard that powers this example
- [Kemal](https://kemalcr.com/) - Fast, Effective, Simple web framework for Crystal
- [Nitro.js](https://nitro.unjs.io/) - The inspiration for this file-based routing approach

## 📄 License

MIT

## 👥 Contributors

- [Wilson Tovar](https://github.com/krthr) - creator and maintainer
