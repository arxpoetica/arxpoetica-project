import {
	index,
	uniqueIndex,
	serial,
	integer,
	timestamp,
	pgTable,
	varchar,
	primaryKey,
} from 'drizzle-orm/pg-core'

export const accounts = pgTable('accounts', {
	id: serial('id').primaryKey().notNull(),
	createdAt: timestamp('created_at', { mode: 'string' }).default(`timezone('utc'::text, now())`),
	updatedAt: timestamp('updated_at', { mode: 'string' }).default(`timezone('utc'::text, now())`),
	name: varchar('name').notNull(),
})

export const accountsToUsers = pgTable('accounts_to_users', {
	accountId: integer('account_id').notNull().references(() => accounts.id, { onDelete: 'cascade' } ),
	userId: integer('user_id').notNull().references(() => users.id, { onDelete: 'cascade' } ),
},
(table) => {
	return {
		accountsToUsersPkey: primaryKey(table.accountId, table.userId)
	}
})

export const users = pgTable('users', {
	id: serial('id').primaryKey().notNull(),
	createdAt: timestamp('created_at', { mode: 'string' }).default(`timezone('utc'::text, now())`),
	updatedAt: timestamp('updated_at', { mode: 'string' }).default(`timezone('utc'::text, now())`),
	username: varchar('username').notNull(),
	password: varchar('password').notNull(),
	salt: varchar('salt').notNull(),
	role: varchar('role').notNull(),
	first: varchar('first'),
	last: varchar('last'),
})

export const posts = pgTable('posts', {
	id: serial('id').primaryKey().notNull(),
	createdAt: timestamp('created_at', { mode: 'string' }).default(`timezone('utc'::text, now())`),
	updatedAt: timestamp('updated_at', { mode: 'string' }).default(`timezone('utc'::text, now())`),
	publishedAt: timestamp('published_at', { withTimezone: true, mode: 'string' }).notNull(),
	headline: varchar('headline').notNull(),
	subheadline: varchar('subheadline'),
	slug: varchar('slug').notNull(),
	html: varchar('html'),
	byline: varchar('byline'),
	linkback: varchar('linkback'),
},
(table) => {
	return {
		headlineKey: uniqueIndex('posts_headline_key').on(table.headline),
		slugKey: uniqueIndex('posts_slug_key').on(table.slug),
		publishedAtIdx: index('published_at_index').on(table.publishedAt),
	}
})
