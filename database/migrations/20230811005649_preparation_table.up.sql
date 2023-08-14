CREATE TABLE
    IF NOT EXISTS `admin` (
        `id` int NOT NULL AUTO_INCREMENT,
        `email` varchar(100) DEFAULT NULL,
        `password` varchar(250) DEFAULT NULL,
        `type` tinyint(1) DEFAULT NULL,
        `active` tinyint(1) DEFAULT NULL,
        PRIMARY KEY (`id`)
    ) ENGINE = InnoDB AUTO_INCREMENT = 0 DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;

CREATE TABLE
    IF NOT EXISTS `auto_reply_message` (
        `id` int NOT NULL AUTO_INCREMENT,
        `user_id` int NOT NULL,
        `title` varchar(255) NOT NULL,
        `sender_number` varchar(35) NOT NULL,
        `trigger_type` tinyint(1) NOT NULL,
        `trigger_conditional` mediumtext,
        `text_message` text NOT NULL,
        `attachment_image` text,
        `footer_message` text,
        `quick_reply_1` text,
        `quick_reply_2` text,
        `quick_reply_3` text,
        `frequency` int NOT NULL,
        `enable_away_message` tinyint(1) DEFAULT NULL,
        `away_message_text` text,
        `away_message_attachment_image` text,
        `away_message_start_time` varchar(15) DEFAULT NULL,
        `away_message_end_time` varchar(15) DEFAULT NULL,
        `publish` tinyint(1) NOT NULL,
        PRIMARY KEY (`id`)
    ) ENGINE = InnoDB AUTO_INCREMENT = 0 DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;

CREATE TABLE
    IF NOT EXISTS `auto_responder` (
        `id` int NOT NULL AUTO_INCREMENT,
        `user_id` int DEFAULT NULL,
        `name` text,
        `description` text,
        PRIMARY KEY (`id`)
    ) ENGINE = InnoDB AUTO_INCREMENT = 0 DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;

CREATE TABLE
    IF NOT EXISTS `auto_responder_template` (
        `id` int NOT NULL AUTO_INCREMENT,
        `auto_responder_id` int DEFAULT NULL,
        `day` int DEFAULT NULL,
        `message` text,
        `file` text,
        PRIMARY KEY (`id`),
        KEY `auto_responder_id` (`auto_responder_id`),
        CONSTRAINT `auto_responder_template_ibfk_1` FOREIGN KEY (`auto_responder_id`) REFERENCES `auto_responder` (`id`) ON DELETE CASCADE
    ) ENGINE = InnoDB AUTO_INCREMENT = 0 DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;

CREATE TABLE
    IF NOT EXISTS `chat_gpt` (
        `id` int NOT NULL AUTO_INCREMENT,
        `user_id` varchar(45) NOT NULL,
        `question` text NOT NULL,
        `question_token` int DEFAULT NULL,
        `answer` text NOT NULL,
        `answer_token` int DEFAULT NULL,
        `date` datetime NOT NULL,
        PRIMARY KEY (`id`)
    ) ENGINE = InnoDB AUTO_INCREMENT = 0 DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;

CREATE TABLE
    IF NOT EXISTS `coupon` (
        `id` int NOT NULL AUTO_INCREMENT,
        `code` varchar(25) NOT NULL,
        `expiry_date` datetime NOT NULL,
        `discount_percentage` int DEFAULT NULL,
        `max_discount_percentage` int DEFAULT NULL,
        `discount_price` int DEFAULT NULL,
        `max_daily_limit` int DEFAULT NULL,
        `max_total_limit` int DEFAULT NULL,
        `max_usage_per_user` int DEFAULT NULL,
        `usage_packages_id` text,
        `active` int DEFAULT NULL,
        `secret_coupon` tinyint(1) DEFAULT NULL,
        `admin_only` tinyint(1) DEFAULT NULL,
        `coupon_user_type` tinyint(1) DEFAULT NULL,
        `coupon_generation_type` tinyint(1) DEFAULT NULL,
        PRIMARY KEY (`id`),
        UNIQUE KEY `code` (`code`)
    ) ENGINE = InnoDB AUTO_INCREMENT = 0 DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;

CREATE TABLE
    IF NOT EXISTS `device` (
        `id` bigint NOT NULL,
        `user_id` int NOT NULL,
        `name` varchar(45) NOT NULL,
        `number` varchar(30) DEFAULT NULL,
        `status` varchar(45) DEFAULT NULL,
        `last_broadcast_at` datetime DEFAULT NULL,
        `last_server_connected` text,
        PRIMARY KEY (`id`)
    ) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;

