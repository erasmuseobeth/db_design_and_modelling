CREATE TABLE `Categories` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `name` varchar(255)
);

CREATE TABLE `Media` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `title` varchar(255),
  `description` text,
  `category_id` int,
  `file_path` varchar(255),
  `file_type` varchar(255),
  `file_size` int,
  `uploaded_at` datetime
);

CREATE TABLE `Users` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `username` varchar(255),
  `email` varchar(255),
  `password` varchar(255)
);

CREATE TABLE `Comments` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `media_id` int,
  `user_id` int,
  `content` text,
  `created_at` datetime
);

CREATE TABLE `Likes` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `media_id` int,
  `user_id` int,
  `liked_at` datetime
);

CREATE TABLE `Playlists` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `user_id` int,
  `name` varchar(255)
);

CREATE TABLE `PlaylistMedia` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `playlist_id` int,
  `media_id` int
);

CREATE TABLE `Favorites` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `user_id` int,
  `media_id` int
);

CREATE TABLE `WatchHistory` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `user_id` int,
  `media_id` int,
  `watched_at` datetime
);

CREATE TABLE `UserMedia` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `user_id` int,
  `media_id` int
);

CREATE TABLE `UserThumbnails` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `user_id` int,
  `thumbnail_url` varchar(255)
);

ALTER TABLE `Media` ADD FOREIGN KEY (`category_id`) REFERENCES `Categories` (`id`);

ALTER TABLE `Comments` ADD FOREIGN KEY (`media_id`) REFERENCES `Media` (`id`);

ALTER TABLE `Comments` ADD FOREIGN KEY (`user_id`) REFERENCES `Users` (`id`);

ALTER TABLE `Likes` ADD FOREIGN KEY (`media_id`) REFERENCES `Media` (`id`);

ALTER TABLE `Likes` ADD FOREIGN KEY (`user_id`) REFERENCES `Users` (`id`);

ALTER TABLE `Playlists` ADD FOREIGN KEY (`user_id`) REFERENCES `Users` (`id`);

ALTER TABLE `PlaylistMedia` ADD FOREIGN KEY (`playlist_id`) REFERENCES `Playlists` (`id`);

ALTER TABLE `PlaylistMedia` ADD FOREIGN KEY (`media_id`) REFERENCES `Media` (`id`);

ALTER TABLE `Favorites` ADD FOREIGN KEY (`user_id`) REFERENCES `Users` (`id`);

ALTER TABLE `Favorites` ADD FOREIGN KEY (`media_id`) REFERENCES `Media` (`id`);

ALTER TABLE `WatchHistory` ADD FOREIGN KEY (`user_id`) REFERENCES `Users` (`id`);

ALTER TABLE `WatchHistory` ADD FOREIGN KEY (`media_id`) REFERENCES `Media` (`id`);

ALTER TABLE `UserMedia` ADD FOREIGN KEY (`user_id`) REFERENCES `Users` (`id`);

ALTER TABLE `UserMedia` ADD FOREIGN KEY (`media_id`) REFERENCES `Media` (`id`);

ALTER TABLE `UserThumbnails` ADD FOREIGN KEY (`user_id`) REFERENCES `Users` (`id`);
