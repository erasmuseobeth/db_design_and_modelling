CREATE TABLE `orders` (
  `id` int PRIMARY KEY,
  `user_id` int UNIQUE NOT NULL,
  `status` varchar(255),
  `created_at` varchar(255)
);

CREATE TABLE `order_items` (
  `order_id` int,
  `product_id` int,
  `quantity` int
);

CREATE TABLE `products` (
  `id` int PRIMARY KEY,
  `name` varchar(255),
  `merchant_id` int NOT NULL,
  `price` int,
  `status` varchar(255),
  `created_at` varchar(255),
  `category_id` int
);

CREATE TABLE `users` (
  `id` int PRIMARY KEY,
  `full_name` varchar(255),
  `email` varchar(255) UNIQUE,
  `gender` varchar(255),
  `date_of_birth` varchar(255),
  `created_at` varchar(255),
  `country_code` int
);

CREATE TABLE `merchants` (
  `id` int PRIMARY KEY,
  `admin_id` int,
  `merchant_name` varchar(255),
  `country_code` int,
  `created_at` varchar(255)
);

CREATE TABLE `categories` (
  `id` int PRIMARY KEY,
  `cat_name` varchar(255),
  `parent_id` int
);

CREATE TABLE `countries` (
  `code` int PRIMARY KEY,
  `name` varchar(255),
  `continent_name` varchar(255)
);

ALTER TABLE `orders` ADD FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

ALTER TABLE `order_items` ADD FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`);

ALTER TABLE `order_items` ADD FOREIGN KEY (`product_id`) REFERENCES `products` (`id`);

ALTER TABLE `products` ADD FOREIGN KEY (`merchant_id`) REFERENCES `merchants` (`id`);

ALTER TABLE `products` ADD FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`);

ALTER TABLE `categories` ADD FOREIGN KEY (`parent_id`) REFERENCES `categories` (`id`);

ALTER TABLE `users` ADD FOREIGN KEY (`country_code`) REFERENCES `countries` (`code`);

ALTER TABLE `merchants` ADD FOREIGN KEY (`admin_id`) REFERENCES `users` (`id`);

ALTER TABLE `merchants` ADD FOREIGN KEY (`country_code`) REFERENCES `countries` (`code`);