CREATE TABLE
    IF NOT EXISTS `device_log` (
        `id` int NOT NULL AUTO_INCREMENT,
        `device_id` bigint DEFAULT NULL,
        `code` int DEFAULT NULL,
        `message` text,
        `date` datetime DEFAULT NULL,
        `last_server_connected` varchar(45) DEFAULT NULL,
        PRIMARY KEY (`id`)
    ) ENGINE = InnoDB AUTO_INCREMENT = 0 DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;

CREATE TABLE
    IF NOT EXISTS `group_contact` (
        `id` int NOT NULL AUTO_INCREMENT,
        `name` text,
        `user_id` int DEFAULT NULL,
        `created_at` datetime DEFAULT NULL,
        `updated_at` datetime DEFAULT NULL,
        PRIMARY KEY (`id`)
    ) ENGINE = InnoDB AUTO_INCREMENT = 0 DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;

CREATE TABLE
    IF NOT EXISTS `group_contact_form` (
        `id` int NOT NULL AUTO_INCREMENT,
        `group_contact_id` int NOT NULL,
        `device_id` bigint DEFAULT NULL,
        `auto_responder_id` int DEFAULT NULL,
        `title` varchar(200) NOT NULL,
        `description` text NOT NULL,
        `unique_phone_number` int NOT NULL,
        `link_form` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
        `redirect_url` varchar(200) NOT NULL,
        `fields` mediumtext NOT NULL,
        `active` tinyint(1) NOT NULL,
        PRIMARY KEY (`id`),
        UNIQUE KEY `UNIQUE` (`link_form`),
        KEY `FK_GROUP_CONTACT_ID_idx` (`group_contact_id`),
        CONSTRAINT `FK_GROUP_CONTACT_ID` FOREIGN KEY (`group_contact_id`) REFERENCES `group_contact` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
    ) ENGINE = InnoDB AUTO_INCREMENT = 0 DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;

CREATE TABLE
    IF NOT EXISTS `group_contact_participant` (
        `group_contact_id` int DEFAULT NULL,
        `phone_number` varchar(20) DEFAULT NULL,
        `name` text,
        `email` varchar(80) DEFAULT NULL,
        `gender` varchar(25) DEFAULT NULL,
        `domicile` text,
        `created_at` datetime DEFAULT NULL,
        `custom_attr_id` text,
        KEY `FK_GROUP_CONTACT_ID_idx` (`group_contact_id`),
        CONSTRAINT `FK_GROUP_CONTACT_ID_idx` FOREIGN KEY (`group_contact_id`) REFERENCES `group_contact` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
    ) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;

CREATE TABLE
    IF NOT EXISTS `group_contact_participant_custom_attr` (
        `group_contact_id` int NOT NULL,
        `custom_attr_id` text NOT NULL,
        `attr_name` varchar(50) NOT NULL,
        `attr_value` text,
        `attr_position` tinyint(1) DEFAULT NULL
    ) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;

CREATE TABLE
    IF NOT EXISTS `outgoing_message` (
        `id` int NOT NULL AUTO_INCREMENT,
        `user_id` int NOT NULL,
        `sender_number` varchar(15) NOT NULL,
        `destination_number` varchar(55) DEFAULT NULL,
        `is_group` tinyint(1) DEFAULT NULL,
        `group_name` text,
        `text_message` text,
        `file_url` text,
        `date_schedule` datetime DEFAULT NULL,
        `date_sent` datetime DEFAULT NULL,
        `status` tinyint(1) DEFAULT NULL,
        `publish_key` varchar(100) DEFAULT NULL,
        `schedule_id` int DEFAULT NULL,
        `subscription_group_id` int DEFAULT NULL,
        PRIMARY KEY (`id`)
    ) ENGINE = InnoDB AUTO_INCREMENT = 0 DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;

CREATE TABLE
    IF NOT EXISTS `outgoing_message_cron_status` (
        `outgoing_message_id` int NOT NULL,
        `status` tinyint(1) NOT NULL,
        `created_at` datetime DEFAULT NULL,
        `updated_at` datetime DEFAULT NULL,
        PRIMARY KEY (`outgoing_message_id`)
    ) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;

CREATE TABLE
    IF NOT EXISTS `package` (
        `id` int NOT NULL AUTO_INCREMENT,
        `name` varchar(255) NOT NULL,
        `tagline` varchar(150) NOT NULL,
        `type` tinyint(1) NOT NULL,
        `price` int NOT NULL,
        `duration` int DEFAULT NULL,
        `limit_blast` int DEFAULT NULL,
        `limit_device` int DEFAULT NULL,
        `limit_contact_participant` int DEFAULT NULL,
        `active` tinyint(1) DEFAULT NULL,
        `feature_locked` text,
        `affiliate_first_percentage` int DEFAULT NULL,
        `affiliate_next_percentage` int DEFAULT NULL,
        PRIMARY KEY (`id`)
    ) ENGINE = InnoDB AUTO_INCREMENT = 0 DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;

