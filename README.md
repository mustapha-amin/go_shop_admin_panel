# Go Shop Admin Panel

A Flutter-based admin panel for managing an e-commerce platform. This admin panel provides comprehensive tools for managing products, orders, and customers.

Client app: https://github.com/mustapha-amin/go_shop.git

## Features

### Dashboard
- Real-time overview of business metrics
- Total income tracking
- Customer count monitoring
- Growth percentage indicators

### Product Management
- Complete product inventory management
- Category-based product filtering
- Product count per category
- Product details including:
  - Name and description
  - Base price and discount percentage
  - Stock quantity
  - Brand information
  - Multiple product images
- Product categories:
  - Appliances
  - Phones and tablets
  - Electronics
  - Computing
  - Clothing
  - Other

### Order Management
- Comprehensive order tracking
- Order details including:
  - Customer information
  - Product details
  - Order status
  - Total amount
  - Order date
- Status indicators for orders (pending, completed, cancelled)
- Expandable order cards for detailed view

### Customer Management
- Customer information tracking
- Contact details management
- Order history per customer

## Technical Features
- Built with Flutter for cross-platform compatibility
- State management using Riverpod
- Firebase integration for:
  - Real-time data updates
  - Image storage
  - User authentication
- Responsive design
- Modern UI components using shadcn_ui

## Getting Started

### Prerequisites
- Flutter SDK
- Firebase account
- Dart SDK

### Installation
1. Clone the repository
```bash
git clone https://github.com/yourusername/go_shop_admin_panel.git
```

2. Install dependencies
```bash
flutter pub get
```

3. Configure Firebase
- Add your Firebase configuration files
- Enable necessary Firebase services (Firestore, Storage)

4. Run the application
```bash
flutter run
```

## Project Structure
```
lib/
├── consts/              # Constants and configurations
├── core/               # Core functionality and providers
├── features/           # Feature-based modules
│   ├── home/          # Dashboard
│   ├── orders/        # Order management
│   ├── products/      # Product management
│   └── customers/     # Customer management
├── model/             # Data models
└── main.dart          # Application entry point
```



https://github.com/user-attachments/assets/ef231e1b-0f35-4c73-aa32-567aa4c36cbe

