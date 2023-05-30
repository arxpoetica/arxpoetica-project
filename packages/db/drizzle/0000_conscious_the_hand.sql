-- Current sql file was generated after introspecting the database
-- If you want to run this migration please uncomment this code before executing migrations
/*

CREATE TABLE IF NOT EXISTS "accounts" (
	"id" serial PRIMARY KEY NOT NULL,
	"created_at" timestamp DEFAULT 'timezone('utc'::text, now())',
	"updated_at" timestamp DEFAULT 'timezone('utc'::text, now())',
	"name" varchar NOT NULL
);

CREATE TABLE IF NOT EXISTS "accounts_to_users" (
	"account_id" integer NOT NULL,
	"user_id" integer NOT NULL
);
--> statement-breakpoint
ALTER TABLE "accounts_to_users" ADD CONSTRAINT "accounts_to_users_pkey" PRIMARY KEY("account_id","user_id");

CREATE TABLE IF NOT EXISTS "users" (
	"id" serial PRIMARY KEY NOT NULL,
	"created_at" timestamp DEFAULT 'timezone('utc'::text, now())',
	"updated_at" timestamp DEFAULT 'timezone('utc'::text, now())',
	"username" varchar NOT NULL,
	"password" varchar NOT NULL,
	"salt" varchar NOT NULL,
	"role" varchar NOT NULL,
	"first" varchar,
	"last" varchar
);

CREATE TABLE IF NOT EXISTS "posts" (
	"id" serial PRIMARY KEY NOT NULL,
	"created_at" timestamp DEFAULT 'timezone('utc'::text, now())',
	"updated_at" timestamp DEFAULT 'timezone('utc'::text, now())',
	"published_at" timestamp with time zone NOT NULL,
	"headline" varchar NOT NULL,
	"subheadline" varchar,
	"slug" varchar NOT NULL,
	"html" varchar,
	"byline" varchar,
	"linkback" varchar
);

CREATE UNIQUE INDEX IF NOT EXISTS "posts_headline_key" ON "posts" ("headline");
CREATE UNIQUE INDEX IF NOT EXISTS "posts_slug_key" ON "posts" ("slug");
CREATE INDEX IF NOT EXISTS "published_at_index" ON "posts" ("published_at");
DO $$ BEGIN
 ALTER TABLE "accounts_to_users" ADD CONSTRAINT "accounts_to_users_account_id_fkey" FOREIGN KEY ("account_id") REFERENCES "accounts"("id") ON DELETE cascade ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;

DO $$ BEGIN
 ALTER TABLE "accounts_to_users" ADD CONSTRAINT "accounts_to_users_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "users"("id") ON DELETE cascade ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- >>>>
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- >>>> FUNCTIONS
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- >>>>

CREATE OR REPLACE FUNCTION set_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
	NEW.updated_at = (now() AT TIME ZONE 'utc');
	RETURN NEW;
END;
$$ LANGUAGE 'plpgsql';

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- >>>>
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- >>>> TRIGGERS
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- >>>>

CREATE TRIGGER set_accounts_updated_at BEFORE UPDATE ON accounts FOR EACH ROW EXECUTE PROCEDURE set_updated_at_column();
CREATE TRIGGER set_users_updated_at BEFORE UPDATE ON users FOR EACH ROW EXECUTE PROCEDURE set_updated_at_column();
CREATE TRIGGER set_posts_updated_at BEFORE UPDATE ON posts FOR EACH ROW EXECUTE PROCEDURE set_updated_at_column();

*/