CREATE TABLE
    IF NOT EXISTS `quick_reply_message` (
        `id` int NOT NULL AUTO_INCREMENT,
        `user_id` int NOT NULL,
        `reply_name` varchar(150) NOT NULL,
        `reply_message` text,
        `time_to_send` varchar(45) DEFAULT NULL,
        PRIMARY KEY (`id`)
    ) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;

CREATE TABLE
    IF NOT EXISTS `schedule` (
        `id` int NOT NULL AUTO_INCREMENT,
        `user_id` int NOT NULL,
        `sender_number` varchar(25) NOT NULL,
        `category` tinyint(1) NOT NULL,
        `date` datetime NOT NULL,
        `status` tinyint(1) NOT NULL,
        PRIMARY KEY (`id`)
    ) ENGINE = InnoDB AUTO_INCREMENT = 0 DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;

CREATE TABLE
    IF NOT EXISTS `segmentation_rule` (
        `id` int NOT NULL AUTO_INCREMENT,
        `user_id` int NOT NULL,
        `name` text NOT NULL,
        `rule` text,
        PRIMARY KEY (`id`)
    ) ENGINE = InnoDB AUTO_INCREMENT = 0 DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;

CREATE TABLE
    IF NOT EXISTS `setting` (
        `id` int NOT NULL AUTO_INCREMENT,
        `name` text NOT NULL,
        `description` text,
        `active` tinyint(1) NOT NULL,
        PRIMARY KEY (`id`)
    ) ENGINE = InnoDB AUTO_INCREMENT = 0 DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;

CREATE TABLE
    IF NOT EXISTS `subscription_group` (
        `id` int NOT NULL AUTO_INCREMENT,
        `group_name` varchar(45) NOT NULL,
        `group_type` varchar(70) DEFAULT NULL,
        PRIMARY KEY (`id`)
    ) ENGINE = InnoDB AUTO_INCREMENT = 0 DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;

CREATE TABLE
    IF NOT EXISTS `template` (
        `id` int NOT NULL AUTO_INCREMENT,
        `user_id` int DEFAULT NULL,
        `name` varchar(150) DEFAULT NULL,
        `text` mediumtext,
        PRIMARY KEY (`id`)
    ) ENGINE = InnoDB AUTO_INCREMENT = 0 DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;

CREATE TABLE
    IF NOT EXISTS `transaction` (
        `id` int NOT NULL AUTO_INCREMENT,
        `user_id` int NOT NULL,
        `package_id` int NOT NULL,
        `coupon_id` int DEFAULT NULL,
        `coupon_code` varchar(45) DEFAULT NULL,
        `total_price` int NOT NULL,
        `date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
        `order_id` varchar(50) DEFAULT NULL,
        `paid_status` tinyint(1) DEFAULT NULL,
        `transaction_type` tinyint(1) DEFAULT NULL,
        `payment_method` tinyint(1) DEFAULT NULL,
        `payment_channel` varchar(100) DEFAULT NULL,
        `payment_date` datetime DEFAULT NULL,
        `contributor` text,
        `affiliate_id` int DEFAULT NULL,
        `affiliate_paid_status` tinyint(1) DEFAULT NULL,
        `affiliate_percentage` int DEFAULT NULL,
        `affiliate_paid_date` datetime DEFAULT NULL,
        PRIMARY KEY (`id`),
        KEY `FK_TRANSACTION_PACKAGE_ID_idx` (`package_id`),
        CONSTRAINT `FK_TRANSACTION_PACKAGE_ID_idx` FOREIGN KEY (`package_id`) REFERENCES `package` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
    ) ENGINE = InnoDB AUTO_INCREMENT = 0 DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;

CREATE TABLE
    IF NOT EXISTS `user_api_key` (
        `user_id` int NOT NULL,
        `api_key` varchar(50) DEFAULT NULL,
        PRIMARY KEY (`user_id`)
    ) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;

CREATE TABLE
    IF NOT EXISTS `user_package` (
        `id` int NOT NULL AUTO_INCREMENT,
        `user_id` int NOT NULL,
        `package_id` int NOT NULL,
        `created_at` datetime DEFAULT NULL,
        `expired_at` datetime DEFAULT NULL,
        `status` tinyint(1) DEFAULT NULL,
        PRIMARY KEY (`id`)
    ) ENGINE = InnoDB AUTO_INCREMENT = 0 DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;

CREATE TABLE
    IF NOT EXISTS `sesterdamp` (
        `id` bigint NOT NULL,
        `name` varchar(45) NOT NULL,
        PRIMARY KEY (`id`)
    ) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;