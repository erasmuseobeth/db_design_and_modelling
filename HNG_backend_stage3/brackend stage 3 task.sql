CREATE TABLE "users" (
  "id" int PRIMARY KEY,
  "full_name" varchar,
  "email" varchar UNIQUE,
  "password_hash" varchar,
  "magic_link_token" varchar,
  "social_auth_provider" varchar,
  "language" varchar,
  "region" varchar,
  "created_at" timestamp,
  "updated_at" timestamp
);

CREATE TABLE "organizations" (
  "id" int PRIMARY KEY,
  "name" varchar,
  "created_at" timestamp,
  "updated_at" timestamp
);

CREATE TABLE "user_organizations" (
  "user_id" int,
  "organization_id" int,
  "role" varchar,
  "created_at" timestamp,
  "updated_at" timestamp
);

CREATE TABLE "sessions" (
  "id" int PRIMARY KEY,
  "user_id" int,
  "token" varchar,
  "expires_at" timestamp
);

CREATE TABLE "password_resets" (
  "id" int PRIMARY KEY,
  "user_id" int,
  "token" varchar,
  "expires_at" timestamp
);

CREATE TABLE "messages" (
  "id" int PRIMARY KEY,
  "user_id" int,
  "subject" varchar,
  "body" text,
  "sent_at" timestamp,
  "status" varchar
);

CREATE TABLE "payments" (
  "id" int PRIMARY KEY,
  "user_id" int,
  "amount" decimal,
  "currency" varchar,
  "provider" varchar,
  "provider_payment_id" varchar,
  "status" varchar,
  "created_at" timestamp
);

CREATE TABLE "settings" (
  "id" int PRIMARY KEY,
  "user_id" int,
  "setting_name" varchar,
  "setting_value" varchar,
  "created_at" timestamp,
  "updated_at" timestamp
);

CREATE TABLE "superadmins" (
  "id" int PRIMARY KEY,
  "user_id" int,
  "created_at" timestamp
);

CREATE TABLE "activity_logs" (
  "id" int PRIMARY KEY,
  "user_id" int,
  "activity_type" varchar,
  "activity_details" text,
  "created_at" timestamp
);

CREATE TABLE "contact_us" (
  "id" int PRIMARY KEY,
  "user_id" int,
  "message" text,
  "created_at" timestamp
);

CREATE TABLE "gdpr_cookies" (
  "id" int PRIMARY KEY,
  "user_id" int,
  "consented" boolean,
  "consented_at" timestamp
);

CREATE TABLE "dashboards" (
  "id" int PRIMARY KEY,
  "user_id" int,
  "widgets" text,
  "created_at" timestamp
);

CREATE TABLE "waitlist" (
  "id" int PRIMARY KEY,
  "email" varchar UNIQUE,
  "joined_at" timestamp
);

CREATE TABLE "marketing_pages" (
  "id" int PRIMARY KEY,
  "title" varchar,
  "content" text,
  "created_at" timestamp
);

CREATE TABLE "invites" (
  "id" int PRIMARY KEY,
  "user_id" int,
  "invitee_email" varchar,
  "status" varchar,
  "sent_at" timestamp
);

CREATE TABLE "invite_links" (
  "id" int PRIMARY KEY,
  "user_id" int,
  "link" varchar,
  "created_at" timestamp
);

CREATE TABLE "language_region" (
  "id" int PRIMARY KEY,
  "user_id" int,
  "language" varchar,
  "region" varchar,
  "created_at" timestamp
);

CREATE TABLE "email_templates" (
  "id" int PRIMARY KEY,
  "name" varchar,
  "subject" varchar,
  "body" text,
  "created_at" timestamp,
  "updated_at" timestamp
);

CREATE TABLE "migrations" (
  "id" int PRIMARY KEY,
  "migration_name" varchar,
  "run_at" timestamp
);

CREATE TABLE "activity_log" (
  "id" int PRIMARY KEY,
  "user_id" int,
  "activity_type" varchar,
  "activity_details" text,
  "created_at" timestamp
);

CREATE TABLE "push_notifications" (
  "id" int PRIMARY KEY,
  "user_id" int,
  "content" text,
  "sent_at" timestamp
);

ALTER TABLE "user_organizations" ADD FOREIGN KEY ("user_id") REFERENCES "users" ("id");

ALTER TABLE "user_organizations" ADD FOREIGN KEY ("organization_id") REFERENCES "organizations" ("id");

ALTER TABLE "sessions" ADD FOREIGN KEY ("user_id") REFERENCES "users" ("id");

ALTER TABLE "password_resets" ADD FOREIGN KEY ("user_id") REFERENCES "users" ("id");

ALTER TABLE "messages" ADD FOREIGN KEY ("user_id") REFERENCES "users" ("id");

ALTER TABLE "payments" ADD FOREIGN KEY ("user_id") REFERENCES "users" ("id");

ALTER TABLE "settings" ADD FOREIGN KEY ("user_id") REFERENCES "users" ("id");

ALTER TABLE "superadmins" ADD FOREIGN KEY ("user_id") REFERENCES "users" ("id");

ALTER TABLE "activity_logs" ADD FOREIGN KEY ("user_id") REFERENCES "users" ("id");

ALTER TABLE "contact_us" ADD FOREIGN KEY ("user_id") REFERENCES "users" ("id");

ALTER TABLE "gdpr_cookies" ADD FOREIGN KEY ("user_id") REFERENCES "users" ("id");

ALTER TABLE "dashboards" ADD FOREIGN KEY ("user_id") REFERENCES "users" ("id");

ALTER TABLE "invites" ADD FOREIGN KEY ("user_id") REFERENCES "users" ("id");

ALTER TABLE "invite_links" ADD FOREIGN KEY ("user_id") REFERENCES "users" ("id");

ALTER TABLE "language_region" ADD FOREIGN KEY ("user_id") REFERENCES "users" ("id");

ALTER TABLE "activity_log" ADD FOREIGN KEY ("user_id") REFERENCES "users" ("id");

ALTER TABLE "push_notifications" ADD FOREIGN KEY ("user_id") REFERENCES "users" ("id");
