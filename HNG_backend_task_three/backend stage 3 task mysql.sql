CREATE TABLE `users` (
  `id` uuid PRIMARY KEY COMMENT 'Unique identifier for users',
  `first_name` varchar(255) NOT NULL,
  `last_name` varchar(255) NOT NULL,
  `username` varchar(255) UNIQUE NOT NULL COMMENT 'Username for login',
  `email` varchar(255) UNIQUE NOT NULL COMMENT 'Email address',
  `password` varchar(255) NOT NULL COMMENT 'Hashed password',
  `status` ENUM ('active', 'inactive') NOT NULL DEFAULT 'active' COMMENT 'User status',
  `language` varchar(10),
  `region` varchar(10),
  `magic_link_token` varchar(255),
  `social_auth_provider` varchar(255),
  `gdpr_cookies_consent` boolean COMMENT 'GDPR consent status',
  `settings` json COMMENT 'User-specific settings',
  `created_at` timestamp DEFAULT (now()) COMMENT 'Timestamp when user account was created',
  `updated_at` timestamp DEFAULT (now()) COMMENT 'Timestamp when user account was last updated',
  `last_login` timestamp COMMENT 'Timestamp of last login'
);

CREATE TABLE `sessions` (
  `id` int PRIMARY KEY AUTO_INCREMENT COMMENT 'Session identifier',
  `user_id` uuid COMMENT 'Associated user',
  `token` varchar(255) NOT NULL COMMENT 'Session token',
  `expires_at` timestamp NOT NULL COMMENT 'Session expiration timestamp'
);

CREATE TABLE `password_resets` (
  `id` int PRIMARY KEY AUTO_INCREMENT COMMENT 'Password reset identifier',
  `user_id` uuid COMMENT 'User requesting password reset',
  `token` varchar(255) NOT NULL COMMENT 'Reset token',
  `expires_at` timestamp NOT NULL COMMENT 'Token expiration timestamp'
);

CREATE TABLE `roles` (
  `id` uuid PRIMARY KEY DEFAULT (uuid_generate_v4()) COMMENT 'Role identifier',
  `name` varchar(255) UNIQUE NOT NULL COMMENT 'Role name',
  `description` text COMMENT 'Role description'
);

CREATE TABLE `user_roles` (
  `user_id` uuid COMMENT 'User assigned to role',
  `role_id` uuid COMMENT 'Assigned role',
  `created_at` timestamp DEFAULT (now()) COMMENT 'Assignment timestamp',
  `updated_at` timestamp DEFAULT (now()) COMMENT 'Last update timestamp',
  PRIMARY KEY (`user_id`, `role_id`)
);

CREATE TABLE `organisations` (
  `id` uuid PRIMARY KEY DEFAULT (uuid_generate_v4()) COMMENT 'Organisation identifier',
  `name` varchar(255) NOT NULL COMMENT 'Organisation name',
  `description` text COMMENT 'Organisation description',
  `settings` json COMMENT 'Organisation-specific settings',
  `created_at` timestamp DEFAULT (now()) COMMENT 'Timestamp when organisation was created',
  `updated_at` timestamp DEFAULT (now()) COMMENT 'Timestamp when organisation was last updated'
);

CREATE TABLE `organisation_users` (
  `user_id` uuid COMMENT 'User associated with organisation',
  `organisation_id` uuid COMMENT 'Organisation user belongs to',
  `role_id` uuid COMMENT 'Role within the organisation',
  `created_at` timestamp DEFAULT (now()) COMMENT 'Timestamp when user joined organisation',
  `updated_at` timestamp DEFAULT (now()) COMMENT 'Timestamp of last update',
  PRIMARY KEY (`user_id`, `organisation_id`)
);

CREATE TABLE `emails` (
  `id` int PRIMARY KEY AUTO_INCREMENT COMMENT 'Email identifier',
  `sender_id` uuid COMMENT 'Sender of the email',
  `recipient_email` varchar(255) NOT NULL COMMENT 'Recipient email address',
  `subject` varchar(255),
  `body` text,
  `sent_timestamp` timestamp NOT NULL COMMENT 'Timestamp when email was sent'
);

CREATE TABLE `email_templates` (
  `id` int PRIMARY KEY AUTO_INCREMENT COMMENT 'Email template identifier',
  `template_name` varchar(255) UNIQUE NOT NULL COMMENT 'Name of the email template',
  `subject` varchar(255),
  `body` text,
  `created_at` timestamp DEFAULT (now()) COMMENT 'Timestamp when template was created',
  `updated_at` timestamp DEFAULT (now()) COMMENT 'Timestamp of last update'
);

CREATE TABLE `waitlist` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `email` varchar(255) UNIQUE NOT NULL,
  `signup_time` timestamp NOT NULL
);

CREATE TABLE `invites` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `sender_user_id` uuid,
  `recipient_email` varchar(255) NOT NULL,
  `sent_timestamp` timestamp NOT NULL,
  `status` varchar(255)
);

CREATE TABLE `user_data` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `user_id` uuid,
  `data_type` varchar(255) NOT NULL,
  `value` json,
  `timestamp` timestamp NOT NULL
);

CREATE TABLE `widgets` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `user_id` uuid,
  `widget_type` varchar(255) NOT NULL,
  `data` json
);

CREATE TABLE `notifications` (
  `id` int PRIMARY KEY AUTO_INCREMENT COMMENT 'Notification identifier',
  `user_id` uuid COMMENT 'User receiving the notification',
  `notification_type` ENUM ('email', 'push') NOT NULL COMMENT 'Type of notification (email, push, etc.)',
  `message` text NOT NULL COMMENT 'Notification message',
  `read` boolean DEFAULT false COMMENT 'Read status of the notification',
  `created_at` timestamp DEFAULT (now()) COMMENT 'Timestamp when notification was sent'
);

