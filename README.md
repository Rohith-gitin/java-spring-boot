# ShopEase — Spring Boot + JSP + PostgreSQL E-Commerce

A beginner-friendly, runnable e-commerce starter project using Java, Spring Boot MVC, JSP/JSTL, Spring Data JPA, and PostgreSQL.

## Features
- Product catalogue and product detail page
- Session-based shopping cart (add, update, remove)
- Checkout form and order persistence
- Inventory stock validation and stock reduction after checkout
- Basic product management (create, edit, delete)
- Demo products inserted automatically when the product table is empty
- Responsive Bootstrap interface

> This is an educational starter project. It does not include user accounts, admin authentication, a payment gateway, tax/shipping calculations, or production security hardening. The product-management URLs are open in this demo; secure them before deployment.

## Requirements
- JDK 17 or newer (JDK 17 or 21 recommended)
- PostgreSQL 14 or newer
- IntelliJ IDEA or VS Code (optional)
- Maven 3.8+ **or** use the included Maven Wrapper if you add one. This ZIP does not bundle Maven itself.

## 1. Create the database
Start PostgreSQL, then open pgAdmin Query Tool or `psql` and execute:

```sql
CREATE DATABASE ecommerce_db;
```

The default connection settings are:
- Database: `ecommerce_db`
- Username: `postgres`
- Password: `postgres`
- URL: `jdbc:postgresql://localhost:5432/ecommerce_db`

If your PostgreSQL password is different, edit `src/main/resources/application.properties` and change `spring.datasource.password`, or set environment variables:

Windows PowerShell:
```powershell
$env:DB_URL="jdbc:postgresql://localhost:5432/ecommerce_db"
$env:DB_USERNAME="postgres"
$env:DB_PASSWORD="YOUR_POSTGRES_PASSWORD"
```

## 2. Run from a terminal
Install Maven if `mvn -v` is not recognized. Confirm Java and Maven are available:

```bash
java -version
mvn -v
```

Open a terminal in the folder containing `pom.xml`, then run:

```bash
mvn clean spring-boot:run
```

Wait for a log line similar to `Started EcommerceApplication`. Open:

**http://localhost:8080/**

## 3. Run in IntelliJ IDEA
1. Extract the ZIP file to a normal folder (not inside the ZIP preview).
2. Open IntelliJ IDEA → **File → Open** → select the extracted project folder containing `pom.xml`.
3. If prompted, choose **Open as Project** and allow Maven dependencies to download. If the Maven tool window is missing, right-click `pom.xml` → **Add as Maven Project**.
4. Set Project SDK to JDK 17 or 21: **File → Project Structure → Project**.
5. Open `EcommerceApplication.java` and click the green Run icon beside `main`.
6. Wait for the application to start, then visit `http://localhost:8080/`.

## 4. Pages
- Shop: `/`
- Cart: `/cart`
- Checkout: `/checkout`
- Product details: `/products/{id}`
- Product management: `/admin/products`

## 5. MVC architecture
- **Model:** `Product`, `CustomerOrder`, and `CartItem` hold application data.
- **View:** JSP files under `src/main/webapp/WEB-INF/jsp/` render HTML.
- **Controller:** `StoreController` handles browser requests and chooses JSP views.
- **Service:** `ProductService` contains product operations.
- **Repository:** Spring Data JPA repositories read and write PostgreSQL data.

## Troubleshooting
- **Connection refused / database connection error:** Ensure the PostgreSQL service is running, the database exists, and username/password are correct.
- **Password authentication failed:** Update `spring.datasource.password` or the environment variables.
- **Port 8080 already in use:** Change `server.port=8081` in `application.properties` and open `http://localhost:8081/`.
- **Maven is not recognized:** Install Apache Maven and add its `bin` directory to PATH, then restart the terminal/IDE.
- **JSP page returns 404:** Run with the provided Maven configuration and keep `packaging` set to `war`; JSPs must remain under `src/main/webapp/WEB-INF/jsp/`.
- **Images don't load:** The sample images are remote URLs and require internet access. Product pages still work without them.

## Database tables
Hibernate creates `products` and `customer_orders` automatically when the application starts (`spring.jpa.hibernate.ddl-auto=update`). Do not use this setting as a production migration strategy.