CREATE TABLE `push_notifications` (
  `id` int PRIMARY KEY AUTO_INCREMENT COMMENT 'Push notification identifier',
  `user_id` uuid COMMENT 'User receiving the push notification',
  `content` text COMMENT 'Push notification content',
  `sent_at` timestamp NOT NULL COMMENT 'Timestamp when push notification was sent'
);

CREATE TABLE `activity_logs` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `user_id` uuid,
  `activity_type` varchar(255) NOT NULL,
  `activity_details` json,
  `timestamp` timestamp DEFAULT (now())
);

CREATE TABLE `payments` (
  `id` int PRIMARY KEY AUTO_INCREMENT COMMENT 'Payment identifier',
  `user_id` uuid COMMENT 'User making the payment',
  `organisation_id` uuid COMMENT 'Organisation receiving the payment',
  `amount` decimal(10,2) NOT NULL COMMENT 'Payment amount',
  `currency` varchar(3) NOT NULL COMMENT 'Payment currency code',
  `payment_gateway` ENUM ('stripe', 'flutterwave', 'lemonsqueezy') NOT NULL COMMENT 'Payment gateway used',
  `payment_status` ENUM ('pending', 'completed', 'failed') NOT NULL DEFAULT 'pending' COMMENT 'Payment status',
  `provider_payment_id` varchar(255) COMMENT 'Provider-specific payment identifier',
  `created_at` timestamp DEFAULT (now()) COMMENT 'Timestamp when payment was initiated',
  `updated_at` timestamp DEFAULT (now()) COMMENT 'Timestamp of last update'
);

CREATE TABLE `blogs` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `user_id` uuid,
  `organisation_id` uuid,
  `title` varchar(255) NOT NULL,
  `content` text NOT NULL,
  `created_at` timestamp DEFAULT (now()),
  `updated_at` timestamp DEFAULT (now())
);

CREATE TABLE `charts` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `user_id` uuid,
  `chart_data` json,
  `created_at` timestamp DEFAULT (now())
);

CREATE TABLE `ai_integrations` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `user_id` uuid,
  `integration_type` varchar(255),
  `details` json,
  `created_at` timestamp DEFAULT (now())
);

CREATE TABLE `migrations` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `migration_name` varchar(255) NOT NULL,
  `run_at` timestamp NOT NULL
);

CREATE TABLE `recommendations` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `user_id` uuid,
  `content` text,
  `created_at` timestamp DEFAULT (now())
);

ALTER TABLE `sessions` COMMENT = 'Stores user session information';

ALTER TABLE `password_resets` COMMENT = 'Stores password reset tokens';

ALTER TABLE `roles` COMMENT = 'Stores role information';

ALTER TABLE `user_roles` COMMENT = 'Join table to represent the many-to-many relationship between users and roles';

ALTER TABLE `organisations` COMMENT = 'Stores organisation information';

ALTER TABLE `organisation_users` COMMENT = 'Join table to represent the many-to-many relationship between users and organisations, including roles';

ALTER TABLE `emails` COMMENT = 'Stores information about sent emails';

ALTER TABLE `email_templates` COMMENT = 'Stores pre-designed email templates';

ALTER TABLE `waitlist` COMMENT = 'Stores user information for waitlisted features';

ALTER TABLE `invites` COMMENT = 'Tracks user invitations';

ALTER TABLE `user_data` COMMENT = 'Stores user-specific data points';

ALTER TABLE `widgets` COMMENT = 'Stores information about user-associated widgets';

ALTER TABLE `notifications` COMMENT = 'Stores notification information for users';

ALTER TABLE `activity_logs` COMMENT = 'Stores activity logs for users
          Tracks user actions and app events';

ALTER TABLE `payments` COMMENT = 'Stores payment information';

ALTER TABLE `blogs` COMMENT = 'Stores blog posts';

ALTER TABLE `charts` COMMENT = 'Stores chart data for users';

ALTER TABLE `ai_integrations` COMMENT = 'Stores AI integration information';

ALTER TABLE `migrations` COMMENT = 'Stores migration information';

ALTER TABLE `recommendations` COMMENT = 'Stores recommendation information';

ALTER TABLE `sessions` ADD FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

ALTER TABLE `password_resets` ADD FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

ALTER TABLE `user_roles` ADD FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

ALTER TABLE `user_roles` ADD FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`);

ALTER TABLE `organisation_users` ADD FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

ALTER TABLE `organisation_users` ADD FOREIGN KEY (`organisation_id`) REFERENCES `organisations` (`id`);

ALTER TABLE `organisation_users` ADD FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`);

ALTER TABLE `emails` ADD FOREIGN KEY (`sender_id`) REFERENCES `users` (`id`);

ALTER TABLE `invites` ADD FOREIGN KEY (`sender_user_id`) REFERENCES `users` (`id`);

ALTER TABLE `user_data` ADD FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

ALTER TABLE `widgets` ADD FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

ALTER TABLE `notifications` ADD FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

ALTER TABLE `push_notifications` ADD FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

ALTER TABLE `activity_logs` ADD FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

ALTER TABLE `payments` ADD FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

ALTER TABLE `payments` ADD FOREIGN KEY (`organisation_id`) REFERENCES `organisations` (`id`);

ALTER TABLE `blogs` ADD FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

ALTER TABLE `blogs` ADD FOREIGN KEY (`organisation_id`) REFERENCES `organisations` (`id`);

ALTER TABLE `charts` ADD FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

ALTER TABLE `ai_integrations` ADD FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

ALTER TABLE `recommendations` ADD FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);
